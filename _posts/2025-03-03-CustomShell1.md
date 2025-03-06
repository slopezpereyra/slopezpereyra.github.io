---
title: Writing a shell in C from scratch 
categories: [Science]
---

# Introduction

Writing a shell is an excellent way to learn about syscalls, standard
input/output streams, and recursive parsing of bytestreams. The shell explained
in this entry provides limited functionality. It is capable of program
execution, sequenced command execution, and piping. The most interesting aspect
of the shell is the handling of the `pipe` and `fork` syscalls within a
recursive scheme (binary trees).


# Basics

To program a shell, we need to wait for user input through `stdin` and, once
said input is given, parse it accordingly. For simplicity, we will only allow
two types of commands in our shell: simple executable commands, which we term
`execcmd`, and pipe commands, which we term `pipecmd`. 

The "waiting" algorithm is simple to write and will function as the main
procedure in our shell.

```c
void shell(){
  char* cmd;
  printf("MyBash : ");
  while (1){
    cmd = read_stdin(); // This function waits for stdin
    if ( cmd  == NULL ) {
      printf("Error reading cmd");
      break;
    }
    tree_parse(cmd);
  }
  free(cmd);
}
```

The `read_stdin()` function is simple:

```c
char* read_stdin(void) {
    fflush(stdout);

    char *buffer = NULL;  
    size_t buf_size = 0;  
    ssize_t len;

    len = getline(&buffer, &buf_size, stdin); // Read a line from stdin

    if (len == -1) { // Handle EOF or error
        printf("Reached EOF or read error\n");
        free(buffer);
        return NULL;
    }

    return buffer;  // The caller is responsible for freeing `buffer`
}
```


The `ssize_t getline(char **restrict lineptr, size_t *restrict n,
FILE *restrict stream)` function reads entire lines from `stream` and stores
them in `lineptr`. In our case, it will read from `stdin` and allocate in
`buffer`. Since `buffer` is set to `NULL` before the call to `getline`, the
latter function will iteslf `malloc` the necessary memory.

The `tree_parse()` function used in `shell()` is a bit more complex and we will
discuss it later. For the moment, suffice it to say it is in charge of
interpreting the input buffer as a binary tree and deciding what and how to
execute.


### Command types

The instruction inputted by the user can be simple or composite. A simple
instruction is a program name followed by arguments or flags, like `ls`, `ls -l`, or
`cat filename`. A composite instruction is a set of instructions joint by one or
more of the following operators: the pipeline operator `|` and the semicolon
operator `;`. 

If two commands are joint by the pipe operator, the output of the first command
must serve as input for the second. If two commands are joined by the semicolon
operator, the first command must be executed and, once it terminates, the
second command must be executed.

The operator `|` has precedence over `;`, which means an
instruction like 

```
simple_command_1 | simple_command_2 ; simple_command_3
```

must first deal with the execution of `simple_command_1 | simple_command 2` and
then execute `simple_command_3`. This should be sufficient to suggest a tree
representation of the command line arguments. For instance,

``` 
                                  cmd_1 | cmd_2 ; cmd_3
                                            / \
                                           /   \
                                          /     \
                                         /       \
                                        /         \
                                       /           \
                                      /             \
                                 cmd_1 | cmd_2     cmd_3
                                      / \
                                     /   \
                                    /     \
                                   /       \
                                  /         \
                                 /           \
                                /             \
                              cmd_1           cmd_2
``` 

Execution can then be recursively computed from the leaves (the simple commands)
upwards, with precedence of left-hand branches before right-hand ones. Of
course, the parent of each pair of nodes specifies the rule which is to be
followed in the execution of the nodes. For instance, when two nodes are
parented by a pipeline command, the output of the first must serve as input for
the second, and correspondingly when the parent is a `;`-separated command.

To make such tree representation effective, we will specify the following
abstract data types.

```c
#ifndef CMDS_H
#define CMDS_H


#define ABSTRACT -1
#define EXEC 0
#define YUX 1 // Yuxtaposed commands: ";" operator.
#define PIPE 2
#define MAX_ARGS 10

typedef unsigned int cmd_type;

struct pipecmd {
  cmd_type type;
  struct execcmd *left;
  char *right;
};

struct execcmd {
  cmd_type type;
  unsigned int n_args;
  char* argv[MAX_ARGS + 1];
};

struct execcmd *init_exec_cmd();
struct pipecmd *init_pipe_cmd();
cmd_type parse_abstract_cmd(char* buff);

#endif // CMDS_H
```

Here, `execcmd`s represent the simplest type of command: a program name
(`argv[0]`) plus flags `argv[1], argv[2], ...`. `pipecmd`s, on another hand,
contain an executable command to the left and simply a bytestream to the right.


> In the parsing of any pipe, the left side is always a program whose output must
serve as input to the right-hand program, but the right-hand program itself
could be a simple command or could be another pipe (e.g. `cmd_1 | cmd_2 |
cmd_3`). For that reason, the `right` field of a `pipecmd` is not predefined as
any type of command: it is a bytestream that must be parsed and dealt with
according to its content.

Since the execution of commands separated by a
semi-colon `;` is as simple as executing them in linear order, we don't really
need to specify an abstract representation of them: we'll parse them linearly
from the `stdin` stream. However, we *could* in principle program a new `cmd`
type with `left` and `right` fields corresponding to `;`-separated commands.


# 1: Execution, forking and the *pipe* syscall

I assume the reader is familiarized with the fundamental `fork()` syscall, one
of the strangest and prettiest of its lot. Thus, I will provide the function
which executes an `execcmd` without much explanation:


```c
int execute_cmd(struct execcmd *cmd){

  char* program = (cmd -> argv)[0];

  if (program == NULL) exit(0);
  if ( strcmp(program, "exit") == 0 ) exit(1);

  int status;
  pid_t pid = fork();

  if ( pid == 0 ){
    if ( execvp(program, cmd->argv) == -1 ){
      printf("Failed to execute...\n");
      exit(EXIT_FAILURE);
    }
  }else if ( pid < 0 ){
      printf("Failed to fork...\n");
  }else{
    waitpid(pid, &status, WUNTRACED);
    while (!WIFEXITED(status) && !WIFSIGNALED(status));
  }

  return 1;

}
```

More interesting is the recursive execution of piped commands. As pointed out
earlier, the left child of a `pipecmd` node is an `execcmd`, but the right
child is a `char *` bytestream. This allows us to decompose chained pipes like 
`cmd1 | cmd2 | cmd3 | cmd4 | ...` recursively. 

``` 
                            cmd_1 | cmd_2 | cmd_3 (pipecmd)
                                      / \
                                     /   \
                                    /     \
                                   /       \
                                  /         \
                                 /           \
                                /             \
                      cmd_1 (execcmd)   "cmd_2 |cmd_3" (bytestream)
                                                 / \
                                                /   \
                                               /     \
                                              /       \
                                             /         \
                                            /           \
                                           /             \
                                     cmd_2 (execcmd)  cmd_3 (execcmd)
```

The representation above gives an example of what the execution of a `pipecmd`
looks like. First, the left-hand `execcmd` is executed and its result is written
on standard input via the `pipe()` syscall. Then, the right-hand byte stream
is parsed into a `pipecmd` itself, which once again produces a call to execute
its left-hand side as an `execcmd`. The result of this execution is once again
written on `stdin`. Lastly, since the right-hand leaf contains no piping
operator, it is interpreted as an `execcmd` and executed, with its output not
being redirected.  

The code for this recursive execution must use the `pipe()` syscall. The
`pipe()` syscall is quite interesting: it stores in an `int pipefds[2]` array
the file descriptors of the read (`pipefds[0]`) and write (`pipefds[1]`) ends of
a kernel-level buffer. This buffer, which is the `pipe` in question,
serves as a unidirectional communication channel between two processes, where
process $B$ can read what process $A$ has written on it. 

The basic logic of piping two commands `cmd_1 | cmd_2` is this: create a
`pipe()` and `fork()` the process, call some `exec` syscall for `cmd_1` in the
child process reading from standard input and redirecting its output to the
write end of the pipe. Thus, the kernel buffer referred to by the pipe will
contain the result of `cmd_1`. Once the child process terminates, `fork()` again
to `exec` the `cmd_2` command, but redirect `stdin` to the read end of the pipe.
Thus, `cmd_2` will receive its input from the output of `cmd_1`.

The logic above is simple but I made some abstractions. Firstly, one must make
sure to `close()` the read/write ends of the pipe once their use is done.
Secondly, since `stdin` is redirected, one must restore it to its original value
once the process above is completed. The code that makes use of this logic in
our recursive scheme is below.

```c 
int execute_pipeline(struct pipecmd *pipe_cmd){

  int pipefds[2];
  int pipe_code = pipe(pipefds);
  int status;
  int original_stdin = dup(STDIN_FILENO);  // dup stdin to lowest available file descriptor

  char* left_pipe_program = ( pipe_cmd -> left ) -> argv[0];
  char* right_pipe_buffer = pipe_cmd -> right;
  if (left_pipe_program == NULL || right_pipe_buffer == NULL) exit (1);
  cmd_type right_pipe_type = parse_abstract_cmd(right_pipe_buffer);


  pid_t pid = fork();

  if (pid < 0) exit(0);

  if (pid == 0){// Child, execute left hand side and write output to write end of pipe.

    close(pipefds[0]);
    dup2(pipefds[1], STDOUT_FILENO);
    close(pipefds[1]);
    if ( execvp(left_pipe_program, (pipe_cmd -> left)->argv) == -1 ){
      printf("Failed to execute...\n");
      exit(EXIT_FAILURE);
    }

    // Parent: wait for child termination, then check if the node is another pipe or not. 
    // If it is, make a recursive call; if it's not, execute it.
  }else{ 
    close(pipefds[1]);
    dup2(pipefds[0], STDIN_FILENO);
    close(pipefds[0]);
    waitpid(pid, &status, WUNTRACED);
    if (WIFEXITED(status)) {
      printf("Child process exited with status %d\n", WEXITSTATUS(status));
    } else if (WIFSIGNALED(status)) {
      printf("Child process terminated by signal %d\n", WTERMSIG(status));
    }

    // Base case of recursion
    if (right_pipe_type == EXEC){
      struct execcmd *right_cmd = parse_exec_cmd(right_pipe_buffer);
      // The second `fork()` call is done within `execute_cmd()`.
      execute_cmd(right_cmd);
    }
    // Recursive case
    else{
      struct pipecmd *right_pipe = parse_pipe_cmd(right_pipe_buffer);
      execute_pipeline(right_pipe);
    }

  }
  dup2(original_stdin, STDIN_FILENO);  // restore stdin to original
  close(original_stdin);  
  return 1;
}
```

Importantly, before calling this function, we will need to save the original
file descriptor for standard input: since this stream will be redirected to the
read end of the `pipe()` during the function's execution, we'll need to restore
it afterwards. So a call to this function should look like this:

Thus, given `execcmd` or `pipecmd` struct pointers, we already have functions
capable of executing the instructions associated to these data types. All that's
left is to write the *parsing* end of the shell, i.e. the procedures that will
read standard input, determine what kind of commands are there, initialize the
`execcmd` or `pipecmd` structs accordingly in a binary tree representation, and
recursively call their execution.


# 2: Parsing 

We will define a few simple functions here. This functions are rather
straightforward and should be easy to comprehend with a careful read assisted by
the comments.

```c 
// Determines the type of a command buffer.
cmd_type parse_abstract_cmd(char* buff){

  bool is_pipe = false;
  for (int i = 0; buff[i] != '\0'; i++){
    if ( buff[i] == ';' ){
      return YUX;
    }
    if ( buff[i] == '|' && !is_pipe){
      is_pipe = true;
    }
  }

  if (is_pipe)  return PIPE;
  return EXEC;

}


//
// Tokenize a buffer splitting it into space-separated tokens 
// and initialize an execcmd struct pointer.
//
struct execcmd * parse_exec_cmd(char* buffer){

  struct execcmd *cmd = init_exec_cmd();
  char *cur_token = strtok(buffer, " ");

  while (cur_token != NULL){
    if (( cmd -> n_args ) > MAX_ARGS){
      printf("Exceeded maximum number of tokens\n");
      exit(0);
    }
    (cmd -> argv)[cmd->n_args] = cur_token;
    (cmd -> n_args)++;
    cur_token = strtok(NULL, " ");
  }

  //for (unsigned int i = 0; i < cmd -> n_args + 1; i++){
  //  printf("Argument %d : %s\n", i, (cmd->argv)[i]);
  //}

  return cmd;
}
 
// Parse a buffer with yuxtaposed commands, i.e. commands separated by a
// semicolon. This function comprises the recursive call of `tree_parse`.
void parse_yux_cmd(char *buff){
  int i = 0;
  while (buff[i] != '\0'){

    if (buff[i] == ';'){
      // We use pointer arithmetic: ';' is separated by '\0' and two new
      // pointers to the same memory block `buff` are given: one pointing at the
      // beginning of the block, one pointing exactly after '\0'.
      buff[i] = '\0';
      char * node_left = buff;
      char * node_right = buff + i + 1;
      tree_parse(node_left);
      tree_parse(node_right);
      return;
    }
    i++;
  }
}

// Parse the command buffer of a piped command, initializing a 
// pipecmd struct pointer.
struct pipecmd *parse_pipe_cmd(char *buff){
  
  struct pipecmd *pcmd = init_pipe_cmd();

  for (int i = 0; buff[i] != '\0'; i++){
    if (buff[i] == '|'){
      buff[i] = '\0';
      pcmd -> left = parse_exec_cmd(buff);
      pcmd -> right = buff + i + 1;
      break;
    }
  }
  return pcmd;
}

```

Let us construct the parser which effectively makes the tree representation of
the `stdin` stream.

```c 

// Recursive parsing of stdin into tree representation.
void tree_parse(char *buff){

  // Just making sure bytestream terminates in null-terminating stream.
  int l = strlen (buff);
  if (l > 0 && buff [l - 1] == '\n') buff [l - 1] = '\0';

  // Detect the type of the command in the stream.
  cmd_type t = parse_abstract_cmd(buff);

  // Recursive case 1:
  if (t == YUX){
    // Calls tree_parse recursively on each node:
    // this is a recursive call!
    parse_yux_cmd(buff);
    return;
  }
  
  // Recursive case 2:
  // If the stream is a pipe, execute it using the recursive tree representation of 
  // pipe commands. This effectively expands the tree for the case of pipes.
  if (t == PIPE){
    struct pipecmd *execution_cmd =  parse_pipe_cmd(buff);
    execute_pipeline(execution_cmd);
    printf("My Bash: ");
    return;
  }

  // Base case:
  // If the stream is a simple command, simply execute it.
  struct execcmd *execution_cmd =  parse_exec_cmd(buff);
  execute_cmd(execution_cmd);
//  struct pipecmd *execution_cmd =  parse_pipe_cmd(buff);
  printf("My Bash: ");
      
}
```
## Testing the shell 

This is the result of running `ls; ls | wc -l; ls | wc -l | factor`.

```
My Bash: ls; ls | wc -l; ls | wc -l | factor
'~'	  cmds.h       executer.h   notes.txt   parser.h   shell.c
 cmds.c   executer.c   mybash	    parser.c    read_cmd
My Bash: Child process exited with status 0
11
My Bash: Child process exited with status 0
Child process exited with status 0
11: 11
```

We see that `MyBash` effectivle calls `ls`, printing my files; then it calls `ls
| wc -l`, outputting `11`, and then it executes `ls | wc -l | factor`, which
indeed displays all factors of `11` (this is, `11: 11`, only itself).




















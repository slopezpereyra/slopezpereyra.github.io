---
title: Aprendiendo Linux programando un intérprete
categories: [Science]
---

# Introduction

I wrote a simple shell in C. These entry is simply a more elaborated version of
my own notes while writing the code, accompanied by the code itself. It could
assist people trying to learn about syscalls and low-level programming,
particularly those interested in shell development and the manner in which the
`pipe` and `fork` calls can be handled in recursive schemes (binary trees).

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
    cmd = read_stdin();
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
FILE *restrict stream)` function reads entire lines from `stream` and stores it
in `lineptr`. In our case, it will read from `stdin` and allocate in `buffer`.
Since `buffer` is set to `NULL` before the call to `getline`, the latter
function will iteslf `malloc` the necessary memory.

The `tree_parse()` function used in `shell()` is a bit more complex and we will
discuss it later. For the moment, suffice it to say it is in charge of
interpreting the input buffer as a bianry tree and deciding what and how to
execute the user's instructions.


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
then execute `simple_command_3`.

This should be sufficient to suggest a tree representation of the command line
arguments. For instance,

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
                              cmd_1           cmd_3
``` 

Execution can then be recursively computed from the leafs (the simple commands)
upwards. Of course, the parent of each pair of nodes specifies the rule which is
to be followed in the execution of the nodes. When  two nodes are parented by a
pipeline command, the output of the first must serve as input for the second,
and correspondingly when the parent is a `;`-separated command.

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
(`argv[0]`) plus flags `argv[1], argv[2], ...`. `pipecmd`s, on another hand, are
a pair of executable commands piped in such a way that the output of the first
acts as the input of the second. Since the execution of commands separated by a
semi-colon ';' is as simple as executing them in linear order, we don't really
need to specify an abstract representation of them: we'll parse them linearly
from the `stdin` stream.

Let us define parsing functions specific to each of this `cmd` types; i.e.
functions which can read a parent node of the tree

# 1: Execution, forking and the `pipe` function

Let us assume we can parse a byte stream and detect what kind of command it
holds: a piped command or a simple execution command.

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

More interesting is the recursive execution of piped commands. As you may have
observed, the left child side of a `pipecmd` node is an `execcmd`, but the right
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
                      cmd_1 (as execcmd)   "cmd_2 |cmd_3" (byte stream)
                                                    / \
                                                   /   \
                                                  /     \
                                                 /       \
                                                /         \
                                               /           \
                                              /             \
                                            cmd_2 (as execcmd)  cmd_3 (as execcmd)
``` 

The representation above gives an example of what the execution of a `pipecmd`
looks like. First, the left-hand `execcmd` is executed and its result is written
on standard input via the `pipe()` command. Then, the right-hand byte stream
is parsed into a `pipecmd` itself, which once again produces a call to execute
its left-hand side as an `execcmd`. The result of this execution is once again
written on `stdin`. Lastly, since the right-hand leaf contains no piping
operator, it is also interpreted as an `execcmd` and executed, with its output
not being redirected.  

The code for this recursive execution is as follows:

```c 
int execute_pipeline(struct pipecmd *pipe_cmd){

  int pipefds[2];
  int pipe_code = pipe(pipefds);
  int status;

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
      execute_cmd(right_cmd);
    }
    // Recursive case
    else{
      struct pipecmd *right_pipe = parse_pipe_cmd(right_pipe_buffer);
      execute_pipeline(right_pipe);
    }

  }
  return 1;
}
```



# 1: Parsing 

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

  if (t == YUX){
    // Calls tree_parse recursively on each node:
    // this is a recursive call!
    parse_yux_cmd(buff);
    return;
  }

  // If the stream is a pipe, execute it using the recursive tree representation of 
  // pipe commands. This effectively expands the tree for the case of pipes.
  if (t == PIPE){
    struct pipecmd *execution_cmd =  parse_pipe_cmd(buff);
    int original_stdin = dup(STDIN_FILENO);  // Save original stdin
    execute_pipeline(execution_cmd);
    dup2(original_stdin, STDIN_FILENO);  // Restore stdin to original
    close(original_stdin);  
    printf("My Bash: ");
    return;
  }

  // If the stream is a simple command, simply execute it. This is the 
  // base case of the recursive call.
  struct execcmd *execution_cmd =  parse_exec_cmd(buff);
  execute_cmd(execution_cmd);
//  struct pipecmd *execution_cmd =  parse_pipe_cmd(buff);
  printf("My Bash: ");
      
}
```
## Testing the shell 

This is the result of running ``

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




















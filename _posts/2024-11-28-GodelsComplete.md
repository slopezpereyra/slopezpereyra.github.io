---
title: Gödel's completeness theorem
categories: [ Science ]
---


> This entry provides a succinct overview of what Gödel's completeness theorem is
about. My purpose is to write an overview sufficiently simple for a reader with
little experience in logic to comprehend. This is *not* a technical writing:
no proofs are given and fundamental concepts (e.g. first order type, first order
theory, etc.) are only schematically described. For a more advanced covering of
these subjects, visit the *Logics* document in the *Studies* section of this
site.

Gödel's incompleteness theorem is a foundational piece of mathematical logic.
Mathematical logic concerns itself with the mathematical description of
mathematics - it is mathematics describing itself. 

Mathematicians prove things. A proof is to the mathematician what a
note is to the musician. As the musician combines notes to form chords, and these
are in turn organized in harmonic progressions, and from this organization the
beauty of music emerges, the mathematicians too combine their proofs, use them
to derive new ones, and from these workings of the mind truth, or at least a
glimpse of it, arises. But what is a proof?

The question "what is a proof?" has many possible answers, but to the hammer
everything is a nail, and thus the mathematician, in almost
primitive and brute fashion, attempts to answer it mathematically. He searches
for a mathematical description of a proof, one mathematical enough so that we
may in turn prove things about it.

Perhaps the most widely known mathematical model of a proof is *natural
deduction*, developed by
Gentzen[^1]. Suffices to
mention that natural deduction is a rigorous proof system, with rules so clear
that a computer could verify. Given axioms $\varphi_1, \ldots, \varphi_n$, natural 
deduction systematizes the operations which our intuitive understanding of deduction 
considers valid to perform with these axioms.

It should be emphasized that a proof system, insofar as it provides only
rules to manipulate symbols, is a syntactic object. In a sense, if we were to 
define a language $\mathcal{L}$ with the usual logical symbols ($\land, \lor,
\forall, \neg$, etc.), with its words satisfying the syntax of logics (e.g. 
$\varphi \land \phi$ is in $\mathcal{L}$, but $\varphi \land$ is not),
a proof system could be considered as a function $f : \mathcal{L}^+ \to \mathcal{L}^+$ - 
this is, a mapping from valid logical sentences to other valid logical
sentences. There is no such thing as *meaning* and not a glimpse of *truth values*.
Only grammar.

In particular, in the mathematician's daily life, the alphabet of logic is
complemented with other symbols which describe constants, functions and
relations. These symbols are dependent of an interpretation: the letter $\pi$
may refer to the ratio of a circle's circumference to its diameter, but it
could also be used to define a function $\pi : A \to B$, or whatever else we
wanted. The symbols which complement those of logic in a particular context 
are provided in what is termed a *first order type*.

A *first order type* $\tau$ contains three sets of symbols: *constants*,
*functions* and *relations*, and each of the symbols in these sets possesses
some arity. First order types, in combination with logical sentences and
symbols in $\mathcal{L}$, provide a complete alphabet and syntax for the
generation of sentences which can be interpreted mathematically. 

> *Example*. Assume the set of constants in $\tau$ is $\\{ a, aa, aaa, aaaa, \ldots \\}$,
> the set of relationships is $\\{ \leq \\}$, and the other sets are empty. Assume the 
arity of $\leq$ is $2$. Then we
> could produce the $\tau$-dependent sentence "$aa \leq aaa \land \varphi \neq \phi$".

The symbols in a first order type $\tau$ are imbued with meaning through what
is called a *model*. A *model* of $\tau$ is made up of a set (e.g. $\mathbb{R}$) and an
interpretation of each symbol in $\tau$.  

> *Example*. Assume the set of constants in $\tau$ is $\\{ a, aa, aaa, aaaa, \ldots \\}$,
> the set of relationships is $\\{ \leq \\}$, and the other sets are empty. Assume 
the arity of $\leq$ is $2$. Then a model with set $A = \mathbb{N}$
that interprets $\overbrace{a \ldots a}^{n \text{ times}}$ as $n$, and that interprets 
$\leq$ as $\\{ (a, b) : a \mid b \\}$, essentially corresponds to the poset $(\mathbb{N}, \mid)$.

Given a model, we need to rigorously define when a sentence $\varphi$ will be
true or not. Sentences usually contain variable names, and thus their truth value
does not depend only on how we interpret the symbols in $\varphi$ (i.e. on the
model), but also on what values we assign to the variables. We will not discuss
how assignments of values to variables work, and we will assume there is a
rigorous way to evaluate a logical sentence under a model given an assignment.
In other words, we will assume we have defined a rigorous and non-ambiguous way to declare 
"$\varphi$ is true/false when the variables $x_1, \ldots, x_n$ take on the values $a_1, \ldots, a_n$,
under the interpretation given by model $M$ of the symbols in $\varphi$".

We thus arrive at the concept of a theory. A theory is a set of *general*
sentences depending on a first order type $\tau$. By *general* I mean that
these sentences do not contain the name of constants. The sentences in a theory
are pure in the sense that, under whatever model of $\tau$, they will never
speak of specific elements, but will make general statements about what is true
or false. 

> *Example*. Assume the set of constants in $\tau$ is $\\{ a, aa, aaa, aaaa, \ldots
> \\}$, the set of relationships is $\\{ \leq \\}$, and the other sets are
> empty. Assume the arity of $\leq$ is $2$. Then a theory would never contain a sentence 
> of the form $aa \leq aaa$, because that speaks of particular elements, but it could 
> contain a sentence of the form: $\forall x, y: (x \leq y \land y \leq x) \implies x = y$.

We will use $(\Sigma, \tau)$ to refer to a theory whose axioms (sentences) are in $\Sigma$ and 
which depends on the first order type $\tau$.

We are almost ready to describe the Gödel's completeness theorem. As a last
preliminary, we must only point out that the theory we have developed allows for two
related, yet different kinds of entailment. One is *syntactic entailment*,
meaning the production of symbols within a proof system, and the other 
is *semantic entailment*, meaning the determination that a sentence is true 
as a consequence of the truth value of other sentences.

If a proof system allows us to deduce $\varphi$ from the statements in a theory
$(\Sigma, \tau)$, we say $(\Sigma, \tau) \vdash \varphi$. Recall that proof
systems are entirely syntactic: $(\Sigma, \tau) \vdash \varphi$ equates to
saying "the grammar of our proof system (whatever it may be) allows us to
derive $\varphi$ from the symbols in $\Sigma$".

On the other hand, if under all possible models (interpretations) of a first
order type, the truth of the axioms in $\Sigma$ entails that $\varphi$ is true,
we write $(\Sigma, \tau) \vDash \varphi$. This is a semantic entailment: we are
not speaking of symbol manipulation, but about truth evaluation. We are saying:
"under any interpretation (semantics) of the symbols of our language, $\varphi$
logically follows from the axioms in $\Sigma$".

The question which Gödel's theorem answers is a troubling one. Under a given theory
$(\Sigma, \tau)$, many statements will conceivably be true. But are they always
provable through a rigorous prove system? In other words, if something is true,
can we guarantee that we can prove it, where "prove it" has a rigorous and
systematic definition under a system of proof? 

It is conceivable that, given a system of proof such as *natural deduction*,
tomorrow, or in a century, a mathematician may think of a clever deduction rule
which our system does not incorporate. Such rule could potentially allow us to
prove new things, things that are true but we could not prove before. In short, it is conceivable
that our proof system is incomplete.

What Gödel proved is that this imagination, though conceivable, is not the case.
The theorem states, in a short and brief line, that *whatever is true under a theory
can be proven through a system of proof*. In other words, that

$$
(\Sigma, \tau) \vDash \varphi \implies (\Sigma, \tau) \vdash \varphi
$$

for any theory $(\Sigma, \tau)$ and any logical sentence $\varphi$. The theorem
thus ensures a tight and tranquilizing link between th e*semantics* and the
*syntax* of mathematics, assuring us that whatever is semantically true under a
theory is provable under such theory.










---



[^1] Gentzen's heart did not raise to the status of his mind: he was a Nazi 
and died in a prison camp after being detained during the Prague uprising.

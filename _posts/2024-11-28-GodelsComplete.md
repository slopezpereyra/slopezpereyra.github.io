---
title: Gödel's completeness theorem (for non-specialized readers)
categories: [ Science ]
---


> This entry provides a succinct overview of what Gödel's completeness theorem is
about. My purpose is to write an overview sufficiently simple for a reader with
little experience in logic to comprehend. This is *not* a technical writing:
no proofs are given and fundamental concepts (e.g. first order type, first order
theory, etc.) are only schematically described. For a more advanced covering of
these subjects, visit the *Logics* document in the *Studies* section of this
site.

Gödel's completeness theorem is a foundational piece of mathematical logic.
Mathematical logic concerns itself with the mathematical description of
mathematics - it is mathematics describing itself. 

Mathematicians prove things. A proof is to the mathematician what a
note is to the musician. As the musician combines notes to form chords, and these
are in turn organized in harmonic progressions, and from this organization the
beauty of music emerges, mathematicians too combine their proofs, use them
to derive new ones, and from these workings of the mind truth, or at least a
glimpse of it, arises. But what is a proof?

The question "what is a proof?" has many possible answers. But everything is a
nail in the eyes of a hammer, and thus the mathematician, in almost primitive
and brute fashion, attempts to answer it mathematically. He searches for a
mathematical description of a proof, one mathematical enough so that we may in
turn prove things about it.

The first to formalize the concept of a proof in respectable fashion was Frege.
Any formalization, as Frege noted, had to provide a system of rules which
accurately captured all reasonable rules of deduction (e.g. modus ponens,
*reductio ad absurdum*, etc.). All systems of rules developed after Frege where
either refinements of his system or entirely equivalent to it, so it is safe to
say Frege's formalization of what a proof was is still the one accepted by all
mathematicians. 

One of the most widely known models of proof is *natural deduction*, developed by
Gentzen[^1]. Natural deduction is a rigorous proof system, with rules so clear
that a computer could verify. Given axioms $\varphi_1, \ldots, \varphi_n$,
natural deduction systematizes the operations which our intuitive understanding
of deduction considers valid to perform with these axioms. It is equivalent to 
Frege's system, but somewhat more formal. Natural deduction is nice because it
allows proofs to be written as trees, which suggests at least intuitively two 
mathematical facts which I cannot discuse in detail here: namely, that any proof 
is a lattice, and that propositional sentences conform an [interesting Boolean algebra](https://en.wikipedia.org/wiki/Lindenbaum%E2%80%93Tarski_algebra).

It should be emphasized that a proof system, insofar as it provides only rules
to manipulate symbols, conforms a syntax. In a sense, if we were to define a
language $\mathcal{L}$ with the usual logical symbols ($\land, \lor, \forall,
\neg$, etc.), with its words satisfying the syntax of logics (e.g. $\varphi
\land \phi$ is in $\mathcal{L}$, but $\varphi \land$ is not), a proof system
could be considered as a function $f : \mathcal{L}^+ \to \mathcal{L}^+$ - this
is, a mapping from valid logical sentences to other valid logical sentences.
There is no such thing as *meaning* and not a glimpse of *truth values*. Only
grammar.

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

Providing a powerful enough grammar so as to produce the language of
mathematics, however, is not enough. It is necessary to study the truth value
of sentences produced with that grammar. It was Tarski who provided a complete
description of how to specify, in formal fashion, the semantics of the language
of mathematics. In particular, the symbols in a first order type $\tau$ are
imbued with meaning through what is called a *model*. A *model* of $\tau$ is
made up of a set (e.g. $\mathbb{R}$) and an interpretation of each symbol in
$\tau$.  

> *Example*. Assume the set of constants in $\tau$ is $\\{ a, aa, aaa, aaaa, \ldots \\}$,
> the set of relationships is $\\{ \leq \\}$, and the other sets are empty. Assume 
the arity of $\leq$ is $2$. Then a model with set $A = \mathbb{N}$
that interprets $\overbrace{a \ldots a}^{n \text{ times}}$ as $n$, and that interprets 
$\leq$ as $\\{ (a, b) : a \mid b \\}$, essentially corresponds to the poset $(\mathbb{N}, \mid)$.

Given a model, a rigorous definition is given of what is meant when we say a
sentence $\varphi$ is true or false. Sentences usually contain variable names,
and thus their truth value does not depend only on how we interpret the symbols
in $\varphi$ (i.e. on the model), but also on what values we assign to the
variables. I will not discuss how the assignment of values to variables works: 
it suffices to say that Tarski provided a rigorous and non-ambiguous
way to declare "$\varphi$ is true/false when the variables $x_1, \ldots, x_n$
take on the values $a_1, \ldots, a_n$, under the interpretation given by model
$M$ of the symbols in $\varphi$".

With syntax and semantics at hand, logicians were ready to tackle what they
(rightly) deemed to be the fundamental problem of mathematics. Namely, given 
a set of axioms, how can we provide a mathematical characterization of the 
system that is derived from those axioms? We thus arrive arrive at the concept
of a theory. 

A theory is a set of *general* sentences depending on a first
order type $\tau$. By *general* I mean that these sentences do not contain the
name of constants. The sentences in a theory are pure in the sense that, under
whatever model of $\tau$, they will never speak of specific elements, but will
make general statements about what is true or false. 

> *Example*. Assume the set of constants in $\tau$ is $\\{ a, aa, aaa, aaaa, \ldots
> \\}$, the set of relationships is $\\{ \leq \\}$, and the other sets are
> empty. Assume the arity of $\leq$ is $2$. Then a theory would never contain a sentence 
> of the form $aa \leq aaa$, because that speaks of particular elements, but it could 
> contain a sentence of the form: $\forall x, y: (x \leq y \land y \leq x) \implies x = y$.

We will use $(\Sigma, \tau)$ to refer to a theory whose axioms (sentences) are
in the set $\Sigma$ and whose formulas use symbols given by the first order type $\tau$.

The characterization of a theory, along with syntactic and semantic devices,
allows us to specify two different kinds of entailments. If a proof system allows us to deduce $\varphi$ from the statements in a theory
$(\Sigma, \tau)$, we say $(\Sigma, \tau) \vdash \varphi$. Recall that proof
systems are entirely syntactic: $(\Sigma, \tau) \vdash \varphi$ equates to
saying "the grammar of our proof system (whatever it may be) allows us to
derive $\varphi$ from the symbols in $\Sigma$". On the other hand, if under all
possible models (interpretations) of a first order type, the truth of the
axioms in $\Sigma$ entails the truth of $\varphi$, we write $(\Sigma, \tau)
\vDash \varphi$. This is a semantic entailment: we are not speaking of symbol
manipulation, but about truth evaluation. We are saying: "under any
interpretation (semantics) of the symbols of our language, $\varphi$ is true
if the axioms in $\Sigma$ are true".

To get a sense of how general the question which Gödel's theorem answers is,
consider first this analogue question, more philosophical in question. Assume
there is something in the world that is true - take this to be as simple a
truth as you want. Does it follow, from the fact that it is true, that you can 
express it in your language? In other words, can our language express everything 
that is true, or are there truths out there that are ineffable? (Gödel answers 
the reverse of this question too: namely, if something can be expressed in our language,
does it follow that it is true? But this question lacks philosophical interest, since 
the statement is obviously false.) 

Let us now consider the mathematical version of this question, which is the one 
which Gödel answered. Assuming we have some theory $(\Sigma, \tau)$, along with 
a system of proof, can be we sure that everything that is true can be deduced from 
our rules? In other words, if something is true, can we guarantee that we can
prove it, where "prove it" has a rigorous and systematic definition under a
system of proof? The question is important because it is conceivable that,
given a system of proof such as *natural deduction*, tomorrow, or in a century,
a mathematician may think of a clever deduction rule which our system does not
incorporate. Such rule could potentially allow us to prove new things, things
that are true but we could not prove before. Or even worse, it is conceivable 
that our system of proof effectively captures all reasonable deduction rules,
and yet still there are true things which it cannot prove - suggesting there is 
an inherent limit to logical deduction itself. 

What Gödel proved is that these imaginations, though conceivable, are not the
case. The theorem states, in a short and brief line, that *whatever is true
under a theory can be proven through a system of proof*. In other words, that

$$
(\Sigma, \tau) \vDash \varphi \implies (\Sigma, \tau) \vdash \varphi
$$

His correctness theorem proved the inverse relation: 

$$
(\Sigma, \tau) \vdash \varphi \implies (\Sigma, \tau) \vDash \varphi
$$

meaning that, if a proposition is deduced from our system of proof, then such
proposition is true (i.e. the system of deduction is correct). These theorems
hold for any theory $(\Sigma, \tau)$ and any logical sentence $\varphi$. The theorems
thus ensures a tight association between the *semantics* and the *syntax* of
first order logic, assuring us that whatever is semantically true under a
theory is provable under such theory.

Gödel's famous *incompleteness* theorem proved that, when we move beyond first 
order logic and incorporate arithmetic to the question - i.e. when we start to 
talk about the natural numbers instead of just logical formulas - then our 
systems become incomplete. In other words, there are statements about the natural 
numbers which are semantically true, but which cannot be proven. This paradoxical 
result demolished the logicist program initiated by Frege and forwarded by Russell,
Whitehead, Peano, and such. But this result is beyond the scope of this entry.










---



[^1]: Gentzen's heart did not raise to the status of his mind: he was a Nazi 
and died in a prison camp after being detained during the Prague uprising.

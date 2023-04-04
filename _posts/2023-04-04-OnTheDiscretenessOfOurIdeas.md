---
title: On the discreteness of our ideas 
categories : [ Science ]
---

Assume, for the moment, that every idea is a distinct object defined by its
content and its particular relation to other ideas. Under this conception, the
set of your ideas is a discrete and ordered set, and the complexity of such set
is a reflection of the complexity of your thought. It makes no difference to say
the relation between ideas is inherent to their content, and thus independent of
our perception of them, or determined by our explicit formulation of them. Such
discussion falls in the same category as the falling tree that no one hears.

Since, under this view, ideas are discrete and ordered sets, the whole of our
ideas on any particular subject has an associated Hasse diagram. Such diagram
would show the order-related properties of our conception of the matter. For
example, a lattice would result of a conception such that no pair
of ideas was left unconnected both to common premises and common conclusions, or
at least to common antecedents and consequents —a reflection of elaborated
thought. 

Furthermore, a complemented lattice would be such that to every idea there is a
corresponding complementary opposite: an independent conception that nonetheless
arrives at the same conclusion. In other words, a complemented lattice
is associated to those sets of ideas where independent trains of thought flow from
the elementary to the conclusive thoughts.

<p align="center">
  <img src="https://i.ibb.co/s1jPH2V/Screenshot-from-2023-04-04-15-32-54.png"/>
</p>

The general conception described above finds its pragmatic complement in a
particular note-taking system. Such system consists of writing short, individual
ideas in separate entries and encoding them with only two properties: an
arbitrary form of identification, and a list of all ideas to which that idea
associates. The result is —once more— a discrete set of connected elements. A
partially ordered set, sensible to many a variety of graph representations.

An essential property of the above conception is that it
allows for a general thought structure to arise by itself. One is allowed to
consider atomic ideas with little regard to a general conception of the subject,
concerned only with observing, upon elaborating an atomic thought, to which few
other atoms such thought is bonded. This microscopic approach to thought builds
up to produce elaborate systems of interconnected elements, which one discovers
only when sufficient individual atoms have been deposited. In this way,
we do not impose a structure on the subject of our inquiry, but rather allow
ourselves to discover a structure inherent to it via the slow
accumulation of individual, bonded elements. It is, so to speak, a
*generative* approach to thought organization.

I am obliged to clarify a point related to those assumptions without which the
whole of our conception falls apart. To conceive a set of ideas as a partially
ordered set, with an associated Hasse diagram, one must regard the connection
between ideas to be reflexive, transitive, and anti-symmetric. While reflexivity
and transitivity are naturally granted, anti-symmetry is not an obvious
property. Who is to say, if a certain idea $\pi$ connects to a different idea
$\tau$, that $\tau$ can not in turn be connected to $\pi$? In fact, such seems
to be the general case. The idea "the abolishment of private ownership of
the means of production is good" connects to "capitalist production is
based on unfair exploitation", but the latter connects to the first just as
naturally.

However, this confusion is a consequence of our loose use of the term
"connects". When dealing with our system, we will assume ideas are
anti-symmetric. If $\pi \preceq \tau$ means "the idea $\pi$ relates to the idea
$\tau$", then $\pi \preceq \tau$ and $\tau \preceq \pi$ implies $\tau = \pi$. In
practical terms, this means we conceive the set of ideas to be
*directed*: a train of thought flowing from minimal ideas
*towards* intermediate and final ideas. It becomes clear then that $\pi
\preceq \tau$, while meaning $\pi$ connects to $\tau$, expresses a determined
type of connection, which one may call "begets".

In some cases, such as our example above, $\pi \preceq \tau$ and $\tau \preceq
\pi$ differ only in that they depict the particular way in which such thread was
formed in our minds. In other cases, such as inferences or deductions, $\pi
\preceq \tau$ and $\tau \preceq \pi$ are semantically incompatible. 

We can, of course, dispose of this convention, and disregard anti-symmetry.
Then, instead of dealing with partially order sets $(I, \preceq)$, we deal with
graphs $(I, E)$, where the structure of a general conception is still an
emergent property of the individual ideas. I venture that some sets of ideas
—for example, ethical ideas— are necessarily partially ordered sets (i.e.,
necessarily anti-symmetric). But this is not the place to elaborate on this
opinion.

I should wish to provide a programmed implementation of this system. On top, I
wish to write a program that produces the Hasse diagram of a given set of
thoughts. At the end, I will provide an example of how the system would work
with ideas sprouting from my own research, as well as insights deriving from the
Hasse diagram.




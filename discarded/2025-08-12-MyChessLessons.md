---
title: Chess notebook
categories: [Chess]
---

> After studying a game, I ask myself: what have I learned from this game? Here
> I annotate the answers to this questions.



# Marshall - Capablanca, NY Match 1909, Game 6

### Lesson 1: Do not overestimate a threat, or on ghost imagination

After White's 9th move Bg5, we have the following position.

<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/37hDO11q#17" frameborder=0></iframe>
{% endraw %}
</div>

My first thought is that Black should castle, but there is the obvious threat of 

10.dxc5 Bxc5 11.Bxf6, removing a defender of the d5 pawn. Here I thought that
Black faced the unpleasent decision of gxf6, ruining the structure, or Qxf6,
"loksing a pawn". But I should have looked one move further into the position.
After 11...Qxf6 12.Nxd5 Black has Qxb2, equalizing material, and one must ask
what is the resulting situation.

The knight on d5 threatens nothing, the center has opened up completely, and
Black has the B-pair. So this variation gives nothing to fear, and I saw a
ghost. A ghost that would have led me to play defensively when not in need to do
so.

Also instructve is Capablanca's freeing response 9...Ne4! Though the variation
I gave with 9...O-O leads to good play, it is clear what White is the one
exerting pressure. 9...Ne5 forces the trade of at least a few pieces.


### Lesson 2: Keep in mind what changes in the position after each move.

When facing the position below:

<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/37hDO11q#21" frameborder=0></iframe>
{% endraw %}
</div>

I could see that Nxd4 was promising, liquidating White's center, but I didn't
like the "variation":

11...Nx4 12.Nxe4 dxe4 13.Bxe4, because I've lost both of my knights, being left
with my passive LSB. I should have very strongly kept in mind that after Nxd4,
the e5 knight is undefended and susceptible to discoveries. Therefore, the line
I gave would end with Bh3 by Black, winning a piece. These are the kind of
tactics that I see in an instant when at the board, but failt to visualize when
three or more moves deep into calculation.

I must strengthen my notion of what changes after each move in a position during
calculation. It is something natural to me move by move, when actual changes are
made on the board, but I am weaker at it when I am visualizing changes in my
mind.

### Lesson 3: You should be more paranoid

This seems contradictory, because lesson 1 was about not seeing ghosts. But
lesson 1 was more directed to examining variations a bit more ccarefully and
deeply before regarding them as bad. This lesson has to do with being aware of
what are my opponent's goals.

In the following position

<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/37hDO11q#39" frameborder=0></iframe>
{% endraw %}
</div>

White play the move Bf3, to which I payed little attention. I suggested Black
should continue with his plan, playing a5. Had I asked what my opponent's
intention was, perhaps I would have found the right move. 

The main supporter of Black's queenside advance is the Be6. If White trades it,
a5-b4 will be hard because White can set up a defense with Rac1. Thus, White
wants to play Bg4 and trade bishops. Clearly, Black's immediate problem is that
the trade cannot be avoided: he can't play the desired Bd5. 
So the correct move is Rfd8.

This move addresses the immediate issue, making White's plan impossible, while
also taking hold of the open d-file. 

### Lesson 4: Do not rush, improve your position slowly, build ip. 

Black to move in the following position.


<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/37hDO11q#45" frameborder=0></iframe>
{% endraw %}
</div>

Capablanca played the beautiful move 23...g6!. I suggested a5 (again).

The reasoning, as far as I understand it, goes as follows. Clearly, Black must
play a5 eventually. However, there is no way for White to prevent this advance,
and Black has all the time in the world to improve his position. The move g6
improves the position greatly:

- It allows Bf5, which may be useful in some continuations 
- It gives the king some breathing room, so the rook is free to leave the last
rank without worries about Qa8+.
- It threatens Bd5, winning a piece, forcing White to dislodge his queen from
its centralized position. 

### Lesson 5: Concreteness 

In the previous diagram, after 24.Qc6, I calculated Qd6 thoroughly. I was under
the impression that Qxd6 Rxd6 favors Black. I was able to see that Qxb5 did not
work so the b-pawn is safe. Thus, I thought this was a great move: seizing
control of the file, keeping the b-pawn safe, if White trades I am better.

However, the engine thinks the position after 24...Qd6 25.Qxd6 Rxd6 is slightly
favorable for Black, but nothing compared to what it was. A loss of advantage
occurred. 

I reasoned thus: Black has control of the open file, Black is close to creating
a passed pawn with a queenside majority, Black's better. And this is true. But
one has to be *concrete*. After the trades, White has 26.Rc2, and the question
is: how are we to make progress? It is unclear how the passed pawn will be
created. If 26...a5 White simply begins to centralize his king. The resulting
position is unclear.

The engine gives Capablanca's move: 24...Qe5!, centralizing the queen, defending
b5. After 25.Qe4 now Black trades! 25...Qxe4 26.Bxe4. Why now? Strategic
considerations are almost the same: Black controls the d-file, has a queenside
majority, etc. But the position is *concretely* different, because now White's
bishop stands on e4, allowing Rd1+! In other words, in the position resulting
now, Black's rook can activate and infiltrate into White's position!



# Capablanca - Marhsall, Wilkes-Barre match (8), 1909

### Lesson 1: Creation of weaknesses

The following position was reached:


<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/LKR1srER#26" frameborder=0></iframe>
{% endraw %}
</div>

Several elements are to be pointed out. $(1)$ Black has queenside weaknesses,
but it is hard to exploit them on their own. White needs to create more
weaknesses. $(2)$ White's development is harmonious and active, while Black's
rooks are out of play. The bishops being in front of the king inspires some
tactical motifs. $(3)$ White must play actively without allowing consolidation. 


The correct move is 14.Ng5!, looking to create a weaknesses on e6. To
approeciate how fargile Black's positions is, imagine it was White to move again
after Ng5. Then exd5 followed by either Rxe6 (an exchange sacrifice) or Nxe6
gives White a winning advantage.

Note as well that Black cannot take the e-pawn. If 14...dxe4 White has the very
active 15.Qg3, with a discovered attack on the queen. Depending on where the
Black queen goes, White can respond with natural looking moves. For instance, if
Black's queen goes to c8 in order to recapture on e6 with the queen, White has
Bd6 and Black has no satisfactory response. If Black's queen retreats to b6,
then Nxe6 followed by Qxg7 is brutal.

Black cannot ignore the central tension either, because White is ready to play
exd5 himself. So the response d4 is essentially forced, with the following
position resulting:



<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/LKR1srER#30" frameborder=0></iframe>
{% endraw %}
</div>

It is clear that Black must play e5 to stabilize, and that White should prevent
this if possible. Black is in time to do so: after 16.Na4 he should reply with
the  natural Nd7. This move defends c5 and prepares e5, so now 17.Qc4 is met
with 17...e5 18.Bd2. Perhaps Marshall was worried about not being able to
castle, since White's QC4 controls g8. However, it seems that Black can play
Rf8-Rf7 followed by Kf8. White is clearly better, since he has no weaknesses and
Black has at least 3 (a6, c5, e5). White also has the superior minor pieces:
White's knight on c4 will outpower Black's, not to mention the passivity of
Black's bishop. But anyhow, this was not the course chosen by Marshall.



### Lesson 2: Optimial piece positioning 

Consider this position:

<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/LKR1srER#30" frameborder=0></iframe>
{% endraw %}
</div>

I think it is not hard to see where each piece belongs in this position.

(1) The knight on c4, controlling e5 and d6, is optimally placed. 

(2) The bishop on d6, from where it'd work in coordination with the c4 knight,
exerts pressure on the kingside and fixes the e6-weakness.

(3) The queen on h3, pressuring e6 and also pressuring the kingside.

Five or six moves later, Capablanca reaches the following position:


<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/LKR1srER#41" frameborder=0></iframe>
{% endraw %}
</div>

This is very instructive. If one considers the first diagram, it should be clear
that nothing but the *pawn structure* is the key to piece positioning.
Everything follows from it.




# Capablanca - Bernstein, San Sebastian 1911

### Don't rush.


The following equal position was reached.

<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/Bdef98xB#24" frameborder=0></iframe>
{% endraw %}
</div>

Capablanca first improves the position via Qd3 and Rad1, which is normal. Qd3 is
logical because it gives the queen the 3rd rank and also suggests ideas such as
Qa6, pressuring the b7 and c6 weaknesses.


### Piece coordination

A few moves later:


<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/Bdef98xB#32" frameborder=0></iframe>
{% endraw %}
</div>

Here I suggested the immediate Nf5. It is not a bad move, but the two knights
aren't coordinated. Once one sees Capablanca's move: 17.Nce2!, one immediately
comprehends its superiority. Now both knights operate together and play an
active role in the center.



### More on build-up

In the position below, it is not that simple to find a move for White. Both
knights are excellently placed. The queen can hardly be improved (20.Qg3 is met
by g6 and White has little.) The rooks are perfectly placed. 

<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/Bdef98xB#38" frameborder=0></iframe>
{% endraw %}
</div>

Capablanca improved via 20.g4! followed by the solid f3. The engine does not
approve, but that means little in this case. 

The engine's suggestion is also interesting. It gives 20.c3!?, threatening b4.
The diagram above has the engine-recommended line, where White wins an exchange.


### Piece activity 

In the following position, again it is unclear how White is supposed to keep
improving.

<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/Bdef98xB#42" frameborder=0></iframe>
{% endraw %}
</div>

Capablanca found the energetic plan of transfering the Nd4 to h5 via 22.Ne2. He
gave up two pawns for the tempo needed to materialize this.


# 

### An excercise on visualization

Consider the following position.

<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/tRu0epDQ#28" frameborder=0></iframe>
{% endraw %}
</div>

Nd5 begs to be played, but its consequences ought to be evaluated thoroughly
before doing so. As an excercise, one might do so looking at the position as is
now and understanding what follows. 

(1) The knight cannot be allowed to remain there, due to the execssive pressure
on Black's Nf6. 

(2) So, the straight line is 15.Nd5 Bxd5 16.exd5 Nb8 (only knight retreat which
makes sense).

In this position: $(a)$ White's Qc2 and Nf3 exert direct pressure on Black's e5
pawn. $(b)$ The Bc2's diagonal has been opened and h7 is now a potential
vulnerability. $(c)$ Black's Nf6 remains pinned and White's d5 pawn is securely
protected. $(d)$ Black's Bc5 is unprotected. $(e)$ Black's rooks are disconnected.

In such a position, it is not easy to augment the pressure on the e5 pawn
because Black is ready to respond Nbd7 to our threats. E.g. 17.Rfe1 Nbd7 and
suddenly: $(a)$ the e5-pawn will not fall any time soon, $(b)$ Black's rooks are
connected again, $(c)$ the Bc5 is defended. So we see how quickly Black would
stabilize if we naively play a natural-looking Rfe1.

However, one must see that in this position, the disconnection of the rooks
inspires the strong 17.a4! Clearly, 17...bxa4 would lead to 18.Bxe4 Rd8 19.Qxe5
and White wins a pawn. If Black responds 18...Nd7, blocking the bishops attack,
White has *at least* 19.Bc6 (hitting the Ra8 and opening up the Ra1 attack on
a6) followed by Rxa6 (if Black plays Ra7) or even Qxa6.

Another alternative against 17...bxa4  18.Bxa4 Nd7 is to keep it positional and
play 19.b4 Bd6 (solidifying e5) 20.Nd2!? with the idea of playing Ne4 and
increment pressure on the pinned Nf6. Note that after 20.Nd2 the threat of Bc6
remains, a6 is a permanent weakness. I can't see a solid response for Black. For
example, 20...Qf8 unpins the Nf6, lessening the threat of Ne4, but then 21.Bxf6
and Black cannot recapture with the Nd7 because it's pinned to the Re8 by
White's Ba4. After 21...gxf6 White has 22.Qg4+ with a fork to the Nd7: 22...Qg7
23.Qxg7+ Kxg7 24.Bxd7 and White is up a piece.

Black could respond 20.Nd2!? e4, so as to occupy the e4 square himself. But then
again 21.Bxf6! and Black has three choices: (a) recapture with the Nd7 giving up
an exchange (White plays Bxe8); (b) play Qxf6 and hang the Nd7 entirely; (c)
play gxf6, but then again White has Qg4+ picking up the knight. Of course, (a)
is the lesser evil.

Having analyzed this variations in my mind, let me now pass to examine what
happens after 17.a4! b4 18.cxb4 Bxb4, which was played in the game. Here White's
bishop remains on c2, the rooks remain disconnected for the moment, meaning that
Black's Ra8 is undefended, and Black controls e1 with his Bb4. How should White
proceed? Qe4 would be brutal if it could be played, since it would attack the h7
pawn (threatening mate) and the undefended Bb4. So it seems the most
straightforward path is 19.Bxf6 Qxf6 20.Qe4. After this, Black has: 

(a) 20...Qg6, preventing mate, with the idea of 21.Qxb4 Qxc2. (Note that 21.Qc4,
with a discovery on Black's Qg6 which still defends our Bc2, fails to 21...Qd6).
However, White still has 22.Rfc1 Qg6 23.Rxc7 and White should be totally
winning: Black's Nb8 cannot move and Qb7 is imminent, winning a rook.

(b) 20...g6 to which White responds 21.Qxb4 and I don't think Black has anything
better than just Nd7 and go on a piece down.

(c) 20...Bd6, giving up the h7 pawn. Then 21.Qxh7+ Kf8 and I don't think we get
anything from 22.Qh8+ Ke7. The clear problem seems to be that the e7 square is
available for Black's king, so Nh4-Nf5 comes to mind (note  that the Bc2
protects f5). So one may entertain 22.Nh4. I can imagine Black playing 22...g6,
controlling f5, and also opening up his queen's control of h8, so this seems to
remove all immediate threats. But perhaps he should worry sacrifices on g6?

Yes: 22...g6 23.Bxg6! since now the bishop is untouchable: if 23...fxg6 then
24.Nxg6+ and the disappearence of the f-pawn leaves the Black king without moves
(White's queen controls the 7th rank). Black must give up his queen.  So 23.Bxg6
must be met with something like Qg7.


# Capablanca - Duz-Khotimirsky, Saint Petersburg 1913

### Lesson 1: Irrespective control 

This is a tactical and positional motif which works under the following
operations. The opponent controls a square whose invasion by some piece of ours
(e.g. our queen) would prove fatal. Then, if said piece can recapture another of
our pieces which invades such square, our opponent's control of it proves
entirely artifical. Consider the following position from the game.


<div markdown="0">
{% raw %}
<iframe width="600" height="371" src="https://lichess.org/study/embed/WYsco4KN/8gyuzL5Y#54" frameborder=0></iframe>
{% endraw %}
</div>

If the White queen could position itself on f5 with a free attack on h7, mate
would be unavoidable. Thus, any other piece (other than the bishop, which is
necessary to the mating threat) can hop into f7, since the White queen can
recapture it with deadly effects. Thus, Black's control of f5 is illusory, and
Capablanca played Nf5 disregarding the g6 pawn.


### Lesson 2: Indirect pressure

In the position above, one has to comprehend that White is exerting pressure on
f7 (among ohter places). Due to the reasons given above, Nf5 and Nh5 are both
possible moves. *Immediately* speaking, none of them threatens anything.
However, from f5, the knight has a check on h6 which attacks f7. So Nf5 does
attack f7 indirectly, and is thus preferred over Nh5 (which indeed does
nothing). 


















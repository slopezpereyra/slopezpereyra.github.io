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
<iframe width="600" height="371" src="https://lichess.org/study/WYsco4KN/37hDO11q#17" frameborder=0></iframe>
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
<iframe width="600" height="371" src="https://lichess.org/study/WYsco4KN/37hDO11q#21" frameborder=0></iframe>
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
<iframe width="600" height="371" src="https://lichess.org/study/WYsco4KN/37hDO11q#39" frameborder=0></iframe>
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
<iframe width="600" height="371" src="https://lichess.org/study/WYsco4KN/37hDO11q#45" frameborder=0></iframe>
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








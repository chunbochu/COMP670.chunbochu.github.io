# COMP 670 AI Game Project, Summer 2021
## Othello Game

### Introduction

Othello is a well-known two-player strategy game. For this project, you
will develop portions of an intelligent program that plays Othello. You
will be provided with a user interface and the game logic in Java (code
that implements the rules of the game) that will allow two human players
to play the game. You will write the search and strategy routines that
will allow the computer to play the game.

Othello ---also known as Reversi ---is played on a square board divided
into an 8×8 grid. The rules of the game, along with some good ideas for
a sound strategy of play, are described in the [Wikipedia entry on
Reversi](http://en.wikipedia.org/wiki/Reversi)---do
read it!

Be sure you know how to play the game before attempting to complete this
program; it will save you much time and effort. Since the provided
program allows play with two human players, you can "play against
yourself" to get some feel for the game's rules and strategy. The
provided game will not allow you to play against a computer player until
you create your AI class and write the necessary OthelloAIFactory class
code (see below).

### Starting Point

All the code that you'll need to complete the assignment is included in
the COMP670-Othello.zip file; download the file, unzip it, and import to
your preferred IDE. Much of the code is provided in compiled class
files, in the lib folder. The provided Java source code (.java) files
are heavily commented.

Although you may choose any Java IDE of your preference, the starter
project is ready to be imported in Eclipse.

To import this project to your Eclipse workspace,

1.  Unzip the starter file.
2.  Start eclipse and select your workspace.
3.  From the file menu, select `Import\...`, which will pop up a dialog
    box. under `General`, select Existing projects into workspace, then
    click `Next >`.
4.  Next to `Select root directory`, click the `Browse` button. Find the
    COMP670-Othello folder that you just unzipped the starter into,
    select it, then click `OK`.
5.  Finally, click `Finish`. You should now see a project
    called `COMP670-Othello` in the Package Explorer. Your Problems window
    may show some warnings; each of these warnings indicates that there
    is a part of the program that has yet to be built.

You will only need to work on two classes. First, you need to create a
new class that implements the `OthelloAI` interface. Your class'
name *must begin with `OthelloAI_`, followed by your `full name`.* So, if your
name is John Smith, your class should be named `OthelloAI_Johnn_Smith`.

Second, you write one line of code in the `OthelloAIFactory` class; see
the class' comments for details.

*Leave everything else as is. In particular, do not change the names of
files, classes, interfaces or methods that are provided.*

### How to run the program

Make sure that your Java version is 11 or higher. It's recommended to
install the newest Java JDK.

The `Othello` class contains a `main()` method, so to run the program,
execute the `Othello` class.

When you run Othello, a window will appear with a green area with the
label `click here to start game`. Click the green area and you will be
asked to specify whether each player should be controlled by a human or
the computer; for now, specify human for both, as you haven't
implemented your AI yet. Clicking on `OK` starts the game.

A human-controlled player makes a move by double-clicking an empty
square on the grid. Not all squares constitute valid moves; the mouse
cursor will turn into a hand when a square is a valid one, much like
when you hover over a link in your browser. (Note that you have to place
the cursor rather precisely in the square for the cursor to change, so
move the mouse within the square a bit if you are in a square that you
think is legal to use, but in which the cursor is not a hand.) The
computer simply moves when it is its turn. The GUI animates the placing
and flipping of tiles, so that you can see the moves in action. Status
messages display the score and remind you whose move it is.

### Some necessary terminology

You will be building a rudimentary *artificial intelligence* based on
the knowledge you have learned in this class so that the computer can
play a game of Othello against you (or against another instance of your
artificial intelligence). Your task for this project is fairly narrow,
so you can disregard the vast majority of the code that are given to
you, most of which implements either the GUI or the game logic. In fact,
most of the code has been provided in compiled form, rather than as
source code, for this very reason.

There are three main abstractions that you need to understand in order
to write the code required for this project:

1.  The contents of each grid cell are represented by the
    enumeration `OthelloCell`, which has three possible
    values: `OthelloCell.NONE` (for an empty cell), `OthelloCell.BLACK` (for
    a cell containing a black tile) and `OthelloCell.WHITE` (for a cell
    containing a white tile). The cells' locations are denoted by
    ordered pairs (*r*, *c*), where *r* is the row and *c* is the
    column. As is customary with two-dimensional arrays in Java, the row
    numbers and column numbers begin at 0, so the range of possible
    locations is (0, 0) through (7, 7).

2.  As your AI analyzes possibilities, it will be necessary for it to
    evaluate the current game situation. Collectively, we call the
    description of the current situation a *game state* or, a *state*. A
    game state is comprised of the contents of each grid cell, the score
    of the game, a flag indicating whose turn it is, and a flag
    indicating whether the game has ended.

3.  Since it's possible to have two AI's playing against each other, it
    makes sense to encapsulate the AI into a class, so that two objects
    of that class could be created and play against one another. You
    implement your AI in a class that implements the `OthelloAI`
    interface, which consists of a method called `chooseMove()` that
    analyzes all of the possible moves and picks the AI's next move.
    Since a move is denoted by the square in which a new tile should be
    placed, `chooseMove()` returns an object of type `OthelloMove`, which
    contains a row number and column number.

### Game trees

You can think of the possible game states as being arranged,
conceptually, in a kind of search tree called a *game tree*. Each node
of the tree contains a particular game state *g*. Its children are the
game states that can result from making each valid move from the
state *g*.

The root of the tree is the initial game state, the state of the Othello
game before the first move is made. The children of this initial state
are all the possible states that can arise from the black player (who
moves first) making a valid opening move. There are four such states,
corresponding to the four possible moves that the black player is
permitted to make at the opening. (All other moves are illegal and, as
such, are not to be considered.)

Take a look at this partial Othello game tree:

![https://www.ics.uci.edu/\~jacobson/ics23/LabManual/02-SearchTree.jpg](images/media/image1.jpeg){width="5.260416666666667in"
height="2.7743055555555554in"}

From the initial state, the root of the tree, there are four
possibilities from which the black player can choose its initial move,
so the root has four children. From the first of these moves, the
left-most child of the root, there are three possible moves that the
white player can make in response, so there are three children of this
node. From each of these moves, other legal moves exist; they would
appear as children of this node (these moves are not pictured). The tree
continues to grow in this fashion, each new move producing more
children. (Not surprisingly, the game tree can grow very large, very
quickly.)

A game ends when there are no legal moves on the board, that is, we
reach a *final state*; at this point, one player or the other has won
the game. Since there are no legal moves on these boards, the nodes
representing them will have no children; so, final states are leaves of
the game tree.

### Exhaustively searching all possibilities

Each time a player chooses a move, s/he wants to pick the one that will
lead to a winning game state. Assuming you had the complete game tree at
your disposal, you could determine your best move by using the minimax
algorithm:

1.  Choose the final state that gives you the best win. This is
    typically done by applying an *evaluation function* to each final
    game state. This function typically returns a number, where higher
    numbers are considered better. So, choose the state with the highest
    value.

2.  Determine the path from the current game state to the final state
    that you chose.

3.  Make the move that takes you from the current game state down the
    path toward the chosen final state.

Sadly, practical limitations make this easy-to-implement approach
impossible. First, the number of game states on each level of the tree
grows exponentially as you work your way down the tree, since there are
typically a large number of possible moves that can be taken from any
particular game state. There simply won't be enough memory to store the
entire game tree. (You can imagine that, if you build the game tree 20
levels deep, and there are four possible moves that can be made from any
particular state, the number of nodes in the tree would be greater than
4^20^, which is a very large number indeed!) Besides, even if there were
enough memory available to store the tree, the processing time to create
the entire game tree would be prohibitive.

So, you'll need to find a compromise, an approach that perhaps doesn't
always find the best possible outcome, but that makes a good decision in
a reasonable amount of time while using a reasonable amount of memory.

### Heuristic search

The study of artificial intelligence has much to say about good ways to
search toward a goal when it's impractical to check all possible paths
toward it.

We can first make use of the following observation: Suppose black has
made a move in the game, and white wants to figure out the best move to
make, using the search tree approach we've been discussing. Then white
need only concern her/himself with the subtree that has the current game
state as its root. Once a move is made, all the other moves that could
have been made can be ignored, as it is now not possible to take those
paths down the tree. Thus, when analyzing the next move to make, we need
only generate the part of the search tree that originates from the
current game state.

This approach reduces our storage needs significantly, and we don't
waste time or memory processing parts of the tree that we can no longer
reach.

Even if we generate only the part of the tree that we need, that part
will still be much too large to store until we're nearing the end of the
game. This is where a *heuristic search* comes into play. In a heuristic
search, we generate as much of the relevant subtree as is practical,
using the resulting game states to guide us in selecting a move that we
hope will be the best.

There are several strategies that we could use. At the heart our
strategy is using an evaluation function to rate each particular game
state in some way, so that we can decide which of a large number of game
states is the best outcome for us. A simple approach ---though one that
ignores some aspects of the game ---is the following:

*eval(state) = number of tiles belonging to me − number of tiles
belonging to my opponent*

It's also important to note here that *you do not need to actually build
a game tree in memory*. Our algorithm will perform a sort
of *depth-first search* on the game tree, meaning that we can use
parameters in a recursive method (stored on the run-time stack) to
perform the search, negating the need to actually build and store a game
tree. This will dramatically reduce the amount of memory needed to
choose a move, since only one path in the tree will need to be stored on
the run-time stack at any one time.

Putting these ideas together, we can develop a search algorithm that
will look for the move that leads to the game state that evaluates to
the highest value. That algorithm looks like this:

    int search(OthelloGameState s, int depth)
    {
        if (depth == 0 or reached a final state)
            return evaluation of s
        else
        {
            if (it's my turn to move)
            {
                for each valid move that I can make from s
                {
                    make that move on s yielding a state s'
                    search(s', depth - 1)
                }

                return the maximum value returned from recursive search calls
            }
            else
            {
                for each valid move that my opponent can make from s
                {
                    make that move on s yielding a state s'
                    search(s', depth - 1)
                }

                return the minimum value returned from recursive search calls
            }
        }
    }


There are a few things we need to discuss about this algorithm. First,
notice that there are two cases of recursion: either it is the computer
player's turn (who is currently making the decision) or its opponent's
turn. In each case, the algorithm is almost the same, except:

-   \...when it is the computer player's turn, the *maximum* value is
    returned. In other words, the computer player wants to make the best
    possible move it can.

-   \...when it is the opponent's turn, the *minimum* value is returned.
    This is because it is assumed that the opponent will also make the
    move that's in her/his best interest, and that move is in the
    computer's *worst* interest.

Either the black or the white player (or both!) might be a computer
player. So, when deciding whether it's "my turn" or "my opponent's
turn," you'll have to exercise some caution to ensure that you're making
the right decision.

Second, notice the `depth` parameter, used to limit the depth of our
search, to make sure that our search is of a manageable length. Each
time we recurse one level deeper, the depth is reduced by one, and we
stop recursing when it reaches zero.

Experiment to find a depth that can compute a move fairly quickly, but
still gives the computer player the most "look ahead" feasible. (Hint:
as the game progresses, the number of possible moves changes. At some
point, the number of moves might become small enough that you can
increase the search depth; you might also have to decrease the search
depth if the number of moves increases. Adjusting the depth as the game
progresses can make the computer much "smarter" without unduly delaying
the game.)

Third, observe that when one player makes a move, it isn't necessarily
the case that the other player will be making the next move;
occasionally, in Othello, the same player gets to move twice in a row.
So, care must be taken in deciding whose turn it is. The easiest way to
deal with this problem is to remember that the current game state keeps
track of whose turn it is, so query the game state when you need this
information.

Lastly, note that this algorithm returns the *evaluation* of the best
move for state *s*, not the best state itself; nor does it return the
evaluation for some other state reachable from *s* (for example, for one
of the *s\'* states). Calling `search(*s*, 10)` for some state *s* asks
the following question: "Looking ten moves into the future, and
assuming I and my opponent do the best we can do, how well will the
state *s* turn out for me?" You'll need to exercise some care in
actually implementing this algorithm so that `chooseMove()` will be able
to call `search()` and use the result to help it choose the right move.

Be sure to test your program for correct play and reasonable play; a
good way to do so is to play against your own program (or have friends
or classmates play against it) to see if it can be broken or beaten.
Obviously, if playing breaks your program, you need to fix it. If people
routinely beat the computer, consider fine-tuning your program's search
depth until it does better. You may also wish to change the evaluation
function or the game tree search algorithm, as discussed in Optional
Work, below.

### A Couple of Technical Points

-   Your `OthelloAI_XXX` class must not write to `System.out` or otherwise
    write to the console. Doing so would certainly confuse a game
    player, who is supposed to be interacting only with the Othello
    board. If you wish to use `System.out` statements while debugging your
    work, that's fine, but be sure to comment them out (or remove them)
    before turning in your work.

-   I do not require you to use additional classes to support your
       `OthelloAI_XXX` class, but if you choose to do so, *make them inner
    classes*. This isolates those additional classes from the rest of
    the program, which, of course, has no need to "see" them.

### <span style="color:red">Optional Work</span>

*Modify your evaluation function.* The core of your AI---what will set
it apart from others---is the evaluation function it uses to decide how
"good" each board configuration is. My evaluation function may not
always be---may even never be---the best to use: a move that puts more
of your tiles on the board right now might set up the board so your
opponent could later obtain a larger quantity of tiles than you did.
Perhaps another move would have left the board so that your opponent
would be in a worse position. So, modify your evaluation function, or
write several that you can swap in and out of your program, and see how
they do against a human and computer player, and against the evaluation
function we gave above. (You might want to poke around the web looking
for strategy guides or other information, taking into account, for
example, that some squares on the Othello board are considered more
important than others). Try playing against your own program to see if
you can beat it. Write up what approaches you tried, your results and
your conclusions, as comments in your Othello AI class. In particular,
tell me which function worked best and why you believe it did.

*Write searches that use other heuristic techniques.* In addition to the
heuristic search we used above, there are other approaches for
heuristically searching a game tree. Try out one or more of them to see
how well they perform relative to the depth-first search approach used
above and when used against each other. (A simple way to do this is to
modify your program so that, if both players are the computer, a
different strategy is used by each one. Then, have the computer play
itself several times and see what happens.) For instance, an approach
called alpha-beta pruning, which is in essence a smarter depth-first
search, is often a good technique to employ (and perhaps better than the
one we have used here). If you do use one or more optional searches,
include in your code all you wish us to see, along with your
implementation of the min/max algorithm we provided above. Have a flag
that determines which search is the one to use, and set it to the one
you want to use in the tournament (see below).

Again, write up your results and your conclusions as comments in your
Othello AI class and in your final report. Be sure to tell me which
strategy worked best and why you think it did.

### Demo/Tournament

We will gather all your AIs together and run a demo tournament to determine who has the best one in
the last week. The rules we will use are as follows:

-   Each AI will play two games against each other AI, one as black and
    one as white.

-   The primary factor in determining the best AI is the total
    percentage of games won. (Draws will count as 1/2 of a win and 1/2
    of a loss.) So, first and foremost, it's important to win games.

-   A secondary factor, to be used in the case of a tie, is the total
    number of tiles accumulated in all games. This means that winning
    games big, as opposed to squeaking out close wins, is important if
    there's a tie.

-   Your AI will be given 5 seconds of CPU time to choose each of its
    moves. Java has a few different library classes that can help you
    time how long it takes to make a move. Using
    the `System.currentTimeMillis()` method provides an easy way. It
    returns the current date and time, measured to the nearest
    millisecond, and reported as the number of elapsed milliseconds
    since midnight, January 1, 1970 (sometimes referred to as the "Unix
    epoch," since this is how Unix-based systems have traditionally
    measured time). To measure how long a move takes, remember what time
    it is when you start the move:

-   `long startTime = System.currentTimeMillis();`
   
    As you evaluate that move, check the time again every so often:
    `long endTime = System.currentTimeMillis();`
    
    and subtract the startTime from the endTime. When the time approaches
    5 seconds, terminate your evaluation, and make the move.

-   If your AI does not compile, takes too long to make a move, returns
    null, throws an exception, isn't named according to the naming
    convention, or violates any of the other rules laid out in the
    project write-up, it will be disqualified from the tournament.

Where you rank in the tournament will have no bearing on your grade, but
we hope it will help motivate you to make the best evaluation function
you can.

Good luck!

### Deliverables

There are three deliverables to turn in for your AI Game Project.

1.  AI Game Project Part 1\
    You should submit a description report of the design of your
    AI in this assignment. Provide answers to the following questions:

     a.  Do you use the default evaluation function? If not, what is your
        evaluation function and what heuristic is it based on?

     b.  How will you implement the search algorithm?

     c.  Is your depth parameter dynamically adjusted?

     d.  What subtasks have your team decided to work on and who is
        responsible for each subtask? (You can make a to-do-list with
        names to track the progress. Check marks can be easily added as
        your team make progress.)

2.  AI Game Project Part 2\
    You should submit a complete project report including a
    testing plan in this assignment. Provide answers to the following
    questions:

       a.  What are the major challenges you have encountered? How did you
        solve them?

       b.  Which subtask takes the most time to complete? Why?

       c.  How did you conduct test and modified your AI based on the
        results? Document each step and action you take.

       d.  Has every team member contributed fairly by completing the
        subtasks assigned to him/her?

    Also turn in only the Java file containing your AI class, (which will
    include any additional inner classes you created, if any); for
    example, turn in the file named `OthelloAI_Team1.java` if your Team
    number is 1. Do not turn in any of the other files provided to
    you. *Do not ZIP up or otherwise archive these files.*

3.  AI Game Project Demo\
    We will have a tournament in the last class to demonstrate your AI
    implementation, have fun and celebrate your achievement.

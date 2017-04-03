# Project-K

### Statement
We will build a matching card game using a backend and gui.

### Analysis
We've referred to racket gui library and other gui game libraries. Will also possibly using data/collection
or other libraries to represent the cards.

Be explicit about the techiques from the class that you will use. For example:

- Will you use data abstraction? How?

	Yes we will be using a list, array, or vector to abstract the cards.
- Will you use recursion? How?

	We will possibly be using recursion to keep the instance of a single game running
	until it reachs a condition where the user specifies to stop the game.
	
- Will you use map/filter/reduce? How? 

	We would like to use map/filter/reduce to help with defining functions that
	require procedures to be applied to each of the cards. Also, to filter out certain cards 
	that may have been used in the deck already
	
- Will you use object-orientation? How?

	We will be using constructor/accessor/mutators to create a representation of 
	a card game,deck, and player's hands to encapsulate and certain objects
	may have procedures defined within.
	
- Will you use functional approaches to processing your data? How?

	We will use functional approaches to apply multiple procedures to each of the cards.
	Possibly mapping a procedure to a list/array/vectors to create a proper representation of the cards.
	
- Will you use state-modification approaches? How? (If so, this should be encapsulated within objects. `set!` pretty much should only exist inside an object.)
	
	We would like to avoid state-modification in our procedures and rather 
	build new lists/array/vectors and returning them within procedures.
	
- Will you build an expression evaluator, like we did in the symbolic differentatior and the metacircular evaluator?
	
	We will not be building an  expression evaluator.
	
- Will you use lazy evaluation approaches?


### Deliverable and Demonstration

	We will have a card game that is playable and will be able to be demonstrated live. 


### Evaluation of Results

	A success would be playing with all of the features without having any errors.

## Architecture Diagram

![FP-Proposal](/FP-Proposal.jpg?raw=true "Architecture Diagram")
	
	
	First, we will have to make sure everything works from the backend perspective 
	and that we can play card games using the backend without gui. Then after that
	we will be creating the gui to connect with the backend so that the players can play
	our card game.
	
## Schedule

### First Milestone (Sun Apr 9)

	We should have close to a working backend at this time where we can actually play card games.
	all of our procedures should be defined and ready for gui.

### Second Milestone (Sun Apr 16)

	We should basically have the card game's back end and gui done at this point and what's left 
	is to resolve any issues that come up.

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])
	
	At this point we would go through the presentation and make sure we are not missing anything.
	Mainly readying ourselves for the live demonstration.

## Group Responsibilities

### Leon Kang @LeonKang978
will write the backend

### Seokhwan Ko @SokannKo
will work on the gui

 

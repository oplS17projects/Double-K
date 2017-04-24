# Double K

### Statement
We have built a matching card game using racket

### Analysis
We've referred to racket gui library and other gui game libraries. Will also possibly using data/collection
or other libraries to represent the cards.

Be explicit about the techiques from the class that you will use. For example:

- Will you use data abstraction? How?
	
	Yes we have abstracted the idea of a deck and cards within a deck.
	
- Will you use recursion? How?

	We did not end up using recursion in our implementation to keep the game 
	running but rather we just used the (send ..) command to start our game and when 
	done we would just exit the gui window
	
- Will you use map/filter/reduce? How? 

	We used the map procedure to help define our deck of cards.
	
- Will you use object-orientation? How?

	We did not end up using object-orientation aside from constructing
	a deck of cards.
	
- Will you use functional approaches to processing your data? How?

	Used map to apply the procedure to each card within the deck which sent an image
	to the table each time.
	
- Will you use state-modification approaches? How? (If so, this should be encapsulated within objects. `set!` pretty much should only exist inside an object.)
	
	we did not use state-modification approaches.
	
- Will you build an expression evaluator, like we did in the symbolic differentatior and the metacircular evaluator?
	
	no
	
- Will you use lazy evaluation approaches?


### Deliverable and Demonstration

	The card game is playable as of now.


### Evaluation of Results

	It is a succesful card game we built but we did not include as much of the backend 
	as it was more heavily gui-based. If we had more time possibly we could have included
	more.

## Architecture Diagram

![FP-Proposal](/FP-Proposal.jpg?raw=true "Architecture Diagram")
	
	
	I did not update the architecture diagram because we did to an extent,
	build a card game in this way. 
	
## Schedule

### First Milestone (Sun Apr 9)

	The backend was built and working but could have been better connected to the gui.

### Second Milestone (Sun Apr 16)

	Working gui built at this point.

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])
	
	minor tweaking was done before our presentation, if we had more time we could have 
	connected the backend and gui data more possibly.

## Group Responsibilities

### Leon Kang @LeonKang978
wrote the backend

### Seokhwan Ko @SokannKo
wrote the gui

 

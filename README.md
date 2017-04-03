# Double K

### Statement
We will build a card game using a backend and gui.

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
Upload the architecture diagram you made for your slide presentation to your repository, and include it in-line here.

Create several paragraphs of narrative to explain the pieces and how they interoperate.

## Schedule
Explain how you will go from proposal to finished product. 

There are three deliverable milestones to explicitly define, below.

The nature of deliverables depend on your project, but may include things like processed data ready for import, core algorithms implemented, interface design prototyped, etc. 

You will be expected to turn in code, documentation, and data (as appropriate) at each of these stages.

Write concrete steps for your schedule to move from concept to working system. 

### First Milestone (Sun Apr 9)
Which portion of the work will be completed (and committed to Github) by this day? 

### Second Milestone (Sun Apr 16)
Which portion of the work will be completed (and committed to Github) by this day?  

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])
What additionally will be completed before the public presentation?

## Group Responsibilities
Here each group member gets a section where they, as an individual, detail what they are responsible for in this project. Each group member writes their own Responsibility section. Include the milestones and final deliverable.

Please use Github properly: each individual must make the edits to this file representing their own section of work.

**Additional instructions for teams of three:** 
* Remember that you must have prior written permission to work in groups of three (specifically, an approved `FP3` team declaration submission).
* The team must nominate a lead. This person is primarily responsible for code integration. This work may be shared, but the team lead has default responsibility.
* The team lead has full partner implementation responsibilities also.
* Identify who is team lead.

In the headings below, replace the silly names and GitHub handles with your actual ones.

### Susan Scheme @susanscheme
will write the....

### Leonard Lambda @lennylambda
will work on...

### Frank Funktions @frankiefunk 
Frank is team lead. Additionally, Frank will work on...   

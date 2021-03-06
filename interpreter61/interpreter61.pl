/*
Kasper Rosenberg karo5568
*/

/***
A skeleton for Assignment 2 on PROP HT2020.
Peter identestam-Almquist, 2020-12-01.
***/

/*** 
Load the tokenizer (tokenize/2) and the file_writer (write_to_file/3).
***/
:- [tokenizer].
:- [filewriter].


/***
The top level predicate run/2 of the solution.
To be called like this:
?- run('program1.txt','parsetree1.txt').
***/

run(InputFile,OutputFile):-
	tokenize(InputFile,Program),
	parse(ParseTree,Program,[]),
	/* evaluate(ParseTree,[],VariablesOut), */ 
	write_to_file(OutputFile,ParseTree,VariablesOut).

	
/***
parse(-ParseTree)-->
	A grammar defining your programming language,
	and returning a parse tree.
***/

/* WRITE YOUR CODE FOR THE PARSER HERE .........................*/



parse(ParseTree,Program,[]) :-

	assignment(ParseTree,Program,[]).

assignment --> 
	ident,assign_op, expression ,semicolon.
	
expression --> 
	term , ( [] ; ((add_op;sub_op) , expression)).
	
term --> 
	factor , ([] ; ((mult_op ; div_op) , term)).
	
factor --> 
	int;(left_paren,expression,right_paren).
	
	
ident --> [atom].
int --> [integer].

assign_op --> [=].
semicolon --> [;].
add_op --> [+].
sub_op --> [-].
mult_op --> [*].
div_op --> [/].
left_paren --> ['('].
right_paren --> [')'].

assignment(assignment(Ident,Assign_op,Expression,Semicolon)) -->
	ident(Ident),
	assign_op(Assign_op),
	expression(Expression),
	semicolon(Semicolon).
	
expression(expression(Term)) -->
	term(Term).	
	
expression(expression(Term,Add_op,Expression)) -->
	term(Term),
	add_op(Add_op),
	expression(Expression).
	
expression(expression(Term,Sub_op,Expression)) -->
	term(Term),
	sub_op(Sub_op),
	expression(Expression).
	
term(term(Factor)) -->
	factor(Factor).
	
term(term(Factor,Mult_op , Term)) -->
	factor(Factor),
	mult_op(Mult_op),
	term(Term).
	
term(term(Factor,Div_op , Term)) -->
	factor(Factor),
	div_op(Div_op),
	term(Term).
	
factor(factor(Int)) -->
	int(Int).
	
factor(factor(Left_paren,Expression,Right_paren)) -->	
	left_paren(Left_paren),
	expression(Expression),
	right_paren(Right_paren).
	
ident(Ident) --> [Ident], {atom(Ident)}.
int(Int) --> [Int], {integer(Int)}.

assign_op(assign_op) --> [=].
semicolon(semicolon) --> [;].
add_op(add_op) --> [+].
sub_op(sub_op) --> [-].
mult_op(mult_op) --> [*].
div_op(div_op) --> [/].
left_paren(left_paren) --> ['('].
right_paren(right_paren) --> [')'].


				
/*
evaluate(+ParseTree,+VariablesIn,-VariablesOut):-
	Evaluates a parse-tree and returns the state of the program
	after evaluation as a list of variables and their values in 
	the form [var = value, ...].
*/
/* WRITE YOUR CODE FOR THE EVALUATOR HERE */
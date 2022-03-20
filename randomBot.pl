
:-dynamic currentGuess/1.
currentGuess([-1,-1,-1,-1,-1]).
:-dynamic currentPattern/1.
currentPattern([-1,-1,-1,-1,-1]).

:- dynamic makeGuess/3.


%% Entry point
% solution should be in the form [a,b,c,d,e]
randomEntry(Solution) :-
    asserta(solution(Solution)),
    consult(wordleWords),
    randomAgent([-1,-1,-1,-1,-1],0),
    retract(solution(_)).

% Random Agent
randomAgent([2,2,2,2,2], Guesses) :- write('\n\nCame to answer in '),write(Guesses),writeln(' guesses').
randomAgent(Pattern, Guesses) :-
    findall(X, word(X), CurrentWords),
    length(CurrentWords, Len), writeln(Len), !,
    random_member(Guess, CurrentWords),
    writef('Guess: %p%p%p%p%p\n', Guess),
    makeGuessAndCull(Guess), !,

    
    
    currentPattern(P),
    GuessInc is Guesses + 1,
    randomAgent(P, GuessInc).


makeGuessAndCull(Guess):-
    % load the makeGuess Pred
    consult(check),
    solution(Solution),
    % make our guess based on the solution word and store the result pattern
    makeGuess(Solution,Guess,R),
    writef('Result: %p%p%p%p%p\n', R),

    % update our current guess and associated pattern
    retract(currentGuess(_)), retract(currentPattern(_)),
    asserta(currentGuess(Guess)), asserta(currentPattern(R)),

    % remove words from our KB that don't fit the pattern
    forall(word(X), cullWords3(X)).

% for all words, if the word can be used with the current guess to make the current pattern, leave it in
cullWords3(Word) :- currentPattern(P), currentGuess(G), makeGuess(Word, G, P), !.
% otherwise, remove it from the database
cullWords3(Word) :- retract(word(Word)).




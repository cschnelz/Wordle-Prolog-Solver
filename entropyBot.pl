
:-dynamic currentGuess/1.
currentGuess([-1,-1,-1,-1,-1]).
:-dynamic currentPattern/1.
currentPattern([-1,-1,-1,-1,-1]).

:- dynamic makeGuess/3.




%% Entry Point
%% solution should be in the form [a,b,c,d,e]
firstEntropyEntry(Solution) :-
    consult(wordleWords), consult(wordleScores),
    asserta(solution(Solution)),
    findall(X, word(X), WordList),
    findall(Y, score(Y), Scores),
    firstEntropyAgent([], 0, WordList, Scores).

% Agent Predicates
    % breaks when the solution is found
firstEntropyAgent([2,2,2,2,2], Guesses, _, _) :- write('\n\nCame to answer in '),write(Guesses),writeln(' guesses').
firstEntropyAgent(Pattern, Guesses, Words, Scores) :-
    GuessInc is Guesses + 1,
    % get the word with the best entropy score
    find_max_entropy(Index, Word, Words, Scores),
    length(Words, Len), writeln(Len), !,
    atomic_list_concat(Word, Y), writeln(Y),
    
    % guess the word and cull the word list
    makeGuessAndCull(Word, NW, NS, Words, Scores), !,
    currentPattern(P),
    % continue
    firstEntropyAgent(P,GuessInc,NW,NS).

% support function - calls for the wordle response code and updates KB info
makeGuessAndCull(Guess, NewWords, NewScores, OldWords, OldScores):-
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
    cullWords(NewWords, NewScores, OldWords, OldScores).

% we've processed them all
cullWords([],[],[],[]) :- !.
% for all words, if the word can be used with the current guess to make the current pattern, leave it in
cullWords([Hnw|NewWords],[Hns|NewScores],[How|OldWords],[Hos|OldScores]) :- currentGuess(G), currentPattern(P), makeGuess(How, G, P), !, 
    Hnw = How, Hns = Hos, cullWords(NewWords, NewScores, OldWords, OldScores).
% otherwise, remove it from the database
cullWords(NewWords,NewScores,[_|OldWords],[_|OldScores]) :- cullWords(NewWords, NewScores, OldWords, OldScores).

% support functions for getting the word (and its index) with the highest entropy score
max_list(L, M, I) :- nth0(I, L, M), \+ (member(E, L), E > M).
find_max_entropy(I, Word, WordList, Scores) :-
    max_list(Scores, M, I),
    nth0(I, WordList, Word).



%%%%%%%%%%%%%%%%%
% Testers %
%%%%%%%%%%%%%%%%%%
testPrinting([H|T]) :- atomic_list_concat(H, Y), writeln(Y).

testMakingList(Words, Scores) :-
    findall(X, word(X), Words), findall(X, score(X), Scores).

testCulling(TGuess, TPattern, NewWords, NewScores) :-
    consult(check),
    findall(X, word(X), OldWords),
    findall(X, score(X), OldScores),
    retract(currentGuess(_)), retract(currentPattern(_)),
    asserta(currentGuess(TGuess)), asserta(currentPattern(TPattern)),
    
    cullWords(NewWords, NewScores, OldWords, OldScores).

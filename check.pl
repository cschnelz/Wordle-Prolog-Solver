% replaces whatever is at Index in list Old with Substitution. Edited list is in New
replace(_, _, [], []) :- !.
replace(Index, Substitution, [_|Old], [Hn|New]) :- Index == 0, !, Hn = Substitution, replace(-1, Substitution, Old, New).
replace(Index, Substitution, [Ho|Old], [Hn|New]) :- NewInd is Index - 1, Hn = Ho, replace(NewInd, Substitution, Old, New).

% Makes a correct result array, finally stored in NewResult
checkGuessSecondSweep(_, [], [], []) :- !.
% if current index of guess is -1 its because we scratched it off in the 2s sweep, so copy over current index result and recurse
checkGuessSecondSweep(CopyWord, [Hcg|CopyGuess], [Hr|Result], [Hnr|NewResult]) :- Hcg == -1, !, 
    Hnr = Hr, checkGuessSecondSweep(CopyWord, CopyGuess, Result, NewResult).
% if the current index of the guess is NOT in the copy of the word, we have a dupe so set the current result index to 0 and recurse
checkGuessSecondSweep(CopyWord, [Hcg|CopyGuess], [_|Result], [Hnr|NewResult]) :- not(member(Hcg, CopyWord)), !, 
    Hnr is 0, checkGuessSecondSweep(CopyWord, CopyGuess, Result, NewResult).
% if it IS in the copy, we replace the letter in the word used to find this indirect match with -1. We do this so that if there are two indirect matches the first will stand and the second will be flipped to 0
checkGuessSecondSweep(CopyWord, [Hcg|CopyGuess], [_|Result], [Hnr|NewResult]) :- 
    nth0(I, CopyWord, Hcg), Hnr is 1, replace(I, -1, CopyWord, NewCopyWord), checkGuessSecondSweep(NewCopyWord, CopyGuess, Result, NewResult).

% Makes a CopyWord and Copyguess, where direct matches are replaced with -1 for testing duped indirect matches (1s)
checkGuessFirstSweep([],[],[],[],[]) :- !.
% if R is not 2, we copy over the letters from word and guess to the copy arrays
checkGuessFirstSweep([Hw|Word], [Hg|Guess], [R|Esult], [Hcw|CopyWord], [Hcg|CopyGuess]) :- R \= 2, !,
    Hcw = Hw, Hcg = Hg, checkGuessFirstSweep(Word, Guess, Esult, CopyWord, CopyGuess).
% otherwise, replace them with -1 so that we can check for indirect dupes
checkGuessFirstSweep([_|Word], [_|Guess], [_|Esult], [Hcw|CopyWord], [Hcg|CopyGuess]) :-
    Hcw is -1, Hcg is -1, checkGuessFirstSweep(Word, Guess, Esult, CopyWord, CopyGuess).


% usage: checkGuess(Word, Guess, 0, Result)
% produces a list of match codes for each letter in guess
checkGuess(Word, [Letter], 4, [R]) :- checkLetterAt(Word, Letter, 4, R), !.
checkGuess(Word, [Letter|Guess], Position, [R|Result]) :- 
    NextPos is Position + 1, 
    checkLetterAt(Word, Letter, Position, R), 
    checkGuess(Word, Guess, NextPos, Result).

% result is 2 if its a direct match, 1 if its indirect, or 0 if its a no match
checkLetterAt(Word, Letter, Position, Result) :- nth0(Position, Word, Letter), !, Result is 2.
checkLetterAt(Word, Letter, _, Result) :- member(Letter, Word), !, Result is 1.
checkLetterAt(_, _, _, Result) :- Result is 0.

% entry point for guess validation. Usage: makeGuess([Word], [Guess], Result).
makeGuess(Word, Guess, Result) :- 
    checkGuess(Word, Guess, 0, R1), 
    checkGuessFirstSweep(Word, Guess, R1, CopyWord, CopyGuess),
    checkGuessSecondSweep(CopyWord, CopyGuess, R1, R2),
    Result = R2.
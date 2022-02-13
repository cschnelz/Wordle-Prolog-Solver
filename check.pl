guess([a,d,d,e,e]).
word([a,b,c,d,e]).


replace(Index, Substitution, [], []) :- !.
replace(Index, Substitution, [Ho|Old], [Hn|New]) :- Index == 0, !, Hn = Substitution, replace(-1, Substitution, Old, New).
replace(Index, Substitution, [Ho|Old], [Hn|New]) :- NewInd is Index - 1, Hn = Ho, replace(NewInd, Substitution, Old, New).

checkGuessSecondSweep(CopyWord, [], [], []) :- !.
checkGuessSecondSweep(CopyWord, [Hcg|CopyGuess], [Hr|Result], [Hnr|NewResult]) :- Hcg == -1, !, 
    Hnr = Hr, checkGuessSecondSweep(CopyWord, CopyGuess, Result, NewResult).
checkGuessSecondSweep(CopyWord, [Hcg|CopyGuess], [Hr|Result], [Hnr|NewResult]) :- not(member(Hcg, CopyWord)), !, 
    Hnr is 0, checkGuessSecondSweep(CopyWord, CopyGuess, Result, NewResult).
checkGuessSecondSweep(CopyWord, [Hcg|CopyGuess], [Hr|Result], [Hnr|NewResult]) :- 
    nth0(I, CopyWord, Hcg), Hnr is 1, replace(I, -1, CopyWord, NewCopyWord), checkGuessSecondSweep(NewCopyWord, CopyGuess, Result, NewResult).


checkGuessFirstSweep([],[],[],[],[]).
checkGuessFirstSweep([Hw|Word], [Hg|Guess], [R|Esult], [Hcw|CopyWord], [Hcg|CopyGuess]) :- R \= 2, !,
    Hcw = Hw, Hcg = Hg, checkGuessFirstSweep(Word, Guess, Esult, CopyWord, CopyGuess).
checkGuessFirstSweep([Hw|Word], [Hg|Guess], [R|Esult], [Hcw|CopyWord], [Hcg|CopyGuess]) :-
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
checkLetterAt(Word, Letter, Position, Result) :- member(Letter, Word), !, Result is 1.
checkLetterAt(Word, Letter, Position, Result) :- Result is 0.


makeGuess(Word, Guess, Result) :- 
    checkGuess(Word, Guess, 0, R1), 
    checkGuessFirstSweep(Word, Guess, R1, CopyWord, CopyGuess),
    checkGuessSecondSweep(CopyWord, CopyGuess, R1, R2),
    Result = R2.
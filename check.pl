
% usage: checkGuess(Word, Guess, 0, Result)
% produces a list of match codes for each letter in guess
checkGuess(Word, [Letter], 4, [R]) :- checkLetterAt(Word, Letter, 4, R), !.
checkGuess(Word, [Letter|Guess], Position, [R|Result]) :- 
    NextPos is Position + 1, checkLetterAt(Word, Letter, Position, R), checkGuess(Word, Guess, NextPos, Result).

% result is 2 if its a direct match, 1 if its indirect, or 0 if its a no match
checkLetterAt(Word, Letter, Position, Result) :- nth0(Position, Word, Letter), !, Result is 2.
checkLetterAt(Word, Letter, Position, Result) :- member(Letter, Word), !, Result is 1.
checkLetterAt(Word, Letter, Position, Result) :- Result is 0.
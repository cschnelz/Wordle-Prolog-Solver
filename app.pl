

printWordList() :- forall(word(X), writef('%p%p%p%p%p\n',X)).

% random guess entry point
randomEntry():-
    findall(X, word(X), WordList),
    randomAgent().


% if one word is left in our list we're done

randomAgent() :-
    consult(cull),
    findall(X, word(X), CurrentWords),

    random_member(Guess, CurrentWords),
    makeGuessAndCull(Guess), !,

    writef('Guess: %p%p%p%p%p\n', Guess).
    %findall(X, word(X), NewCurrentWords),
    %aggregate(count, X^word(X), Remaining),
    %writeln(Remaining),
    %randomAgent().
% example words KB FORMAT
:-dynamic word/1.
word([c,r,a,n,e]).
word([l,a,t,t,e]).


% retract words that dont fit the result pattern
% cull(Guess, Result)
# WordLog; A logic-based solver for a python adaptation of the internet game Wordle
## Acknowledgments

**Authors:** Carlos García-Lemus , Michael Long, Charles Schnelz

**Instructor:** Dr. Rodrigo Canaan

**Course:** CSC 481; Knowledge Based Systems


**Affiliation:** California Polytechnic State University, San Luis Obispo:
                 Computer Science and Software Engineering Department

## Instructions for this project
**Requirements for this project:**  
- Prolog
- Python3  
  
For /statistics/:  
- tqdm



**How to run this project:**

`swipl entropyBot.pl`  
  
To run enter a word that our entropy bot will guess it must be in the format "[a,b,c,d,e]":  
`?- firstEntropyEntry([t,r,a,c,e])`  

This will give each guess, and each hint in the form of "[0, 0, 1, 0, 1]" for example as well as each guessed word  




**How to reproduce our results:**

In the folder statistics will list every statistics gained from this project found in our report. To reproduce, move this file into the same file as firstOrderEntropy.pl and run each statistics file you see fit.
To see more detailed results and diagrams, consult section 5c [here](https://docs.google.com/document/d/17zcva0blP_qaeTDRjn1T9nG3R9FT3QFr/edit?usp=sharing&ouid=108228719403900494481&rtpof=true&sd=true) (You can also use the makefile provided and run 'make run1', 'make run2', and finally once those 2 are finished, 'make run3')


## Further Acknowledgments        

Wardle, Josh (n.d.). Wordle - a daily word game. powerlanguage.co.uk. Retrieved January 23, 2022, from
  https://www.powerlanguage.co.uk/Wordle/ 

Sengupta, Aditya “Maximizing Differential Entropy to Solve Wordle.” Jan 13, 2022. 
  https://aditya-sengupta.github.io/coding/2022/01/13/Wordle.html   

“Wordle Stats.”  Jan 2022. https://twitter.com/wordlestats?lang=en 

Knuth, Donald GraphBase list of five-letter words, Stanford Computer Science. (n.d.). Retrieved February 23, 2022, from
  https://www-cs-faculty.stanford.edu/~knuth/sgb-words.txt 
  
3Blue1Brown, “Solving Wordle Using Information Theory.” Feb 6, 2022. https://www.youtube.com/watch?v=v68zYyaEmEA 

Stechschulte, John (2022, January 20). Optimal Wordle. towardsdatascience.com. 
  Retrieved January 24, 2022, from https://towardsdatascience.com/optimal-wordle-d8c2f2805704

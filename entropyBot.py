import pickle
import sys
import math
from collections import defaultdict
from tqdm import tqdm

from check import check

def cull(guess, result, wordlist):
    newWords = []
    for word in wordlist:
        if check(word, guess) == result:
            newWords.append(word)
    return newWords

def maxEntropy(entropyDict):
    return max(entropyDict, key=entropyDict.get)

def main(solution):

    with open('saved_dictionary.pkl', 'rb') as f:
        entropy_dict = pickle.load(f)

    with open('WordleWords.txt', 'r') as f:
        wordList = [line.split()[0] for line in f]

    guess = maxEntropy(entropy_dict)
    result = check(solution, guess)
    culledWords = cull(guess, result, wordList)
    guesses = 1
    guessList = [guess]
    wordsLeft = [len(culledWords)]

    # first strat - best entropy guess
    while(len(culledWords) > 10):
        guesses += 1
        
        new_entropy = defaultdict(lambda: defaultdict(int))
        for word in tqdm(wordList):
        #for word in wordList:
            for guess in culledWords:
                pattern = check(word, guess)
                new_entropy[word][pattern] += 1

        new_entropy_scores = defaultdict(int)
        for word in new_entropy.keys():
            ent = 0
            for pattern in new_entropy[word].keys():
                p = new_entropy[word][pattern] / len(wordList)
                I = math.log((1/p),2)
                ent += (p*I)
            new_entropy_scores[word] = ent
        
        guess = maxEntropy(new_entropy_scores)
        guessList.append(guess)
        result = check(solution, guess)
        culledWords = cull(guess, result, culledWords)
        wordsLeft.append(len(culledWords))
        
    # final strat - greedy elimation
    while(len(culledWords) > 1):
        guesses += 1
        curr_best = len(culledWords)
        best_guess = ""
        for word in wordList:
            average = 0
            for possibleSolution in culledWords:
                average += len(cull(word,check(possibleSolution,word),culledWords))
            remaining_words = average / float(len(culledWords))
            if remaining_words < curr_best:
                best_guess = word
                curr_best = remaining_words
        
        result = check(solution, best_guess)
        guessList.append(best_guess)
        culledWords = cull(best_guess, result, culledWords)
        wordsLeft.append(len(culledWords))

    wordsLeft.append(0)
    guessList.append(culledWords[0])
    print(guesses+1)
    print(guessList)
    print(wordsLeft)

if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "watch")

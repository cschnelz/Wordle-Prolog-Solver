import sys
from typing import List

word = list(sys.argv[1])
guess = list(sys.argv[2])


result = [-1,-1,-1,-1,-1]


for i in range(5):
    if guess[i] == word[i]:
        result[i] = 2
    elif guess[i] in word:
        result[i] = 1
    else:
        result[i] = 0

copyWord = word.copy()
copyGuess= guess.copy()
for i in range(5):
    if result[i] == 2:
        copyGuess[i] = -1
        copyWord[i] = -1

for i in range(5):
    if copyGuess[i] != -1:
        letter = copyGuess[i]
        if letter in copyWord:
            copyWord[copyWord.index(letter)] = -1
            copyGuess[i] = -1
        else:
            result[i] = 0

print(f"result: {result}")
from operator import ne
from typing import List
import os

def main():
    newWordList = []
    newWordListWord = ""
    # opening the text file
    with open('stats1Random.txt','r') as file:
        flag = 0
        flag2 = 0
        # reading each line    
        for line in file:
            
            # reading each word        
            for word in line.split():          
                if word == "in":
                    flag2 = 1
                elif flag2 == 1:
                    if word != " ":
                        numGuess = word
                        newWordList.append((newWordListWord, numGuess))
                        flag2 = 0
                if word == "Word:":
                    flag = 1
                elif flag == 1:
                    if word != " ":
                        newWordListWord = word
                        flag = 0
        #newWordList.append((newWordListWord, numGuess))

    currWord = ""
    newVal = 0
    newList = []
    flagy = 0
    first = False
    for word in newWordList:
        if word[0] != currWord:
            if first == True:
                newList.append((currWord, newVal))
                print(currWord, newVal)
            first = True
            currWord = word[0]
            newVal = 0
        else:
            newVal += int(word[1])

        #print(currWord, newVal)



if __name__ == "__main__":
    main()

from operator import le
from typing import List
import os

def main():
    input: str = ""
    words: List[str] = []
    
    # opening the text file
    with open('WordleWords.txt','r') as file:
    
        # reading each line    
        for line in file:
    
            # reading each word        
            for word in line.split():         
                wordy = "" 
                input = "swipl -s firstEntropy.pl -g 'firstEntropyEntry(["
                for letterIdx in range(len(word)):
                    wordy += word[letterIdx] 
                    input += word[letterIdx]
                    if letterIdx != len(word)-1:
                        input += ","
                input += "])"+"'"+" -t halt\n"
                words.append('echo Word: '+wordy+'\necho\n')
                words.append(input)
                words.append('echo "----------------------------------"\necho\n')


    # get rid of last newline in final file
    words[-1] = words[-1][0:-1]

    f = open("commandsForStats1.txt", "w")
    for word in words:
        f.write(word)
    f.close()

if __name__ == "__main__":
    main()

from typing import List
import os

def main():
    input: str = ""
    words: List[str] = []
    
    # opening the text file
    with open('words.txt','r') as file:
    
        # reading each line    
        for line in file:
    
            # reading each word        
            for word in line.split():          
                input = "word(["
                for letterIdx in range(len(word)):
                    input += word[letterIdx]
                    if letterIdx != len(word)-1:
                        input += ","
                input += "]).\n"
                words.append(input)

    # get rid of last newline in final file
    words[-1] = words[-1][0:-1]

    f = open("words.pl", "w")
    f.write(":-dynamic word/1.\n")
    for word in words:
        f.write(word)
    f.close()

if __name__ == "__main__":
    main()

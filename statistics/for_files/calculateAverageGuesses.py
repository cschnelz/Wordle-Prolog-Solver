
import numpy as np
import pandas as pd


def main():
    pass

def get_word(wrd):
    wrd = wrd.strip("'")
    wrd = wrd.strip("(")
    wrd = wrd.strip("'")

    return wrd

def get_guess(guess):
    guess = guess.strip("'")
    guess = guess.strip(")")
    guess = guess.strip("'")

    return float(guess)


def entropy_guesses():
    guess_list = []
    gw_list = []
    with open('neatStatsEntropy.txt','r') as file:
        lines = file.read().split('\n')
        for i in range(0, len(lines) - 1):
            gw = tuple(map(str, lines[i].split(', ')))
            wrd = get_word(gw[0])
            guess = get_guess(gw[1])
            guess_list.append(guess)
            print(gw)
        print(np.array(guess_list).mean())

    

def random_guesses():
    guess_list = []
    gw_list = []
    # opening the text file
    with open('neatStatsRandom.txt','r') as file:
        # reading each line  
        lines = file.read().split('\n')

        for i in range(0, len(lines)):
            gw = lines[i].split(' ')
            guess = gw
            #guess = gw[1]
            gw_list.append(guess)

        g = []
        for guess in gw_list:
            if len(guess) == 2:
                g.append(guess[1])

        ct = 0
        for i in range(len(g)):
            ct += float(g[i])
        
        print("average guess for entire list: " +  str(ct / len(g)) )


    file.close()


if __name__ == "__main__":
    entropy_guesses()

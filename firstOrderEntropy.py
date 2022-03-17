


from collections import defaultdict
from check import check
from tqdm import tqdm
import math
import pickle


pattern_frequencies = defaultdict(lambda: defaultdict(int))
# {examined_word : { pattern : count }
# { 'apple' : { ... [0,2,1,1,0] : 23 }}

p_freq = []
words = []

with open('WordleWords.txt','r') as file:
    # reading each line    
    for line in file:
        # reading each word        
        words.append(line.split()[0])


# generate frequencies of patterns per word
for word in tqdm(words):
    for guess in words:
        pattern = check(word, guess)
        pattern_frequencies[word][pattern] += 1

        # for visual bucketing results
        if word == 'tares':
            with open('tares_p_freq.txt', 'a') as pf:
                p_freq.append(pattern_frequencies[word])
                pf.write(pattern_frequencies[word])
                pf.write("\n")
                pf.close()



# calculate entropy scores
entropy_dict = defaultdict(int)
for word in pattern_frequencies.keys():
    entropy = 0
    for pattern in pattern_frequencies[word].keys():
        p = pattern_frequencies[word][pattern] / len(words)
        I = math.log((1/p),2)
        entropy += (p * I)
    entropy_dict[word] = entropy

with open('saved_dictionary.pkl', 'wb') as f:
    pickle.dump(entropy_dict, f)



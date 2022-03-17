import pickle

with open('saved_freqs.pkl', 'rb') as f:
    loaded_dict = pickle.load(f)

import csv
with open('test.csv', 'w') as f:
    for key in loaded_dict.keys():
        f.write("%s,%s\n"%(key,loaded_dict[key]))
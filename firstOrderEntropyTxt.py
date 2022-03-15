import pickle

with open('saved_dictionary.pkl', 'rb') as f:
    loaded_dict = pickle.load(f)

f = open('entropy.txt', "w")
f.write(":-dynamic score/1.\n")
for word, score in loaded_dict.items():
    output = "score("
    output+= str(score)
    output += ").\n"
    f.write(output)
f.close

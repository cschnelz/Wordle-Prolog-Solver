run1:
	bash commandsForStats1.txt > stats1.txt


run2:
	bash commandsForStats2.txt > stats2.txt

run3:
	bash commandRandomStats1.txt > stats1Random.txt

run4:
	python3 neatStatsRandom.py > neatStatsRandom.txt
	python3 neatStatsEntropy.py > neatStatsEntropy.txt
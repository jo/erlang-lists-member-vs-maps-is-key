data.ndjson:
	./run-perf-test > data.ndjson

lists-member.csv: data.ndjson
	cat data.ndjson | jq -c -r 'select(.type == "lists:member") | [.entries, .keys, .time] | join(", ")' > lists-member.csv

maps-is-key.csv: data.ndjson
	cat data.ndjson | jq -c -r 'select(.type == "maps:is_key") | [.entries, .keys, .time] | join(", ")' > maps-is-key.csv

graph.png: lists-member.csv maps-is-key.csv
	gnuplot plot.gpi

clear:
	rm -f data.ndjson lists-member.csv maps-is-key.csv graph.png

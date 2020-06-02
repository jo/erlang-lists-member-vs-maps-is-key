default: graph.png


data.ndjson:
	./run-perf-test > data.ndjson

lists-member.csv: data.ndjson
	cat data.ndjson | jq -c -r 'select(.type == "lists:member") | [.entries, .keys, .time] | join(", ")' > lists-member.csv

maps-is-key.csv: data.ndjson
	cat data.ndjson | jq -c -r 'select(.type == "maps:is_key") | [.entries, .keys, .time] | join(", ")' > maps-is-key.csv

tuples-binary-search.csv: data.ndjson
	cat data.ndjson | jq -c -r 'select(.type == "tuples:binary_search") | [.entries, .keys, .time] | join(", ")' > tuples-binary-search.csv

sets-is-element.csv: data.ndjson
	cat data.ndjson | jq -c -r 'select(.type == "sets:is_element") | [.entries, .keys, .time] | join(", ")' > sets-is-element.csv

graph.png: lists-member.csv maps-is-key.csv tuples-binary-search.csv sets-is-element.csv
	gnuplot plot.gpi

clean:
	rm -f data.ndjson lists-member.csv maps-is-key.csv tuples-binary-search.csv sets-is-element.csv graph.png

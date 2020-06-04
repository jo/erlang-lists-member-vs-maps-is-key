default: images


data/data.ndjson:
	./run-perf-test > data/data.ndjson


data/lists-member.csv: data/data.ndjson
	cat data/data.ndjson | jq -c -r 'select(.type == "lists:member") | [.entries, .keys, .time] | join(", ")' > data/lists-member.csv

data/maps-is-key.csv: data/data.ndjson
	cat data/data.ndjson | jq -c -r 'select(.type == "maps:is_key") | [.entries, .keys, .time] | join(", ")' > data/maps-is-key.csv

data/tuples-binary-search.csv: data/data.ndjson
	cat data/data.ndjson | jq -c -r 'select(.type == "tuples:binary_search") | [.entries, .keys, .time] | join(", ")' > data/tuples-binary-search.csv

data/sets-is-element.csv: data/data.ndjson
	cat data/data.ndjson | jq -c -r 'select(.type == "sets:is_element") | [.entries, .keys, .time] | join(", ")' > data/sets-is-element.csv

data/types: data/lists-member.csv data/maps-is-key.csv data/tuples-binary-search.csv data/sets-is-element.csv


data/1-entry.csv: data/data.ndjson
	cat data/data.ndjson \
		| jq 'select(.entries == 1)' \
		| jq -r -s '. | group_by(.keys) | .[] | [.[0].keys, .[0].time, .[1].time, .[2].time, .[3].time ] | join(", ")' \
		> data/1-entry.csv

data/10-entries.csv: data/data.ndjson
	cat data/data.ndjson \
		| jq 'select(.entries == 10)' \
		| jq -r -s '. | group_by(.keys) | .[] | [.[0].keys, .[0].time, .[1].time, .[2].time, .[3].time ] | join(", ")' \
		> data/10-entries.csv

data/100-entries.csv: data/data.ndjson
	cat data/data.ndjson \
		| jq 'select(.entries == 100)' \
		| jq -r -s '. | group_by(.keys) | .[] | [.[0].keys, .[0].time, .[1].time, .[2].time, .[3].time ] | join(", ")' \
		> data/100-entries.csv

data/1000-entries.csv: data/data.ndjson
	cat data/data.ndjson \
		| jq 'select(.entries == 1000)' \
		| jq -r -s '. | group_by(.keys) | .[] | [.[0].keys, .[0].time, .[1].time, .[2].time, .[3].time ] | join(", ")' \
		> data/1000-entries.csv

data/10000-entries.csv: data/data.ndjson
	cat data/data.ndjson \
		| jq 'select(.entries == 10000)' \
		| jq -r -s '. | group_by(.keys) | .[] | [.[0].keys, .[0].time, .[1].time, .[2].time, .[3].time ] | join(", ")' \
		> data/10000-entries.csv

data/entries: data/1-entry.csv data/10-entries.csv data/100-entries.csv data/1000-entries.csv data/10000-entries.csv


data/10-keys.csv: data/data.ndjson
	cat data/data.ndjson \
		| jq 'select(.keys == 10)' \
		| jq -r -s '. | group_by(.entries) | .[] | [.[0].entries, .[0].time, .[1].time, .[2].time, .[3].time ] | join(", ")' \
		> data/10-keys.csv

data/100-keys.csv: data/data.ndjson
	cat data/data.ndjson \
		| jq 'select(.keys == 100)' \
		| jq -r -s '. | group_by(.entries) | .[] | [.[0].entries, .[0].time, .[1].time, .[2].time, .[3].time ] | join(", ")' \
		> data/100-keys.csv

data/1000-keys.csv: data/data.ndjson
	cat data/data.ndjson \
		| jq 'select(.keys == 1000)' \
		| jq -r -s '. | group_by(.entries) | .[] | [.[0].entries, .[0].time, .[1].time, .[2].time, .[3].time ] | join(", ")' \
		> data/1000-keys.csv

data/10000-keys.csv: data/data.ndjson
	cat data/data.ndjson \
		| jq 'select(.keys == 10000)' \
		| jq -r -s '. | group_by(.entries) | .[] | [.[0].entries, .[0].time, .[1].time, .[2].time, .[3].time ] | join(", ")' \
		> data/10000-keys.csv

data/100000-keys.csv: data/data.ndjson
	cat data/data.ndjson \
		| jq 'select(.keys == 100000)' \
		| jq -r -s '. | group_by(.entries) | .[] | [.[0].entries, .[0].time, .[1].time, .[2].time, .[3].time ] | join(", ")' \
		> data/100000-keys.csv

data/keys: data/10-keys.csv data/100-keys.csv data/1000-keys.csv data/10000-keys.csv data/100000-keys.csv


image/types.png: data/types
	gnuplot plot-types.gpi

image/entries.png: data/entries
	gnuplot plot-entries.gpi

image/keys.png: data/keys
	gnuplot plot-keys.gpi


images: image/types.png image/entries.png image/keys.png

clean:
	rm -f data/*
	rm -f image/*

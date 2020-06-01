# Erlang Performance Comparison `maps:is_key` versus `lists:member`
This is a script to compare the performance of `maps:is_key` versus `lists:member` used in a filter which filters a list of elements against a list of keys. Keys and elements are both all uuid strings.


## Requirements
The [run-perf-test script](run-perf-test) is based on `escript`.

Apart from `erlang-erts` you need the following commands available in order to generate the plot:
* jq
* gnuplot


## Data gathered on my machine
This is my [data.ndjson](data.ndjson) and here is a plot:

![A graph showing a 3D plot of the data](graph.png)

To run the performance test and generate the graph, run

```bash
make graph.png
```


Made with passion for the couch © 2020 by Johannes

# Erlang Performance Comparison `maps:is_key` versus `lists:member`

This my very first Erlang code, please beare with me :)

I check a list of 20k keys against a list of 500k elements. The keys and elements are uuid strings.

### `lists:member` performance:
```bash
$ time ./listsmember

real	3m18.681s
user	3m9.926s
sys	0m10.510s
```

### `maps:is_key` performance:
```sh
$ time ./mapsiskey 

real	0m51.547s
user	0m43.987s
sys	0m10.051s
[jo@linux-2 list-member]$ 
```

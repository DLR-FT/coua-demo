coua.nt: src/lib.rs mappings/requirements.ttl requirements.db traces.json
	coua check

traces.json: src/lib.rs
	coua trace src/lib.rs | jq -s '.' > traces.json

doc/build/index.html: coua.nt
	$(MAKE) -C doc html

.PHONY: clean

clean:
	$(MAKE) -C doc clean
	rm -f coua.nt traces.json

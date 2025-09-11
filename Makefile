junit.xml: test

coverage.xml: test

test: coua-demo.py
	pytest --cov-branch --junit-xml=junit.xml --cov=coua-demo --cov-report term --cov-report xml:coverage.xml coua-demo.py

requirements.db: create-db.sql
	sqlite3 requirements.db < create-db.sql

coua.nt: coua-demo.py mappings/requirements.ttl requirements.db traces.json junit.xml
	coua check

traces.json: coua-demo.py
	malkoha . > traces.json

doc/build/index.html: coua.nt
	$(MAKE) -C doc html

cert: doc/build/index.html

.PHONY: clean cert test

clean:
	$(MAKE) -C doc clean
	git clean -d -x -f

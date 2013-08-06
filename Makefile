.PHONY: build all test clean

build:
	php --define 'phar.readonly=0' ./create-phar.php

test:
	./test.sh

clean:
	rm -rf ./wukka-*.phar*

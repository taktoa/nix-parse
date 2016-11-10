SOURCE_FILES =        \
	gen/lexer-tab.cc  \
	gen/parser-tab.cc \
	main.cc

.PHONY: all clean

all: clean out/main

out/main: $(SOURCE_FILES)
	clang++ -std=c++11 -g -Wall -o out/main $(SOURCE_FILES)

gen/parser-tab.cc gen/parser-tab.hh: parser.y gen
	bison -v -o gen/parser-tab.cc parser.y -d

gen/lexer-tab.cc gen/lexer-tab.hh: lexer.l gen
	flex --outfile gen/lexer-tab.cc --header-file=gen/lexer-tab.hh lexer.l

out:
	mkdir -p out

gen:
	mkdir -p gen
	for file in include/*; do cp "$$file" gen/; done

clean:
	rm -rf gen

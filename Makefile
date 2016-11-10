CXX = g++
CXXFLAGS = -O3 -std=c++14 -Wall
LDFLAGS = -lnixformat -lnixutil -lnixexpr -lnixmain

SOURCE_FILES = main.cc

.PHONY: all install clean

all: out/nix-parse

out/nix-parse: $(SOURCE_FILES) out
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o out/nix-parse $(SOURCE_FILES)

out:
	mkdir -p out

install: out/nix-parse
	mkdir -p $$out/bin
	install out/nix-parse $$out/bin

clean:
	test -d out && rm -rf out

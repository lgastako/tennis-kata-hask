help:
	@cat Makefile

EXE=tennis-exe

build:
	stack build .

hlint:
	stack exec hlint .

install:
	stack install .

run:
	stack exec $(EXE) $(ARGS)

b: build
hl: hlint
r: run

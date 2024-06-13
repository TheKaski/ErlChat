# Makefile for Erlang project

# Define variables
APP_NAME := backend
ERL_LIBS := $(shell rebar3 path)
REBAR := $(shell which rebar3)

# Default target
all: compile

# Compile the project
compile:
	$(REBAR) compile

# Run the project
run:
	ERL_LIBS="$(ERL_LIBS):deps/cowboy" $(REBAR) shell

# Clean the project
clean:
	$(REBAR) clean

# Default target when `make` is invoked without arguments
.DEFAULT_GOAL := all
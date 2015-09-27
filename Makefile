PROJECT ?= $(shell basename `find src/ -name "*.app.src"` .app.src)

.PHONY: rel deps

all: deps compile

compile:
	rebar compile

deps:
	rebar get-deps

clean:
	rebar clean

rel: deps
	rebar compile generate

run:
	rebar compile
	erl -pa ${PWD}/apps/*/ebin ${PWD}/deps/*/ebin -name $(PROJECT)@`hostname` +A 1 -shared +K true -boot start_sasl -s $(PROJECT)

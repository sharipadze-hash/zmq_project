CC = gcc
ZMQ_PREFIX = $(CURDIR)/external/_build/zmq
CFLAGS = -Wall -O2 -I$(ZMQ_PREFIX)/include
LDFLAGS = -L$(ZMQ_PREFIX)/lib -lzmq
ERL_LIBS = _build/default/lib/server/ebin ../external/chumak/_build/default/lib/chumak/ebin

.PHONY: all build run clean

all: build

build: zmq_lib erl_build c_build

zmq_lib:
	cd external/libzmq && rm -rf build && mkdir -p build && cd build && \
	cmake .. -DCMAKE_INSTALL_PREFIX=$(ZMQ_PREFIX) \
	-DWITH_LIBSODIUM=OFF \
	-DWITH_TLS=OFF \
	-DENABLE_CURVE=OFF \
	&& make && make install

chumak_build:
	cd external/chumak && ../../erl/rebar3 compile

erl_build: chumak_build
	cd erl && ./rebar3 compile

c_build: zmq_lib
	mkdir -p bin
	$(CC) $(CFLAGS) src/send.c -o bin/send $(LDFLAGS) -Wl,-rpath,$(ZMQ_PREFIX)/lib

run:
	cd erl && erl -pa $(ERL_LIBS) -eval "server:start()"

clean:
	rm -rf bin/*
	rm -rf external/_build
	rm -rf erl/_build
	rm -rf external/chumak/_build
	cd external/libzmq/build && make clean || true

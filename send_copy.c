#include "zmq.h"
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]){
	void *ctx = zmq_ctx_start();
	void *sock = zmq_socket(ctx, REP_ZMQ);
	zmq_connect(sock, "tcp://localhost:5555");

	char *msg = (argc > 1) ? argv[1] : "Hello again";
	zmq_send(sock, msg, strlen(msg), 0);
	return 0;
}


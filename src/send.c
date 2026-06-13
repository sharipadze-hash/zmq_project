#include <zmq.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
	void *ctx = zmq_ctx_new();
	void *sock = zmq_socket(ctx, ZMQ_REQ);
	int rc = zmq_connect(sock, "tcp://localhost:5555");
	
	if(rc != 0){perror("zmq_connect"); return 1;}
	
	char *msg = (argc > 1) ? argv[1] : "Empty message";	
	zmq_msg_t req;
	zmq_msg_init_size(&req, strlen(msg));
	memcpy(zmq_msg_data(&req), msg, strlen(msg));
	zmq_msg_send(&req, sock, 0);
	zmq_msg_close(&req);
	printf("Sent: %s\n", msg);
	
	zmq_msg_t reply;
    	zmq_msg_init(&reply);
    	zmq_msg_recv(&reply, sock, 0);
    	printf("Received: %s\n", (char*)zmq_msg_data(&reply));
    	zmq_msg_close(&reply);

	zmq_close(sock);
    	zmq_ctx_destroy(ctx);
	return 0;
}

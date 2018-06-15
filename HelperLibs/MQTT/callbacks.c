#include <stdio.h>

#include <mosquitto.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

struct cbMqttMessage {
    uint16_t msgFlag;
    char topic[64];
    char payload[32];
} ;

uint32_t sizeOfMessage() {
    return ( sizeof( struct cbMqttMessage ));
}
// 
// TODO Do I need some sort of queuing mechanism ?
void messageCallback(struct mosquitto *mosq, void *obj,const struct mosquitto_message *message) { 
//    printf("messageCallback\n");

    ((struct cbMqttMessage *)obj)->msgFlag=0xffff;

    strcpy(((struct cbMqttMessage *)obj)->topic,(char *)message->topic);
    strcpy( ((struct cbMqttMessage *)obj)->payload,(char *)message->payload);

}

// 
// Use this to set up message callback.
// TODO Modify this to pass in a third parameter.
// This would select one of a number of callbacks.
// default behaviour is to fill out the cbMqttMessage structure.
//
void init(struct mosquitto *mosq) {
    printf("MQTT init run.\n");
    mosquitto_message_callback_set(mosq, messageCallback);
}


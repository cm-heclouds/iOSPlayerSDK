#ifndef DISPATCHER_PACKET_H
#define DISPATCHER_PACKET_H


#include <stdint.h>

typedef enum DispatcherPacketType {

    DISPATCHER_PT_BYTES_READ = 1,
    DISPATCHER_PT_SOUND = 2,
    DISPATCHER_PT_PLAY_CYCLE = 3,
    DISPATCHER_PT_SEEK = 4,
    DISPATCHER_PT_PAUSE = 5,
} DispatcherPacketType;

typedef struct DispatcherPacket {

    uint8_t *data;
    int   size;
    int64_t ts;
    unsigned char type;
} DispatcherPacket;

void dispatcher_init_packet(DispatcherPacket *pkt);
void dispatcher_packet_unref(DispatcherPacket *pkt);

#endif

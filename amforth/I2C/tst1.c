#include <stdint.h>
#include <stdio.h>

#include "calcedCRC16.h"

int main() {
    uint8_t data[255];
    uint8_t length=0;
    uint16_t crc=0;
    int i;
    uint16_t polynom = 0x8005;
    
    data[0]=0x04;   // len
    data[1]=0xff;   // CMD
    data[2]=0x00;   // Mode
    data[3]=0x00;   // P2
    data[4]=0x00;   // P2
    
    length=2;
    
    for(i=0;i<length;i++) {
        printf("data[%d]=0x%02x\n",i,data[i]);
        
        printf("%d\tcrcArray[data[%d]]=0x%04x\n",i,i,crcArray[data[i]]);
        crc ^= crcArray[data[i]];
    }
    printf("Final=0x%04x\n",crc);
}
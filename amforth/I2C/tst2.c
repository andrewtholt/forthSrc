#include <stdint.h>
#include <stdio.h>
#include "calcedCRC16.h"

void calcCrc(uint16_t *crc_register, uint8_t b) {
    uint16_t polynom= 0x8005;
    uint8_t shift_register;

    uint8_t data_bit, crc_bit;
    
    for (shift_register = 0x01; shift_register > 0x00; shift_register <<= 1) {
        data_bit = (b & shift_register) ? 1 : 0;
        crc_bit = *crc_register >> 15; 
        *crc_register <<= 1;
        if (data_bit != crc_bit)
            *crc_register ^= polynom;
    }   
//    return(crc_register);
}

uint16_t lookupCrc(uint16_t crc, uint8_t b) {
    
}

void atCRC( uint8_t length, uint8_t *data, uint8_t *crc)
{
    uint8_t counter;
    uint16_t crc_register = 0;
    uint16_t polynom = 0x8005;
    uint8_t shift_register;
    uint8_t data_bit, crc_bit;
    
    for (counter = 0; counter < length; counter++) {
        
        for (shift_register = 0x01; shift_register > 0x00; shift_register <<= 1) {
            printf("Shift Register 0x%02x\n",shift_register);
            printf("CRC   Register 0x%04x\n",crc_register);

            data_bit = (data[counter] & shift_register) ? 1 : 0;
            crc_bit = crc_register >> 15; 
            crc_register <<= 1;
            if (data_bit != crc_bit)
                crc_register ^= polynom;
        }   
        
        // crc_register = calcCrc(data[counter], polynom);
    }   
    crc[0] = (uint8_t)(crc_register & 0x00FF);
    crc[1] = (uint8_t)(crc_register >> 8); 
}

int main () {
    uint8_t data[8];
    uint8_t res[2];
    int i=0;
    uint16_t r=0;
    int cnt=0;
    int length;
    uint16_t crc;
    
    
    length=2;
    data[0]=0x04;   // len
    data[1]=0xff;   // CMD
    data[2]=0x00;   // Mode
    data[3]=0x00;   // P2
    data[4]=0x00;   // P2
    
    data[5]=0x00;   
    data[6]=0x00;
    data[7]=0x00;
    
    data[8]=0x00;
    
    /*
    atCRC(2,data,res);
    printf("0x%02x:res[0]=0x%02x, res[1]=0x%02x\n",i,res[0],es[1]);
    */
    
//    printf("int crcArray[256] ={ \n\t");
    crc=0;
    for(i=0;i<length;i++) {
//        calcCrc(&crc,data[i]);
        crc=lookupCrc(crc,data[i]);
    }
    printf("0x%04x\n",crc);
         


}




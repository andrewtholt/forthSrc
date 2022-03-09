#include <stdint.h>

uint16_t calcCrc(uint8_t b, uint16_t polynom) {
    uint8_t shift_register;
    uint16_t crc_register = 0;
    uint8_t data_bit, crc_bit;
    
    for (shift_register = 0x01; shift_register > 0x00; shift_register <<= 1) {
        data_bit = (b & shift_register) ? 1 : 0;
        crc_bit = crc_register >> 15; 
        crc_register <<= 1;
        if (data_bit != crc_bit)
            crc_register ^= polynom;
    }   
    return(crc_register);
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
    
    /* Random
     *    data[0]=0x08;   // len
     *    data[1]=0x1b;   // CMD - RND
     *    data[2]=0x01;   // Mode
     *    data[3]=0x00;   // P1
     *    data[4]=0x00;   // P2
     *    data[5]=0x00;   // P2
     */
    
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
    printf("0x%02x:res[0]=0x%02x, res[1]=0x%02x\n",i,res[0],res[1]);
    */
    
    printf("create crc16tab\n\t");
    for(i=0;i<256;i++) {
        r = calcCrc((uint8_t) (i & 0xff),0x8005);
//        printf("0x%02x:0x%04x\n",i,r);
        printf("0x%04x",r);
        /*
        if( i<255) {
            printf(" w, ");
        }
        */
            printf(" w, ");
        
        if( (i%8) == 7) {
            printf("\n\t");
        }
    }
         
     //        printf("0x%02x:res[0]=0x%02x, res[1]=0x%02x\n",i,res[0],res[1]);

//    atCRC(2,data,res);
//    printf("0x%02x:res[0]=0x%02x, res[1]=0x%02x\n",i,res[0],res[1]);

}




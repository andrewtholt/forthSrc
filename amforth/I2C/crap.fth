    base @ hex
    4   create crc16tab
    5      0000 w, C0C1 w, C181 w, 0140 w, C301 w, 03C0 w, 0280 w, C241 w,
    6      C601 w, 06C0 w, 0780 w, C741 w, 0500 w, C5C1 w, C481 w, 0440 w,
    7      CC01 w, 0CC0 w, 0D80 w, CD41 w, 0F00 w, CFC1 w, CE81 w, 0E40 w,
    8      0A00 w, CAC1 w, CB81 w, 0B40 w, C901 w, 09C0 w, 0880 w, C841 w,
    9      D801 w, 18C0 w, 1980 w, D941 w, 1B00 w, DBC1 w, DA81 w, 1A40 w,
    10     1E00 w, DEC1 w, DF81 w, 1F40 w, DD01 w, 1DC0 w, 1C80 w, DC41 w,
    11     1400 w, D4C1 w, D581 w, 1540 w, D701 w, 17C0 w, 1680 w, D641 w,
    12     D201 w, 12C0 w, 1380 w, D341 w, 1100 w, D1C1 w, D081 w, 1040 w,
    13     F001 w, 30C0 w, 3180 w, F141 w, 3300 w, F3C1 w, F281 w, 3240 w,␊
    14     3600 w, F6C1 w, F781 w, 3740 w, F501 w, 35C0 w, 3480 w, F441 w,
    15     3C00 w, FCC1 w, FD81 w, 3D40 w, FF01 w, 3FC0 w, 3E80 w, FE41 w,
    16     FA01 w, 3AC0 w, 3B80 w, FB41 w, 3900 w, F9C1 w, F881 w, 3840 w,
    17     2800 w, E8C1 w, E981 w, 2940 w, EB01 w, 2BC0 w, 2A80 w, EA41 w,
    18     EE01 w, 2EC0 w, 2F80 w, EF41 w, 2D00 w, EDC1 w, EC81 w, 2C40 w,
    19     E401 w, 24C0 w, 2580 w, E541 w, 2700 w, E7C1 w, E681 w, 2640 w,
    20     2200 w, E2C1 w, E381 w, 2340 w, E101 w, 21C0 w, 2080 w, E041 w,
    21     A001 w, 60C0 w, 6180 w, A141 w, 6300 w, A3C1 w, A281 w, 6240 w,
    22     6600 w, A6C1 w, A781 w, 6740 w, A501 w, 65C0 w, 6480 w, A441 w,
    23     6C00 w, ACC1 w, AD81 w, 6D40 w, AF01 w, 6FC0 w, 6E80 w, AE41 w,
    24     AA01 w, 6AC0 w, 6B80 w, AB41 w, 6900 w, A9C1 w, A881 w, 6840 w,
    25     7800 w, B8C1 w, B981 w, 7940 w, BB01 w, 7BC0 w, 7A80 w, BA41 w,
    26     BE01 w, 7EC0 w, 7F80 w, BF41 w, 7D00 w, BDC1 w, BC81 w, 7C40 w,
    27     B401 w, 74C0 w, 7580 w, B541 w, 7700 w, B7C1 w, B681 w, 7640 w,
    28     7200 w, B2C1 w, B381 w, 7340 w, B101 w, 71C0 w, 7080 w, B041 w,
    29     5000 w, 90C1 w, 9181 w, 5140 w, 9301 w, 53C0 w, 5280 w, 9241 w,
    30     9601 w, 56C0 w, 5780 w, 9741 w, 5500 w, 95C1 w, 9481 w, 5440 w,
    31     9C01 w, 5CC0 w, 5D80 w, 9D41 w, 5F00 w, 9FC1 w, 9E81 w, 5E40 w,
    32     5A00 w, 9AC1 w, 9B81 w, 5B40 w, 9901 w, 59C0 w, 5880 w, 9841 w,
    33     8801 w, 48C0 w, 4980 w, 8941 w, 4B00 w, 8BC1 w, 8A81 w, 4A40 w,
    34     4E00 w, 8EC1 w, 8F81 w, 4F40 w, 8D01 w, 4DC0 w, 4C80 w, 8C41 w,
    35     4400 w, 84C1 w, 8581 w, 4540 w, 8701 w, 47C0 w, 4680 w, 8641 w,
    36     8201 w, 42C0 w, 4380 w, 8341 w, 4100 w, 81C1 w, 8081 w, 4040 w,
    37  base !
    38  
    39  
    40  : ($crc16)  ( crc adr len -- crc' )
    41     bounds  ?do              ( crc )
    42        wbsplit  swap         ( b.high b.low )
    43        i c@                  ( b.high b.low c )
    44        xor                   ( b.high b.low^c )
    45        crc16tab swap wa+ w@  ( b.high w.tabval )
    46        xor                   ( crc' )
    47     loop
    48  ;

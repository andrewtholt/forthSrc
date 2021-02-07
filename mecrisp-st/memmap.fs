\ TEMPLATE FILE for STM32F103xx
\ created by svdcutter for Mecrisp-Stellaris Forth by Matthias Koch
\ sdvcutter  takes a CMSIS-SVD file plus a hand edited config.xml file as input 
\ Copyright 2019  t.porter <terry@tjporter.com.au>, licensed under the GPL

 compiletoflash

\ available forth template words as selected by config.xml

$40021000 constant RCC ( Reset and clock control ) 
RCC $0 + constant RCC_CR ( Clock control register ) 
RCC $4 + constant RCC_CFGR ( Clock configuration register  RCC_CFGR ) 
RCC $8 + constant RCC_CIR ( Clock interrupt register  RCC_CIR ) 
RCC $C + constant RCC_APB2RSTR ( APB2 peripheral reset register  RCC_APB2RSTR ) 
RCC $10 + constant RCC_APB1RSTR ( APB1 peripheral reset register  RCC_APB1RSTR ) 
RCC $14 + constant RCC_AHBENR ( AHB Peripheral Clock enable register  RCC_AHBENR ) 
RCC $18 + constant RCC_APB2ENR ( APB2 peripheral clock enable register  RCC_APB2ENR ) 
RCC $1C + constant RCC_APB1ENR ( APB1 peripheral clock enable register  RCC_APB1ENR ) 
RCC $20 + constant RCC_BDCR ( Backup domain control register  RCC_BDCR ) 
RCC $24 + constant RCC_CSR ( Control/status register  RCC_CSR ) 
: RCC_CR. cr ." RCC_CR () $" RCC_CR @ hex. RCC_CR 1b. ;
: RCC_CFGR. cr ." RCC_CFGR () $" RCC_CFGR @ hex. RCC_CFGR 1b. ;
: RCC_CIR. cr ." RCC_CIR () $" RCC_CIR @ hex. RCC_CIR 1b. ;
: RCC_APB2RSTR. cr ." RCC_APB2RSTR (read-write) $" RCC_APB2RSTR @ hex. RCC_APB2RSTR 1b. ;
: RCC_APB1RSTR. cr ." RCC_APB1RSTR (read-write) $" RCC_APB1RSTR @ hex. RCC_APB1RSTR 1b. ;
: RCC_AHBENR. cr ." RCC_AHBENR (read-write) $" RCC_AHBENR @ hex. RCC_AHBENR 1b. ;
: RCC_APB2ENR. cr ." RCC_APB2ENR (read-write) $" RCC_APB2ENR @ hex. RCC_APB2ENR 1b. ;
: RCC_APB1ENR. cr ." RCC_APB1ENR (read-write) $" RCC_APB1ENR @ hex. RCC_APB1ENR 1b. ;
: RCC_BDCR. cr ." RCC_BDCR () $" RCC_BDCR @ hex. RCC_BDCR 1b. ;
: RCC_CSR. cr ." RCC_CSR () $" RCC_CSR @ hex. RCC_CSR 1b. ;
: RCC.
RCC_CR.
RCC_CFGR.
RCC_CIR.
RCC_APB2RSTR.
RCC_APB1RSTR.
RCC_AHBENR.
RCC_APB2ENR.
RCC_APB1ENR.
RCC_BDCR.
RCC_CSR.
;

$40010800 constant GPIOA ( General purpose I/O ) 
GPIOA $0 + constant GPIOA_CRL ( Port configuration register low  GPIOn_CRL ) 
GPIOA $4 + constant GPIOA_CRH ( Port configuration register high  GPIOn_CRL ) 
GPIOA $8 + constant GPIOA_IDR ( Port input data register  GPIOn_IDR ) 
GPIOA $C + constant GPIOA_ODR ( Port output data register  GPIOn_ODR ) 
GPIOA $10 + constant GPIOA_BSRR ( Port bit set/reset register  GPIOn_BSRR ) 
GPIOA $14 + constant GPIOA_BRR ( Port bit reset register  GPIOn_BRR ) 
GPIOA $18 + constant GPIOA_LCKR ( Port configuration lock  register ) 
: GPIOA_CRL. cr ." GPIOA_CRL (read-write) $" GPIOA_CRL @ hex. GPIOA_CRL 1b. ;
: GPIOA_CRH. cr ." GPIOA_CRH (read-write) $" GPIOA_CRH @ hex. GPIOA_CRH 1b. ;
: GPIOA_IDR. cr ." GPIOA_IDR (read-only) $" GPIOA_IDR @ hex. GPIOA_IDR 1b. ;
: GPIOA_ODR. cr ." GPIOA_ODR (read-write) $" GPIOA_ODR @ hex. GPIOA_ODR 1b. ;
: GPIOA_BSRR. cr ." GPIOA_BSRR (write-only) $" GPIOA_BSRR @ hex. GPIOA_BSRR 1b. ;
: GPIOA_BRR. cr ." GPIOA_BRR (write-only) $" GPIOA_BRR @ hex. GPIOA_BRR 1b. ;
: GPIOA_LCKR. cr ." GPIOA_LCKR (read-write) $" GPIOA_LCKR @ hex. GPIOA_LCKR 1b. ;
: GPIOA.
GPIOA_CRL.
GPIOA_CRH.
GPIOA_IDR.
GPIOA_ODR.
GPIOA_BSRR.
GPIOA_BRR.
GPIOA_LCKR.
;

$40010C00 constant GPIOB ( General purpose I/O ) 
GPIOB $0 + constant GPIOB_CRL ( Port configuration register low  GPIOn_CRL ) 
GPIOB $4 + constant GPIOB_CRH ( Port configuration register high  GPIOn_CRL ) 
GPIOB $8 + constant GPIOB_IDR ( Port input data register  GPIOn_IDR ) 
GPIOB $C + constant GPIOB_ODR ( Port output data register  GPIOn_ODR ) 
GPIOB $10 + constant GPIOB_BSRR ( Port bit set/reset register  GPIOn_BSRR ) 
GPIOB $14 + constant GPIOB_BRR ( Port bit reset register  GPIOn_BRR ) 
GPIOB $18 + constant GPIOB_LCKR ( Port configuration lock  register ) 
: GPIOB_CRL. cr ." GPIOB_CRL (read-write) $" GPIOB_CRL @ hex. GPIOB_CRL 1b. ;
: GPIOB_CRH. cr ." GPIOB_CRH (read-write) $" GPIOB_CRH @ hex. GPIOB_CRH 1b. ;
: GPIOB_IDR. cr ." GPIOB_IDR (read-only) $" GPIOB_IDR @ hex. GPIOB_IDR 1b. ;
: GPIOB_ODR. cr ." GPIOB_ODR (read-write) $" GPIOB_ODR @ hex. GPIOB_ODR 1b. ;
: GPIOB_BSRR. cr ." GPIOB_BSRR (write-only) $" GPIOB_BSRR @ hex. GPIOB_BSRR 1b. ;
: GPIOB_BRR. cr ." GPIOB_BRR (write-only) $" GPIOB_BRR @ hex. GPIOB_BRR 1b. ;
: GPIOB_LCKR. cr ." GPIOB_LCKR (read-write) $" GPIOB_LCKR @ hex. GPIOB_LCKR 1b. ;
: GPIOB.
GPIOB_CRL.
GPIOB_CRH.
GPIOB_IDR.
GPIOB_ODR.
GPIOB_BSRR.
GPIOB_BRR.
GPIOB_LCKR.
;

$40011000 constant GPIOC ( General purpose I/O ) 
GPIOC $0 + constant GPIOC_CRL ( Port configuration register low  GPIOn_CRL ) 
GPIOC $4 + constant GPIOC_CRH ( Port configuration register high  GPIOn_CRL ) 
GPIOC $8 + constant GPIOC_IDR ( Port input data register  GPIOn_IDR ) 
GPIOC $C + constant GPIOC_ODR ( Port output data register  GPIOn_ODR ) 
GPIOC $10 + constant GPIOC_BSRR ( Port bit set/reset register  GPIOn_BSRR ) 
GPIOC $14 + constant GPIOC_BRR ( Port bit reset register  GPIOn_BRR ) 
GPIOC $18 + constant GPIOC_LCKR ( Port configuration lock  register ) 
: GPIOC_CRL. cr ." GPIOC_CRL (read-write) $" GPIOC_CRL @ hex. GPIOC_CRL 1b. ;
: GPIOC_CRH. cr ." GPIOC_CRH (read-write) $" GPIOC_CRH @ hex. GPIOC_CRH 1b. ;
: GPIOC_IDR. cr ." GPIOC_IDR (read-only) $" GPIOC_IDR @ hex. GPIOC_IDR 1b. ;
: GPIOC_ODR. cr ." GPIOC_ODR (read-write) $" GPIOC_ODR @ hex. GPIOC_ODR 1b. ;
: GPIOC_BSRR. cr ." GPIOC_BSRR (write-only) $" GPIOC_BSRR @ hex. GPIOC_BSRR 1b. ;
: GPIOC_BRR. cr ." GPIOC_BRR (write-only) $" GPIOC_BRR @ hex. GPIOC_BRR 1b. ;
: GPIOC_LCKR. cr ." GPIOC_LCKR (read-write) $" GPIOC_LCKR @ hex. GPIOC_LCKR 1b. ;
: GPIOC.
GPIOC_CRL.
GPIOC_CRH.
GPIOC_IDR.
GPIOC_ODR.
GPIOC_BSRR.
GPIOC_BRR.
GPIOC_LCKR.
;


compiletoram

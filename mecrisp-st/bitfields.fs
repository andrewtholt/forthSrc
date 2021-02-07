\ STM32F103xx Register Bitfield Definitions for Mecrisp-Stellaris Forth by Matthias Koch. 
\ bitfield.xsl takes STM32Fxx.svd, config.xml and produces bitfield.fs
\ Written by Terry Porter "terry@tjporter.com.au" 2016 - 2018 and released under the GPL V2.
\ Replace 'bis!' (set bit) with 'bic!' to CLEAR bit, 'bit@' to test bit etc.

compiletoram	  \ safeguard against accidental uploading of whole file

\ RCC_CR ()
: RCC_CR_HSION   %1 0 lshift RCC_CR bis! ;  \ RCC_CR_HSION    Internal High Speed clock  enable
: RCC_CR_HSIRDY   %1 1 lshift RCC_CR bis! ;  \ RCC_CR_HSIRDY    Internal High Speed clock ready  flag
: RCC_CR_HSITRIM   ( %XXXXX -- ) 3 lshift RCC_CR bis! ;  \ RCC_CR_HSITRIM    Internal High Speed clock  trimming
: RCC_CR_HSICAL   ( %XXXXXXXX -- ) 8 lshift RCC_CR bis! ;  \ RCC_CR_HSICAL    Internal High Speed clock  Calibration
: RCC_CR_HSEON   %1 16 lshift RCC_CR bis! ;  \ RCC_CR_HSEON    External High Speed clock  enable
: RCC_CR_HSERDY   %1 17 lshift RCC_CR bis! ;  \ RCC_CR_HSERDY    External High Speed clock ready  flag
: RCC_CR_HSEBYP   %1 18 lshift RCC_CR bis! ;  \ RCC_CR_HSEBYP    External High Speed clock  Bypass
: RCC_CR_CSSON   %1 19 lshift RCC_CR bis! ;  \ RCC_CR_CSSON    Clock Security System  enable
: RCC_CR_PLLON   %1 24 lshift RCC_CR bis! ;  \ RCC_CR_PLLON    PLL enable
: RCC_CR_PLLRDY   %1 25 lshift RCC_CR bis! ;  \ RCC_CR_PLLRDY    PLL clock ready flag

\ RCC_CFGR ()
: RCC_CFGR_SW   ( %XX -- ) 0 lshift RCC_CFGR bis! ;  \ RCC_CFGR_SW    System clock Switch
: RCC_CFGR_SWS   ( %XX -- ) 2 lshift RCC_CFGR bis! ;  \ RCC_CFGR_SWS    System Clock Switch Status
: RCC_CFGR_HPRE   ( %XXXX -- ) 4 lshift RCC_CFGR bis! ;  \ RCC_CFGR_HPRE    AHB prescaler
: RCC_CFGR_PPRE1   ( %XXX -- ) 8 lshift RCC_CFGR bis! ;  \ RCC_CFGR_PPRE1    APB Low speed prescaler  APB1
: RCC_CFGR_PPRE2   ( %XXX -- ) 11 lshift RCC_CFGR bis! ;  \ RCC_CFGR_PPRE2    APB High speed prescaler  APB2
: RCC_CFGR_ADCPRE   ( %XX -- ) 14 lshift RCC_CFGR bis! ;  \ RCC_CFGR_ADCPRE    ADC prescaler
: RCC_CFGR_PLLSRC   %1 16 lshift RCC_CFGR bis! ;  \ RCC_CFGR_PLLSRC    PLL entry clock source
: RCC_CFGR_PLLXTPRE   %1 17 lshift RCC_CFGR bis! ;  \ RCC_CFGR_PLLXTPRE    HSE divider for PLL entry
: RCC_CFGR_PLLMUL   ( %XXXX -- ) 18 lshift RCC_CFGR bis! ;  \ RCC_CFGR_PLLMUL    PLL Multiplication Factor
: RCC_CFGR_OTGFSPRE   %1 22 lshift RCC_CFGR bis! ;  \ RCC_CFGR_OTGFSPRE    USB OTG FS prescaler
: RCC_CFGR_MCO   ( %XXX -- ) 24 lshift RCC_CFGR bis! ;  \ RCC_CFGR_MCO    Microcontroller clock  output

\ RCC_CIR ()
: RCC_CIR_LSIRDYF   %1 0 lshift RCC_CIR bis! ;  \ RCC_CIR_LSIRDYF    LSI Ready Interrupt flag
: RCC_CIR_LSERDYF   %1 1 lshift RCC_CIR bis! ;  \ RCC_CIR_LSERDYF    LSE Ready Interrupt flag
: RCC_CIR_HSIRDYF   %1 2 lshift RCC_CIR bis! ;  \ RCC_CIR_HSIRDYF    HSI Ready Interrupt flag
: RCC_CIR_HSERDYF   %1 3 lshift RCC_CIR bis! ;  \ RCC_CIR_HSERDYF    HSE Ready Interrupt flag
: RCC_CIR_PLLRDYF   %1 4 lshift RCC_CIR bis! ;  \ RCC_CIR_PLLRDYF    PLL Ready Interrupt flag
: RCC_CIR_CSSF   %1 7 lshift RCC_CIR bis! ;  \ RCC_CIR_CSSF    Clock Security System Interrupt  flag
: RCC_CIR_LSIRDYIE   %1 8 lshift RCC_CIR bis! ;  \ RCC_CIR_LSIRDYIE    LSI Ready Interrupt Enable
: RCC_CIR_LSERDYIE   %1 9 lshift RCC_CIR bis! ;  \ RCC_CIR_LSERDYIE    LSE Ready Interrupt Enable
: RCC_CIR_HSIRDYIE   %1 10 lshift RCC_CIR bis! ;  \ RCC_CIR_HSIRDYIE    HSI Ready Interrupt Enable
: RCC_CIR_HSERDYIE   %1 11 lshift RCC_CIR bis! ;  \ RCC_CIR_HSERDYIE    HSE Ready Interrupt Enable
: RCC_CIR_PLLRDYIE   %1 12 lshift RCC_CIR bis! ;  \ RCC_CIR_PLLRDYIE    PLL Ready Interrupt Enable
: RCC_CIR_LSIRDYC   %1 16 lshift RCC_CIR bis! ;  \ RCC_CIR_LSIRDYC    LSI Ready Interrupt Clear
: RCC_CIR_LSERDYC   %1 17 lshift RCC_CIR bis! ;  \ RCC_CIR_LSERDYC    LSE Ready Interrupt Clear
: RCC_CIR_HSIRDYC   %1 18 lshift RCC_CIR bis! ;  \ RCC_CIR_HSIRDYC    HSI Ready Interrupt Clear
: RCC_CIR_HSERDYC   %1 19 lshift RCC_CIR bis! ;  \ RCC_CIR_HSERDYC    HSE Ready Interrupt Clear
: RCC_CIR_PLLRDYC   %1 20 lshift RCC_CIR bis! ;  \ RCC_CIR_PLLRDYC    PLL Ready Interrupt Clear
: RCC_CIR_CSSC   %1 23 lshift RCC_CIR bis! ;  \ RCC_CIR_CSSC    Clock security system interrupt  clear

\ RCC_APB2RSTR (read-write)
: RCC_APB2RSTR_AFIORST   %1 0 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_AFIORST    Alternate function I/O  reset
: RCC_APB2RSTR_IOPARST   %1 2 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_IOPARST    IO port A reset
: RCC_APB2RSTR_IOPBRST   %1 3 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_IOPBRST    IO port B reset
: RCC_APB2RSTR_IOPCRST   %1 4 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_IOPCRST    IO port C reset
: RCC_APB2RSTR_IOPDRST   %1 5 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_IOPDRST    IO port D reset
: RCC_APB2RSTR_IOPERST   %1 6 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_IOPERST    IO port E reset
: RCC_APB2RSTR_IOPFRST   %1 7 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_IOPFRST    IO port F reset
: RCC_APB2RSTR_IOPGRST   %1 8 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_IOPGRST    IO port G reset
: RCC_APB2RSTR_ADC1RST   %1 9 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_ADC1RST    ADC 1 interface reset
: RCC_APB2RSTR_ADC2RST   %1 10 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_ADC2RST    ADC 2 interface reset
: RCC_APB2RSTR_TIM1RST   %1 11 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_TIM1RST    TIM1 timer reset
: RCC_APB2RSTR_SPI1RST   %1 12 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_SPI1RST    SPI 1 reset
: RCC_APB2RSTR_TIM8RST   %1 13 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_TIM8RST    TIM8 timer reset
: RCC_APB2RSTR_USART1RST   %1 14 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_USART1RST    USART1 reset
: RCC_APB2RSTR_ADC3RST   %1 15 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_ADC3RST    ADC 3 interface reset
: RCC_APB2RSTR_TIM9RST   %1 19 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_TIM9RST    TIM9 timer reset
: RCC_APB2RSTR_TIM10RST   %1 20 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_TIM10RST    TIM10 timer reset
: RCC_APB2RSTR_TIM11RST   %1 21 lshift RCC_APB2RSTR bis! ;  \ RCC_APB2RSTR_TIM11RST    TIM11 timer reset

\ RCC_APB1RSTR (read-write)
: RCC_APB1RSTR_TIM2RST   %1 0 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_TIM2RST    Timer 2 reset
: RCC_APB1RSTR_TIM3RST   %1 1 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_TIM3RST    Timer 3 reset
: RCC_APB1RSTR_TIM4RST   %1 2 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_TIM4RST    Timer 4 reset
: RCC_APB1RSTR_TIM5RST   %1 3 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_TIM5RST    Timer 5 reset
: RCC_APB1RSTR_TIM6RST   %1 4 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_TIM6RST    Timer 6 reset
: RCC_APB1RSTR_TIM7RST   %1 5 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_TIM7RST    Timer 7 reset
: RCC_APB1RSTR_TIM12RST   %1 6 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_TIM12RST    Timer 12 reset
: RCC_APB1RSTR_TIM13RST   %1 7 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_TIM13RST    Timer 13 reset
: RCC_APB1RSTR_TIM14RST   %1 8 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_TIM14RST    Timer 14 reset
: RCC_APB1RSTR_WWDGRST   %1 11 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_WWDGRST    Window watchdog reset
: RCC_APB1RSTR_SPI2RST   %1 14 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_SPI2RST    SPI2 reset
: RCC_APB1RSTR_SPI3RST   %1 15 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_SPI3RST    SPI3 reset
: RCC_APB1RSTR_USART2RST   %1 17 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_USART2RST    USART 2 reset
: RCC_APB1RSTR_USART3RST   %1 18 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_USART3RST    USART 3 reset
: RCC_APB1RSTR_UART4RST   %1 19 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_UART4RST    UART 4 reset
: RCC_APB1RSTR_UART5RST   %1 20 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_UART5RST    UART 5 reset
: RCC_APB1RSTR_I2C1RST   %1 21 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_I2C1RST    I2C1 reset
: RCC_APB1RSTR_I2C2RST   %1 22 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_I2C2RST    I2C2 reset
: RCC_APB1RSTR_USBRST   %1 23 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_USBRST    USB reset
: RCC_APB1RSTR_CANRST   %1 25 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_CANRST    CAN reset
: RCC_APB1RSTR_BKPRST   %1 27 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_BKPRST    Backup interface reset
: RCC_APB1RSTR_PWRRST   %1 28 lshift RCC_APB1RSTR bis! ;  \ RCC_APB1RSTR_PWRRST    Power interface reset

\ RCC_AHBENR (read-write)
: RCC_AHBENR_DMA1EN   %1 0 lshift RCC_AHBENR bis! ;  \ RCC_AHBENR_DMA1EN    DMA1 clock enable
: RCC_AHBENR_DMA2EN   %1 1 lshift RCC_AHBENR bis! ;  \ RCC_AHBENR_DMA2EN    DMA2 clock enable
: RCC_AHBENR_SRAMEN   %1 2 lshift RCC_AHBENR bis! ;  \ RCC_AHBENR_SRAMEN    SRAM interface clock  enable
: RCC_AHBENR_FLITFEN   %1 4 lshift RCC_AHBENR bis! ;  \ RCC_AHBENR_FLITFEN    FLITF clock enable
: RCC_AHBENR_CRCEN   %1 6 lshift RCC_AHBENR bis! ;  \ RCC_AHBENR_CRCEN    CRC clock enable
: RCC_AHBENR_FSMCEN   %1 8 lshift RCC_AHBENR bis! ;  \ RCC_AHBENR_FSMCEN    FSMC clock enable
: RCC_AHBENR_SDIOEN   %1 10 lshift RCC_AHBENR bis! ;  \ RCC_AHBENR_SDIOEN    SDIO clock enable

\ RCC_APB2ENR (read-write)
: RCC_APB2ENR_AFIOEN   %1 0 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_AFIOEN    Alternate function I/O clock  enable
: RCC_APB2ENR_IOPAEN   %1 2 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_IOPAEN    I/O port A clock enable
: RCC_APB2ENR_IOPBEN   %1 3 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_IOPBEN    I/O port B clock enable
: RCC_APB2ENR_IOPCEN   %1 4 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_IOPCEN    I/O port C clock enable
: RCC_APB2ENR_IOPDEN   %1 5 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_IOPDEN    I/O port D clock enable
: RCC_APB2ENR_IOPEEN   %1 6 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_IOPEEN    I/O port E clock enable
: RCC_APB2ENR_IOPFEN   %1 7 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_IOPFEN    I/O port F clock enable
: RCC_APB2ENR_IOPGEN   %1 8 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_IOPGEN    I/O port G clock enable
: RCC_APB2ENR_ADC1EN   %1 9 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_ADC1EN    ADC 1 interface clock  enable
: RCC_APB2ENR_ADC2EN   %1 10 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_ADC2EN    ADC 2 interface clock  enable
: RCC_APB2ENR_TIM1EN   %1 11 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_TIM1EN    TIM1 Timer clock enable
: RCC_APB2ENR_SPI1EN   %1 12 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_SPI1EN    SPI 1 clock enable
: RCC_APB2ENR_TIM8EN   %1 13 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_TIM8EN    TIM8 Timer clock enable
: RCC_APB2ENR_USART1EN   %1 14 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_USART1EN    USART1 clock enable
: RCC_APB2ENR_ADC3EN   %1 15 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_ADC3EN    ADC3 interface clock  enable
: RCC_APB2ENR_TIM9EN   %1 19 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_TIM9EN    TIM9 Timer clock enable
: RCC_APB2ENR_TIM10EN   %1 20 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_TIM10EN    TIM10 Timer clock enable
: RCC_APB2ENR_TIM11EN   %1 21 lshift RCC_APB2ENR bis! ;  \ RCC_APB2ENR_TIM11EN    TIM11 Timer clock enable

\ RCC_APB1ENR (read-write)
: RCC_APB1ENR_TIM2EN   %1 0 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_TIM2EN    Timer 2 clock enable
: RCC_APB1ENR_TIM3EN   %1 1 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_TIM3EN    Timer 3 clock enable
: RCC_APB1ENR_TIM4EN   %1 2 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_TIM4EN    Timer 4 clock enable
: RCC_APB1ENR_TIM5EN   %1 3 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_TIM5EN    Timer 5 clock enable
: RCC_APB1ENR_TIM6EN   %1 4 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_TIM6EN    Timer 6 clock enable
: RCC_APB1ENR_TIM7EN   %1 5 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_TIM7EN    Timer 7 clock enable
: RCC_APB1ENR_TIM12EN   %1 6 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_TIM12EN    Timer 12 clock enable
: RCC_APB1ENR_TIM13EN   %1 7 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_TIM13EN    Timer 13 clock enable
: RCC_APB1ENR_TIM14EN   %1 8 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_TIM14EN    Timer 14 clock enable
: RCC_APB1ENR_WWDGEN   %1 11 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_WWDGEN    Window watchdog clock  enable
: RCC_APB1ENR_SPI2EN   %1 14 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_SPI2EN    SPI 2 clock enable
: RCC_APB1ENR_SPI3EN   %1 15 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_SPI3EN    SPI 3 clock enable
: RCC_APB1ENR_USART2EN   %1 17 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_USART2EN    USART 2 clock enable
: RCC_APB1ENR_USART3EN   %1 18 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_USART3EN    USART 3 clock enable
: RCC_APB1ENR_UART4EN   %1 19 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_UART4EN    UART 4 clock enable
: RCC_APB1ENR_UART5EN   %1 20 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_UART5EN    UART 5 clock enable
: RCC_APB1ENR_I2C1EN   %1 21 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_I2C1EN    I2C 1 clock enable
: RCC_APB1ENR_I2C2EN   %1 22 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_I2C2EN    I2C 2 clock enable
: RCC_APB1ENR_USBEN   %1 23 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_USBEN    USB clock enable
: RCC_APB1ENR_CANEN   %1 25 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_CANEN    CAN clock enable
: RCC_APB1ENR_BKPEN   %1 27 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_BKPEN    Backup interface clock  enable
: RCC_APB1ENR_PWREN   %1 28 lshift RCC_APB1ENR bis! ;  \ RCC_APB1ENR_PWREN    Power interface clock  enable

\ RCC_BDCR ()
: RCC_BDCR_LSEON   %1 0 lshift RCC_BDCR bis! ;  \ RCC_BDCR_LSEON    External Low Speed oscillator  enable
: RCC_BDCR_LSERDY   %1 1 lshift RCC_BDCR bis! ;  \ RCC_BDCR_LSERDY    External Low Speed oscillator  ready
: RCC_BDCR_LSEBYP   %1 2 lshift RCC_BDCR bis! ;  \ RCC_BDCR_LSEBYP    External Low Speed oscillator  bypass
: RCC_BDCR_RTCSEL   ( %XX -- ) 8 lshift RCC_BDCR bis! ;  \ RCC_BDCR_RTCSEL    RTC clock source selection
: RCC_BDCR_RTCEN   %1 15 lshift RCC_BDCR bis! ;  \ RCC_BDCR_RTCEN    RTC clock enable
: RCC_BDCR_BDRST   %1 16 lshift RCC_BDCR bis! ;  \ RCC_BDCR_BDRST    Backup domain software  reset

\ RCC_CSR ()
: RCC_CSR_LSION   %1 0 lshift RCC_CSR bis! ;  \ RCC_CSR_LSION    Internal low speed oscillator  enable
: RCC_CSR_LSIRDY   %1 1 lshift RCC_CSR bis! ;  \ RCC_CSR_LSIRDY    Internal low speed oscillator  ready
: RCC_CSR_RMVF   %1 24 lshift RCC_CSR bis! ;  \ RCC_CSR_RMVF    Remove reset flag
: RCC_CSR_PINRSTF   %1 26 lshift RCC_CSR bis! ;  \ RCC_CSR_PINRSTF    PIN reset flag
: RCC_CSR_PORRSTF   %1 27 lshift RCC_CSR bis! ;  \ RCC_CSR_PORRSTF    POR/PDR reset flag
: RCC_CSR_SFTRSTF   %1 28 lshift RCC_CSR bis! ;  \ RCC_CSR_SFTRSTF    Software reset flag
: RCC_CSR_IWDGRSTF   %1 29 lshift RCC_CSR bis! ;  \ RCC_CSR_IWDGRSTF    Independent watchdog reset  flag
: RCC_CSR_WWDGRSTF   %1 30 lshift RCC_CSR bis! ;  \ RCC_CSR_WWDGRSTF    Window watchdog reset flag
: RCC_CSR_LPWRRSTF   %1 31 lshift RCC_CSR bis! ;  \ RCC_CSR_LPWRRSTF    Low-power reset flag

\ GPIOA_CRL (read-write)
: GPIOA_CRL_MODE0   ( %XX -- ) 0 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_MODE0    Port n.0 mode bits
: GPIOA_CRL_CNF0   ( %XX -- ) 2 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_CNF0    Port n.0 configuration  bits
: GPIOA_CRL_MODE1   ( %XX -- ) 4 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_MODE1    Port n.1 mode bits
: GPIOA_CRL_CNF1   ( %XX -- ) 6 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_CNF1    Port n.1 configuration  bits
: GPIOA_CRL_MODE2   ( %XX -- ) 8 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_MODE2    Port n.2 mode bits
: GPIOA_CRL_CNF2   ( %XX -- ) 10 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_CNF2    Port n.2 configuration  bits
: GPIOA_CRL_MODE3   ( %XX -- ) 12 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_MODE3    Port n.3 mode bits
: GPIOA_CRL_CNF3   ( %XX -- ) 14 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_CNF3    Port n.3 configuration  bits
: GPIOA_CRL_MODE4   ( %XX -- ) 16 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_MODE4    Port n.4 mode bits
: GPIOA_CRL_CNF4   ( %XX -- ) 18 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_CNF4    Port n.4 configuration  bits
: GPIOA_CRL_MODE5   ( %XX -- ) 20 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_MODE5    Port n.5 mode bits
: GPIOA_CRL_CNF5   ( %XX -- ) 22 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_CNF5    Port n.5 configuration  bits
: GPIOA_CRL_MODE6   ( %XX -- ) 24 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_MODE6    Port n.6 mode bits
: GPIOA_CRL_CNF6   ( %XX -- ) 26 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_CNF6    Port n.6 configuration  bits
: GPIOA_CRL_MODE7   ( %XX -- ) 28 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_MODE7    Port n.7 mode bits
: GPIOA_CRL_CNF7   ( %XX -- ) 30 lshift GPIOA_CRL bis! ;  \ GPIOA_CRL_CNF7    Port n.7 configuration  bits

\ GPIOA_CRH (read-write)
: GPIOA_CRH_MODE8   ( %XX -- ) 0 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_MODE8    Port n.8 mode bits
: GPIOA_CRH_CNF8   ( %XX -- ) 2 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_CNF8    Port n.8 configuration  bits
: GPIOA_CRH_MODE9   ( %XX -- ) 4 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_MODE9    Port n.9 mode bits
: GPIOA_CRH_CNF9   ( %XX -- ) 6 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_CNF9    Port n.9 configuration  bits
: GPIOA_CRH_MODE10   ( %XX -- ) 8 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_MODE10    Port n.10 mode bits
: GPIOA_CRH_CNF10   ( %XX -- ) 10 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_CNF10    Port n.10 configuration  bits
: GPIOA_CRH_MODE11   ( %XX -- ) 12 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_MODE11    Port n.11 mode bits
: GPIOA_CRH_CNF11   ( %XX -- ) 14 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_CNF11    Port n.11 configuration  bits
: GPIOA_CRH_MODE12   ( %XX -- ) 16 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_MODE12    Port n.12 mode bits
: GPIOA_CRH_CNF12   ( %XX -- ) 18 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_CNF12    Port n.12 configuration  bits
: GPIOA_CRH_MODE13   ( %XX -- ) 20 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_MODE13    Port n.13 mode bits
: GPIOA_CRH_CNF13   ( %XX -- ) 22 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_CNF13    Port n.13 configuration  bits
: GPIOA_CRH_MODE14   ( %XX -- ) 24 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_MODE14    Port n.14 mode bits
: GPIOA_CRH_CNF14   ( %XX -- ) 26 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_CNF14    Port n.14 configuration  bits
: GPIOA_CRH_MODE15   ( %XX -- ) 28 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_MODE15    Port n.15 mode bits
: GPIOA_CRH_CNF15   ( %XX -- ) 30 lshift GPIOA_CRH bis! ;  \ GPIOA_CRH_CNF15    Port n.15 configuration  bits

\ GPIOA_IDR (read-only)
: GPIOA_IDR_IDR0   %1 0 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR0    Port input data
: GPIOA_IDR_IDR1   %1 1 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR1    Port input data
: GPIOA_IDR_IDR2   %1 2 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR2    Port input data
: GPIOA_IDR_IDR3   %1 3 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR3    Port input data
: GPIOA_IDR_IDR4   %1 4 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR4    Port input data
: GPIOA_IDR_IDR5   %1 5 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR5    Port input data
: GPIOA_IDR_IDR6   %1 6 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR6    Port input data
: GPIOA_IDR_IDR7   %1 7 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR7    Port input data
: GPIOA_IDR_IDR8   %1 8 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR8    Port input data
: GPIOA_IDR_IDR9   %1 9 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR9    Port input data
: GPIOA_IDR_IDR10   %1 10 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR10    Port input data
: GPIOA_IDR_IDR11   %1 11 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR11    Port input data
: GPIOA_IDR_IDR12   %1 12 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR12    Port input data
: GPIOA_IDR_IDR13   %1 13 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR13    Port input data
: GPIOA_IDR_IDR14   %1 14 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR14    Port input data
: GPIOA_IDR_IDR15   %1 15 lshift GPIOA_IDR bis! ;  \ GPIOA_IDR_IDR15    Port input data

\ GPIOA_ODR (read-write)
: GPIOA_ODR_ODR0   %1 0 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR0    Port output data
: GPIOA_ODR_ODR1   %1 1 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR1    Port output data
: GPIOA_ODR_ODR2   %1 2 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR2    Port output data
: GPIOA_ODR_ODR3   %1 3 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR3    Port output data
: GPIOA_ODR_ODR4   %1 4 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR4    Port output data
: GPIOA_ODR_ODR5   %1 5 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR5    Port output data
: GPIOA_ODR_ODR6   %1 6 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR6    Port output data
: GPIOA_ODR_ODR7   %1 7 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR7    Port output data
: GPIOA_ODR_ODR8   %1 8 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR8    Port output data
: GPIOA_ODR_ODR9   %1 9 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR9    Port output data
: GPIOA_ODR_ODR10   %1 10 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR10    Port output data
: GPIOA_ODR_ODR11   %1 11 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR11    Port output data
: GPIOA_ODR_ODR12   %1 12 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR12    Port output data
: GPIOA_ODR_ODR13   %1 13 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR13    Port output data
: GPIOA_ODR_ODR14   %1 14 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR14    Port output data
: GPIOA_ODR_ODR15   %1 15 lshift GPIOA_ODR bis! ;  \ GPIOA_ODR_ODR15    Port output data

\ GPIOA_BSRR (write-only)
: GPIOA_BSRR_BS0   %1 0 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS0    Set bit 0
: GPIOA_BSRR_BS1   %1 1 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS1    Set bit 1
: GPIOA_BSRR_BS2   %1 2 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS2    Set bit 1
: GPIOA_BSRR_BS3   %1 3 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS3    Set bit 3
: GPIOA_BSRR_BS4   %1 4 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS4    Set bit 4
: GPIOA_BSRR_BS5   %1 5 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS5    Set bit 5
: GPIOA_BSRR_BS6   %1 6 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS6    Set bit 6
: GPIOA_BSRR_BS7   %1 7 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS7    Set bit 7
: GPIOA_BSRR_BS8   %1 8 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS8    Set bit 8
: GPIOA_BSRR_BS9   %1 9 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS9    Set bit 9
: GPIOA_BSRR_BS10   %1 10 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS10    Set bit 10
: GPIOA_BSRR_BS11   %1 11 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS11    Set bit 11
: GPIOA_BSRR_BS12   %1 12 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS12    Set bit 12
: GPIOA_BSRR_BS13   %1 13 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS13    Set bit 13
: GPIOA_BSRR_BS14   %1 14 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS14    Set bit 14
: GPIOA_BSRR_BS15   %1 15 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BS15    Set bit 15
: GPIOA_BSRR_BR0   %1 16 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR0    Reset bit 0
: GPIOA_BSRR_BR1   %1 17 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR1    Reset bit 1
: GPIOA_BSRR_BR2   %1 18 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR2    Reset bit 2
: GPIOA_BSRR_BR3   %1 19 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR3    Reset bit 3
: GPIOA_BSRR_BR4   %1 20 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR4    Reset bit 4
: GPIOA_BSRR_BR5   %1 21 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR5    Reset bit 5
: GPIOA_BSRR_BR6   %1 22 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR6    Reset bit 6
: GPIOA_BSRR_BR7   %1 23 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR7    Reset bit 7
: GPIOA_BSRR_BR8   %1 24 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR8    Reset bit 8
: GPIOA_BSRR_BR9   %1 25 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR9    Reset bit 9
: GPIOA_BSRR_BR10   %1 26 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR10    Reset bit 10
: GPIOA_BSRR_BR11   %1 27 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR11    Reset bit 11
: GPIOA_BSRR_BR12   %1 28 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR12    Reset bit 12
: GPIOA_BSRR_BR13   %1 29 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR13    Reset bit 13
: GPIOA_BSRR_BR14   %1 30 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR14    Reset bit 14
: GPIOA_BSRR_BR15   %1 31 lshift GPIOA_BSRR bis! ;  \ GPIOA_BSRR_BR15    Reset bit 15

\ GPIOA_BRR (write-only)
: GPIOA_BRR_BR0   %1 0 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR0    Reset bit 0
: GPIOA_BRR_BR1   %1 1 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR1    Reset bit 1
: GPIOA_BRR_BR2   %1 2 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR2    Reset bit 1
: GPIOA_BRR_BR3   %1 3 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR3    Reset bit 3
: GPIOA_BRR_BR4   %1 4 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR4    Reset bit 4
: GPIOA_BRR_BR5   %1 5 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR5    Reset bit 5
: GPIOA_BRR_BR6   %1 6 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR6    Reset bit 6
: GPIOA_BRR_BR7   %1 7 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR7    Reset bit 7
: GPIOA_BRR_BR8   %1 8 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR8    Reset bit 8
: GPIOA_BRR_BR9   %1 9 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR9    Reset bit 9
: GPIOA_BRR_BR10   %1 10 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR10    Reset bit 10
: GPIOA_BRR_BR11   %1 11 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR11    Reset bit 11
: GPIOA_BRR_BR12   %1 12 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR12    Reset bit 12
: GPIOA_BRR_BR13   %1 13 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR13    Reset bit 13
: GPIOA_BRR_BR14   %1 14 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR14    Reset bit 14
: GPIOA_BRR_BR15   %1 15 lshift GPIOA_BRR bis! ;  \ GPIOA_BRR_BR15    Reset bit 15

\ GPIOA_LCKR (read-write)
: GPIOA_LCKR_LCK0   %1 0 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK0    Port A Lock bit 0
: GPIOA_LCKR_LCK1   %1 1 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK1    Port A Lock bit 1
: GPIOA_LCKR_LCK2   %1 2 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK2    Port A Lock bit 2
: GPIOA_LCKR_LCK3   %1 3 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK3    Port A Lock bit 3
: GPIOA_LCKR_LCK4   %1 4 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK4    Port A Lock bit 4
: GPIOA_LCKR_LCK5   %1 5 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK5    Port A Lock bit 5
: GPIOA_LCKR_LCK6   %1 6 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK6    Port A Lock bit 6
: GPIOA_LCKR_LCK7   %1 7 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK7    Port A Lock bit 7
: GPIOA_LCKR_LCK8   %1 8 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK8    Port A Lock bit 8
: GPIOA_LCKR_LCK9   %1 9 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK9    Port A Lock bit 9
: GPIOA_LCKR_LCK10   %1 10 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK10    Port A Lock bit 10
: GPIOA_LCKR_LCK11   %1 11 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK11    Port A Lock bit 11
: GPIOA_LCKR_LCK12   %1 12 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK12    Port A Lock bit 12
: GPIOA_LCKR_LCK13   %1 13 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK13    Port A Lock bit 13
: GPIOA_LCKR_LCK14   %1 14 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK14    Port A Lock bit 14
: GPIOA_LCKR_LCK15   %1 15 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCK15    Port A Lock bit 15
: GPIOA_LCKR_LCKK   %1 16 lshift GPIOA_LCKR bis! ;  \ GPIOA_LCKR_LCKK    Lock key

\ GPIOB_CRL (read-write)
: GPIOB_CRL_MODE0   ( %XX -- ) 0 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_MODE0    Port n.0 mode bits
: GPIOB_CRL_CNF0   ( %XX -- ) 2 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_CNF0    Port n.0 configuration  bits
: GPIOB_CRL_MODE1   ( %XX -- ) 4 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_MODE1    Port n.1 mode bits
: GPIOB_CRL_CNF1   ( %XX -- ) 6 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_CNF1    Port n.1 configuration  bits
: GPIOB_CRL_MODE2   ( %XX -- ) 8 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_MODE2    Port n.2 mode bits
: GPIOB_CRL_CNF2   ( %XX -- ) 10 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_CNF2    Port n.2 configuration  bits
: GPIOB_CRL_MODE3   ( %XX -- ) 12 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_MODE3    Port n.3 mode bits
: GPIOB_CRL_CNF3   ( %XX -- ) 14 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_CNF3    Port n.3 configuration  bits
: GPIOB_CRL_MODE4   ( %XX -- ) 16 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_MODE4    Port n.4 mode bits
: GPIOB_CRL_CNF4   ( %XX -- ) 18 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_CNF4    Port n.4 configuration  bits
: GPIOB_CRL_MODE5   ( %XX -- ) 20 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_MODE5    Port n.5 mode bits
: GPIOB_CRL_CNF5   ( %XX -- ) 22 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_CNF5    Port n.5 configuration  bits
: GPIOB_CRL_MODE6   ( %XX -- ) 24 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_MODE6    Port n.6 mode bits
: GPIOB_CRL_CNF6   ( %XX -- ) 26 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_CNF6    Port n.6 configuration  bits
: GPIOB_CRL_MODE7   ( %XX -- ) 28 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_MODE7    Port n.7 mode bits
: GPIOB_CRL_CNF7   ( %XX -- ) 30 lshift GPIOB_CRL bis! ;  \ GPIOB_CRL_CNF7    Port n.7 configuration  bits

\ GPIOB_CRH (read-write)
: GPIOB_CRH_MODE8   ( %XX -- ) 0 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_MODE8    Port n.8 mode bits
: GPIOB_CRH_CNF8   ( %XX -- ) 2 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_CNF8    Port n.8 configuration  bits
: GPIOB_CRH_MODE9   ( %XX -- ) 4 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_MODE9    Port n.9 mode bits
: GPIOB_CRH_CNF9   ( %XX -- ) 6 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_CNF9    Port n.9 configuration  bits
: GPIOB_CRH_MODE10   ( %XX -- ) 8 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_MODE10    Port n.10 mode bits
: GPIOB_CRH_CNF10   ( %XX -- ) 10 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_CNF10    Port n.10 configuration  bits
: GPIOB_CRH_MODE11   ( %XX -- ) 12 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_MODE11    Port n.11 mode bits
: GPIOB_CRH_CNF11   ( %XX -- ) 14 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_CNF11    Port n.11 configuration  bits
: GPIOB_CRH_MODE12   ( %XX -- ) 16 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_MODE12    Port n.12 mode bits
: GPIOB_CRH_CNF12   ( %XX -- ) 18 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_CNF12    Port n.12 configuration  bits
: GPIOB_CRH_MODE13   ( %XX -- ) 20 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_MODE13    Port n.13 mode bits
: GPIOB_CRH_CNF13   ( %XX -- ) 22 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_CNF13    Port n.13 configuration  bits
: GPIOB_CRH_MODE14   ( %XX -- ) 24 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_MODE14    Port n.14 mode bits
: GPIOB_CRH_CNF14   ( %XX -- ) 26 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_CNF14    Port n.14 configuration  bits
: GPIOB_CRH_MODE15   ( %XX -- ) 28 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_MODE15    Port n.15 mode bits
: GPIOB_CRH_CNF15   ( %XX -- ) 30 lshift GPIOB_CRH bis! ;  \ GPIOB_CRH_CNF15    Port n.15 configuration  bits

\ GPIOB_IDR (read-only)
: GPIOB_IDR_IDR0   %1 0 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR0    Port input data
: GPIOB_IDR_IDR1   %1 1 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR1    Port input data
: GPIOB_IDR_IDR2   %1 2 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR2    Port input data
: GPIOB_IDR_IDR3   %1 3 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR3    Port input data
: GPIOB_IDR_IDR4   %1 4 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR4    Port input data
: GPIOB_IDR_IDR5   %1 5 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR5    Port input data
: GPIOB_IDR_IDR6   %1 6 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR6    Port input data
: GPIOB_IDR_IDR7   %1 7 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR7    Port input data
: GPIOB_IDR_IDR8   %1 8 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR8    Port input data
: GPIOB_IDR_IDR9   %1 9 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR9    Port input data
: GPIOB_IDR_IDR10   %1 10 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR10    Port input data
: GPIOB_IDR_IDR11   %1 11 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR11    Port input data
: GPIOB_IDR_IDR12   %1 12 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR12    Port input data
: GPIOB_IDR_IDR13   %1 13 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR13    Port input data
: GPIOB_IDR_IDR14   %1 14 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR14    Port input data
: GPIOB_IDR_IDR15   %1 15 lshift GPIOB_IDR bis! ;  \ GPIOB_IDR_IDR15    Port input data

\ GPIOB_ODR (read-write)
: GPIOB_ODR_ODR0   %1 0 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR0    Port output data
: GPIOB_ODR_ODR1   %1 1 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR1    Port output data
: GPIOB_ODR_ODR2   %1 2 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR2    Port output data
: GPIOB_ODR_ODR3   %1 3 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR3    Port output data
: GPIOB_ODR_ODR4   %1 4 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR4    Port output data
: GPIOB_ODR_ODR5   %1 5 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR5    Port output data
: GPIOB_ODR_ODR6   %1 6 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR6    Port output data
: GPIOB_ODR_ODR7   %1 7 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR7    Port output data
: GPIOB_ODR_ODR8   %1 8 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR8    Port output data
: GPIOB_ODR_ODR9   %1 9 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR9    Port output data
: GPIOB_ODR_ODR10   %1 10 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR10    Port output data
: GPIOB_ODR_ODR11   %1 11 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR11    Port output data
: GPIOB_ODR_ODR12   %1 12 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR12    Port output data
: GPIOB_ODR_ODR13   %1 13 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR13    Port output data
: GPIOB_ODR_ODR14   %1 14 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR14    Port output data
: GPIOB_ODR_ODR15   %1 15 lshift GPIOB_ODR bis! ;  \ GPIOB_ODR_ODR15    Port output data

\ GPIOB_BSRR (write-only)
: GPIOB_BSRR_BS0   %1 0 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS0    Set bit 0
: GPIOB_BSRR_BS1   %1 1 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS1    Set bit 1
: GPIOB_BSRR_BS2   %1 2 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS2    Set bit 1
: GPIOB_BSRR_BS3   %1 3 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS3    Set bit 3
: GPIOB_BSRR_BS4   %1 4 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS4    Set bit 4
: GPIOB_BSRR_BS5   %1 5 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS5    Set bit 5
: GPIOB_BSRR_BS6   %1 6 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS6    Set bit 6
: GPIOB_BSRR_BS7   %1 7 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS7    Set bit 7
: GPIOB_BSRR_BS8   %1 8 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS8    Set bit 8
: GPIOB_BSRR_BS9   %1 9 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS9    Set bit 9
: GPIOB_BSRR_BS10   %1 10 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS10    Set bit 10
: GPIOB_BSRR_BS11   %1 11 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS11    Set bit 11
: GPIOB_BSRR_BS12   %1 12 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS12    Set bit 12
: GPIOB_BSRR_BS13   %1 13 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS13    Set bit 13
: GPIOB_BSRR_BS14   %1 14 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS14    Set bit 14
: GPIOB_BSRR_BS15   %1 15 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BS15    Set bit 15
: GPIOB_BSRR_BR0   %1 16 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR0    Reset bit 0
: GPIOB_BSRR_BR1   %1 17 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR1    Reset bit 1
: GPIOB_BSRR_BR2   %1 18 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR2    Reset bit 2
: GPIOB_BSRR_BR3   %1 19 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR3    Reset bit 3
: GPIOB_BSRR_BR4   %1 20 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR4    Reset bit 4
: GPIOB_BSRR_BR5   %1 21 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR5    Reset bit 5
: GPIOB_BSRR_BR6   %1 22 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR6    Reset bit 6
: GPIOB_BSRR_BR7   %1 23 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR7    Reset bit 7
: GPIOB_BSRR_BR8   %1 24 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR8    Reset bit 8
: GPIOB_BSRR_BR9   %1 25 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR9    Reset bit 9
: GPIOB_BSRR_BR10   %1 26 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR10    Reset bit 10
: GPIOB_BSRR_BR11   %1 27 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR11    Reset bit 11
: GPIOB_BSRR_BR12   %1 28 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR12    Reset bit 12
: GPIOB_BSRR_BR13   %1 29 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR13    Reset bit 13
: GPIOB_BSRR_BR14   %1 30 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR14    Reset bit 14
: GPIOB_BSRR_BR15   %1 31 lshift GPIOB_BSRR bis! ;  \ GPIOB_BSRR_BR15    Reset bit 15

\ GPIOB_BRR (write-only)
: GPIOB_BRR_BR0   %1 0 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR0    Reset bit 0
: GPIOB_BRR_BR1   %1 1 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR1    Reset bit 1
: GPIOB_BRR_BR2   %1 2 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR2    Reset bit 1
: GPIOB_BRR_BR3   %1 3 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR3    Reset bit 3
: GPIOB_BRR_BR4   %1 4 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR4    Reset bit 4
: GPIOB_BRR_BR5   %1 5 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR5    Reset bit 5
: GPIOB_BRR_BR6   %1 6 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR6    Reset bit 6
: GPIOB_BRR_BR7   %1 7 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR7    Reset bit 7
: GPIOB_BRR_BR8   %1 8 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR8    Reset bit 8
: GPIOB_BRR_BR9   %1 9 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR9    Reset bit 9
: GPIOB_BRR_BR10   %1 10 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR10    Reset bit 10
: GPIOB_BRR_BR11   %1 11 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR11    Reset bit 11
: GPIOB_BRR_BR12   %1 12 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR12    Reset bit 12
: GPIOB_BRR_BR13   %1 13 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR13    Reset bit 13
: GPIOB_BRR_BR14   %1 14 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR14    Reset bit 14
: GPIOB_BRR_BR15   %1 15 lshift GPIOB_BRR bis! ;  \ GPIOB_BRR_BR15    Reset bit 15

\ GPIOB_LCKR (read-write)
: GPIOB_LCKR_LCK0   %1 0 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK0    Port A Lock bit 0
: GPIOB_LCKR_LCK1   %1 1 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK1    Port A Lock bit 1
: GPIOB_LCKR_LCK2   %1 2 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK2    Port A Lock bit 2
: GPIOB_LCKR_LCK3   %1 3 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK3    Port A Lock bit 3
: GPIOB_LCKR_LCK4   %1 4 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK4    Port A Lock bit 4
: GPIOB_LCKR_LCK5   %1 5 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK5    Port A Lock bit 5
: GPIOB_LCKR_LCK6   %1 6 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK6    Port A Lock bit 6
: GPIOB_LCKR_LCK7   %1 7 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK7    Port A Lock bit 7
: GPIOB_LCKR_LCK8   %1 8 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK8    Port A Lock bit 8
: GPIOB_LCKR_LCK9   %1 9 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK9    Port A Lock bit 9
: GPIOB_LCKR_LCK10   %1 10 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK10    Port A Lock bit 10
: GPIOB_LCKR_LCK11   %1 11 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK11    Port A Lock bit 11
: GPIOB_LCKR_LCK12   %1 12 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK12    Port A Lock bit 12
: GPIOB_LCKR_LCK13   %1 13 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK13    Port A Lock bit 13
: GPIOB_LCKR_LCK14   %1 14 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK14    Port A Lock bit 14
: GPIOB_LCKR_LCK15   %1 15 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCK15    Port A Lock bit 15
: GPIOB_LCKR_LCKK   %1 16 lshift GPIOB_LCKR bis! ;  \ GPIOB_LCKR_LCKK    Lock key

\ GPIOC_CRL (read-write)
: GPIOC_CRL_MODE0   ( %XX -- ) 0 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_MODE0    Port n.0 mode bits
: GPIOC_CRL_CNF0   ( %XX -- ) 2 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_CNF0    Port n.0 configuration  bits
: GPIOC_CRL_MODE1   ( %XX -- ) 4 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_MODE1    Port n.1 mode bits
: GPIOC_CRL_CNF1   ( %XX -- ) 6 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_CNF1    Port n.1 configuration  bits
: GPIOC_CRL_MODE2   ( %XX -- ) 8 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_MODE2    Port n.2 mode bits
: GPIOC_CRL_CNF2   ( %XX -- ) 10 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_CNF2    Port n.2 configuration  bits
: GPIOC_CRL_MODE3   ( %XX -- ) 12 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_MODE3    Port n.3 mode bits
: GPIOC_CRL_CNF3   ( %XX -- ) 14 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_CNF3    Port n.3 configuration  bits
: GPIOC_CRL_MODE4   ( %XX -- ) 16 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_MODE4    Port n.4 mode bits
: GPIOC_CRL_CNF4   ( %XX -- ) 18 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_CNF4    Port n.4 configuration  bits
: GPIOC_CRL_MODE5   ( %XX -- ) 20 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_MODE5    Port n.5 mode bits
: GPIOC_CRL_CNF5   ( %XX -- ) 22 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_CNF5    Port n.5 configuration  bits
: GPIOC_CRL_MODE6   ( %XX -- ) 24 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_MODE6    Port n.6 mode bits
: GPIOC_CRL_CNF6   ( %XX -- ) 26 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_CNF6    Port n.6 configuration  bits
: GPIOC_CRL_MODE7   ( %XX -- ) 28 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_MODE7    Port n.7 mode bits
: GPIOC_CRL_CNF7   ( %XX -- ) 30 lshift GPIOC_CRL bis! ;  \ GPIOC_CRL_CNF7    Port n.7 configuration  bits

\ GPIOC_CRH (read-write)
: GPIOC_CRH_MODE8   ( %XX -- ) 0 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_MODE8    Port n.8 mode bits
: GPIOC_CRH_CNF8   ( %XX -- ) 2 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_CNF8    Port n.8 configuration  bits
: GPIOC_CRH_MODE9   ( %XX -- ) 4 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_MODE9    Port n.9 mode bits
: GPIOC_CRH_CNF9   ( %XX -- ) 6 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_CNF9    Port n.9 configuration  bits
: GPIOC_CRH_MODE10   ( %XX -- ) 8 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_MODE10    Port n.10 mode bits
: GPIOC_CRH_CNF10   ( %XX -- ) 10 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_CNF10    Port n.10 configuration  bits
: GPIOC_CRH_MODE11   ( %XX -- ) 12 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_MODE11    Port n.11 mode bits
: GPIOC_CRH_CNF11   ( %XX -- ) 14 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_CNF11    Port n.11 configuration  bits
: GPIOC_CRH_MODE12   ( %XX -- ) 16 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_MODE12    Port n.12 mode bits
: GPIOC_CRH_CNF12   ( %XX -- ) 18 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_CNF12    Port n.12 configuration  bits
: GPIOC_CRH_MODE13   ( %XX -- ) 20 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_MODE13    Port n.13 mode bits
: GPIOC_CRH_CNF13   ( %XX -- ) 22 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_CNF13    Port n.13 configuration  bits
: GPIOC_CRH_MODE14   ( %XX -- ) 24 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_MODE14    Port n.14 mode bits
: GPIOC_CRH_CNF14   ( %XX -- ) 26 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_CNF14    Port n.14 configuration  bits
: GPIOC_CRH_MODE15   ( %XX -- ) 28 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_MODE15    Port n.15 mode bits
: GPIOC_CRH_CNF15   ( %XX -- ) 30 lshift GPIOC_CRH bis! ;  \ GPIOC_CRH_CNF15    Port n.15 configuration  bits

\ GPIOC_IDR (read-only)
: GPIOC_IDR_IDR0   %1 0 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR0    Port input data
: GPIOC_IDR_IDR1   %1 1 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR1    Port input data
: GPIOC_IDR_IDR2   %1 2 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR2    Port input data
: GPIOC_IDR_IDR3   %1 3 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR3    Port input data
: GPIOC_IDR_IDR4   %1 4 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR4    Port input data
: GPIOC_IDR_IDR5   %1 5 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR5    Port input data
: GPIOC_IDR_IDR6   %1 6 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR6    Port input data
: GPIOC_IDR_IDR7   %1 7 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR7    Port input data
: GPIOC_IDR_IDR8   %1 8 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR8    Port input data
: GPIOC_IDR_IDR9   %1 9 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR9    Port input data
: GPIOC_IDR_IDR10   %1 10 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR10    Port input data
: GPIOC_IDR_IDR11   %1 11 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR11    Port input data
: GPIOC_IDR_IDR12   %1 12 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR12    Port input data
: GPIOC_IDR_IDR13   %1 13 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR13    Port input data
: GPIOC_IDR_IDR14   %1 14 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR14    Port input data
: GPIOC_IDR_IDR15   %1 15 lshift GPIOC_IDR bis! ;  \ GPIOC_IDR_IDR15    Port input data

\ GPIOC_ODR (read-write)
: GPIOC_ODR_ODR0   %1 0 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR0    Port output data
: GPIOC_ODR_ODR1   %1 1 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR1    Port output data
: GPIOC_ODR_ODR2   %1 2 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR2    Port output data
: GPIOC_ODR_ODR3   %1 3 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR3    Port output data
: GPIOC_ODR_ODR4   %1 4 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR4    Port output data
: GPIOC_ODR_ODR5   %1 5 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR5    Port output data
: GPIOC_ODR_ODR6   %1 6 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR6    Port output data
: GPIOC_ODR_ODR7   %1 7 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR7    Port output data
: GPIOC_ODR_ODR8   %1 8 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR8    Port output data
: GPIOC_ODR_ODR9   %1 9 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR9    Port output data
: GPIOC_ODR_ODR10   %1 10 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR10    Port output data
: GPIOC_ODR_ODR11   %1 11 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR11    Port output data
: GPIOC_ODR_ODR12   %1 12 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR12    Port output data
: GPIOC_ODR_ODR13   %1 13 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR13    Port output data
: GPIOC_ODR_ODR14   %1 14 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR14    Port output data
: GPIOC_ODR_ODR15   %1 15 lshift GPIOC_ODR bis! ;  \ GPIOC_ODR_ODR15    Port output data

\ GPIOC_BSRR (write-only)
: GPIOC_BSRR_BS0   %1 0 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS0    Set bit 0
: GPIOC_BSRR_BS1   %1 1 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS1    Set bit 1
: GPIOC_BSRR_BS2   %1 2 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS2    Set bit 1
: GPIOC_BSRR_BS3   %1 3 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS3    Set bit 3
: GPIOC_BSRR_BS4   %1 4 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS4    Set bit 4
: GPIOC_BSRR_BS5   %1 5 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS5    Set bit 5
: GPIOC_BSRR_BS6   %1 6 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS6    Set bit 6
: GPIOC_BSRR_BS7   %1 7 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS7    Set bit 7
: GPIOC_BSRR_BS8   %1 8 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS8    Set bit 8
: GPIOC_BSRR_BS9   %1 9 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS9    Set bit 9
: GPIOC_BSRR_BS10   %1 10 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS10    Set bit 10
: GPIOC_BSRR_BS11   %1 11 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS11    Set bit 11
: GPIOC_BSRR_BS12   %1 12 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS12    Set bit 12
: GPIOC_BSRR_BS13   %1 13 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS13    Set bit 13
: GPIOC_BSRR_BS14   %1 14 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS14    Set bit 14
: GPIOC_BSRR_BS15   %1 15 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BS15    Set bit 15
: GPIOC_BSRR_BR0   %1 16 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR0    Reset bit 0
: GPIOC_BSRR_BR1   %1 17 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR1    Reset bit 1
: GPIOC_BSRR_BR2   %1 18 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR2    Reset bit 2
: GPIOC_BSRR_BR3   %1 19 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR3    Reset bit 3
: GPIOC_BSRR_BR4   %1 20 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR4    Reset bit 4
: GPIOC_BSRR_BR5   %1 21 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR5    Reset bit 5
: GPIOC_BSRR_BR6   %1 22 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR6    Reset bit 6
: GPIOC_BSRR_BR7   %1 23 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR7    Reset bit 7
: GPIOC_BSRR_BR8   %1 24 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR8    Reset bit 8
: GPIOC_BSRR_BR9   %1 25 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR9    Reset bit 9
: GPIOC_BSRR_BR10   %1 26 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR10    Reset bit 10
: GPIOC_BSRR_BR11   %1 27 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR11    Reset bit 11
: GPIOC_BSRR_BR12   %1 28 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR12    Reset bit 12
: GPIOC_BSRR_BR13   %1 29 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR13    Reset bit 13
: GPIOC_BSRR_BR14   %1 30 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR14    Reset bit 14
: GPIOC_BSRR_BR15   %1 31 lshift GPIOC_BSRR bis! ;  \ GPIOC_BSRR_BR15    Reset bit 15

\ GPIOC_BRR (write-only)
: GPIOC_BRR_BR0   %1 0 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR0    Reset bit 0
: GPIOC_BRR_BR1   %1 1 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR1    Reset bit 1
: GPIOC_BRR_BR2   %1 2 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR2    Reset bit 1
: GPIOC_BRR_BR3   %1 3 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR3    Reset bit 3
: GPIOC_BRR_BR4   %1 4 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR4    Reset bit 4
: GPIOC_BRR_BR5   %1 5 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR5    Reset bit 5
: GPIOC_BRR_BR6   %1 6 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR6    Reset bit 6
: GPIOC_BRR_BR7   %1 7 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR7    Reset bit 7
: GPIOC_BRR_BR8   %1 8 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR8    Reset bit 8
: GPIOC_BRR_BR9   %1 9 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR9    Reset bit 9
: GPIOC_BRR_BR10   %1 10 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR10    Reset bit 10
: GPIOC_BRR_BR11   %1 11 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR11    Reset bit 11
: GPIOC_BRR_BR12   %1 12 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR12    Reset bit 12
: GPIOC_BRR_BR13   %1 13 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR13    Reset bit 13
: GPIOC_BRR_BR14   %1 14 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR14    Reset bit 14
: GPIOC_BRR_BR15   %1 15 lshift GPIOC_BRR bis! ;  \ GPIOC_BRR_BR15    Reset bit 15

\ GPIOC_LCKR (read-write)
: GPIOC_LCKR_LCK0   %1 0 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK0    Port A Lock bit 0
: GPIOC_LCKR_LCK1   %1 1 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK1    Port A Lock bit 1
: GPIOC_LCKR_LCK2   %1 2 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK2    Port A Lock bit 2
: GPIOC_LCKR_LCK3   %1 3 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK3    Port A Lock bit 3
: GPIOC_LCKR_LCK4   %1 4 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK4    Port A Lock bit 4
: GPIOC_LCKR_LCK5   %1 5 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK5    Port A Lock bit 5
: GPIOC_LCKR_LCK6   %1 6 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK6    Port A Lock bit 6
: GPIOC_LCKR_LCK7   %1 7 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK7    Port A Lock bit 7
: GPIOC_LCKR_LCK8   %1 8 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK8    Port A Lock bit 8
: GPIOC_LCKR_LCK9   %1 9 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK9    Port A Lock bit 9
: GPIOC_LCKR_LCK10   %1 10 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK10    Port A Lock bit 10
: GPIOC_LCKR_LCK11   %1 11 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK11    Port A Lock bit 11
: GPIOC_LCKR_LCK12   %1 12 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK12    Port A Lock bit 12
: GPIOC_LCKR_LCK13   %1 13 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK13    Port A Lock bit 13
: GPIOC_LCKR_LCK14   %1 14 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK14    Port A Lock bit 14
: GPIOC_LCKR_LCK15   %1 15 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCK15    Port A Lock bit 15
: GPIOC_LCKR_LCKK   %1 16 lshift GPIOC_LCKR bis! ;  \ GPIOC_LCKR_LCKK    Lock key

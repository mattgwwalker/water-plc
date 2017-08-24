// Water purification plant
//
// Uses reverse osmosis to produce very clean water.
//
// 2017-08-24:
// The plant had the option to attach an air compressor.  This code turns power
// to that air compressor (AC01) on and off.  The air compressor was probably 
// responsible for regulating its own pressure.  This feature is not necessary
// if compressed air is available on site.

REG &LT02_percent = &AUX1

REG &LT07_percent = &AUX2

REG &LT03_percent = &AUX3

REG &PP03_SPD = &AUX5
MEM &D2A_AOP1_ZERO = 0
MEM &D2A_AOP1_FULL_SCALE = 10000 
MEM &DATA_SOURCE_ANALOG1 = ADDR(&PP03_SPD)

REG &fd100StepNumber = &AUX6
MEM &fd100StepNumber = 0

REG &fd101StepNumber = &AUX7
MEM &fd101StepNumber = 0

REG &fd102StepNumber = &AUX8
MEM &fd102StepNumber = 0

REG &T0acc = &AUX9
MEM &T0acc = 0 

//BitFlags
BIT |AFI = |GPF1
BIT |FD100_Fill = |GPF2
BIT |FD101_Fill = |GPF3
BIT |FD101_FillOk = |GPF4
BIT |PP03_run1 = |GPF5
BIT |PP03_run2 = |GPF6
BIT |PP03_run3 = |GPF7
BIT |PP03_run4 = |GPF8
 
//Integer_Variables
REG &lastScanTimeFast = &INTEGER_VARIABLE1
REG &lastScanTimeShort = &INTEGER_VARIABLE2
REG &Temp1 = &INTEGER_VARIABLE3
REG &Temp2 = &INTEGER_VARIABLE4
REG &Temp3 = &INTEGER_VARIABLE5
REG &LT07v1 = &INTEGER_VARIABLE6
REG &OP_MODE = &INTEGER_VARIABLE7

//Float_Variables
REG &Calc01 = &FLOAT_VARIABLE1
REG &Calc02 = &FLOAT_VARIABLE2
REG &Calc03 = &FLOAT_VARIABLE3
REG &Calc04 = &FLOAT_VARIABLE4
REG &Calc05 = &FLOAT_VARIABLE5
REG &Calc06 = &FLOAT_VARIABLE6

//IO Mapping
BIT |LS01_UNCOVERED = |DI_1
BIT |PS01_MADE = |DI_2
BIT |SW01_SELECTED = |DI_3
BIT |SW02_SELECTED = |DI_4
BIT |SW03_SELECTED = |DI_5
BIT |SW04_SELECTED = |DI_6
BIT |SW05_SELECTED = |DI_7
BIT |SW06_SELECTED = |DI_8
BIT |CS04_LOW = |DI_9
 
BIT |SV02_OPEN = |DO_1
BIT |SV03_OPEN = |DO_2
BIT |SV04_OPEN = |DO_3
BIT |SV05_OPEN = |DO_4
BIT |SV06_OPEN = |DO_5
BIT |SV08_OPEN = |DO_6
BIT |IL01_ON = |DO_7
BIT |PP02_RUN = |DO_8
BIT |PP03_RUN = |DO_9
BIT |AC01_RUN = |DO_10

//User_Memory_1 to 99 Display Format x.x
MEM &USER_MEMORY16_BAND1 = 5219
MEM &DISPLAY_FORMAT_USER16_BAND1 = 6


//User_Memory_100 to 199 Display Format x.xx
MEM &USER_MEMORY16_BAND2 = 5319
MEM &DISPLAY_FORMAT_USER16_BAND2 = 5

REG &CS04sp01 = &USER_MEMORY_100
REG &CS04sp02 = &USER_MEMORY_101
MEM &CS04sp02 = 18000 //180s
REG &CS04sp03 = &USER_MEMORY_102

REG &FD100sp08 = &USER_MEMORY_103
MEM &FD100sp08 = 6000 //60s

REG &LT02sp01 = &USER_MEMORY_104
MEM &LT02sp01 = 9900 //99.00%
REG &LT02sp02 = &USER_MEMORY_105
MEM &LT02sp02 = 7000 //70.00%
REG &LT02sp03 = &USER_MEMORY_106
MEM &LT02sp03 = 500 //5.00%

REG &LT07sp01 = &USER_MEMORY_107
MEM &LT07sp01 = 5000 //50.00%
REG &LT07sp02 = &USER_MEMORY_108
MEM &LT07sp02 = 9900 //99.00%
REG &LT07sp03 = &USER_MEMORY_109
MEM &LT07sp03 = 1000 //10.00%
REG &LT07sp04 = &USER_MEMORY_110
MEM &LT07sp04 = 5000 //50.00%
REG &LT07sp05 = &USER_MEMORY_111
MEM &LT07sp05 = 5000 //50.00%

REG &LT03sp01 = &USER_MEMORY_112
MEM &LT03sp01 = 5000 //50.00%
REG &LT03sp02 = &USER_MEMORY_113
MEM &LT03sp02 = 9000 //90.00%
REG &LT03sp03 = &USER_MEMORY_114
MEM &LT03sp03 = 1000 //10.00%
REG &LT03sp04 = &USER_MEMORY_115
MEM &LT03sp04 = 3000 //30.00%

REG &PP03sp01 = &USER_MEMORY_116
MEM &PP03sp01 = 10000 //100.00%
REG &PP03sp02 = &USER_MEMORY_117
MEM &PP03sp02 = 10000 //100.00%
REG &PP03sp03 = &USER_MEMORY_118
MEM &PP03sp03 = 8000 //80.00%

//User_Memory_200 to 299 Display Format x.xxx
MEM &USER_MEMORY16_BAND3 = 5419
MEM &DISPLAY_FORMAT_USER16_BAND3 = 4

//User_Memory_300 and above Display Format x


REG &XXstatus = &USER_MEMORY_400
BITREG &XXstatus = [|XXout, |XXeng, |XXdeeng, |XXfault, |XXmanualOn, |XXmanualOff, |XXautoOut, |XXengEnable, |XXdeengEnable, |XXfaultEnable]
REG &XXcmd = &USER_MEMORY_401
REG &XXtimerState = &USER_MEMORY_402
REG &XXtimerAcc = &USER_MEMORY_403
REG &XXtimerPre1 = &USER_MEMORY_404
REG &XXtimerPre2 = &USER_MEMORY_405
REG &XXtimerPre4 = &USER_MEMORY_406
REG &XXtimerPre5 = &USER_MEMORY_407

//PP02 Data
REG &PP02status = &USER_MEMORY_408
BITREG &PP02status = [|PP02out, |PP02eng, |PP02deeng, |PP02fault, |PP02manualOn, |PP02manualOff, |PP02autoOut, |PP02engEnable, |PP02deengEnable, |PP02faultEnable] 
MEM &PP02status = 0
REG &PP02cmd = &USER_MEMORY_409
REG &PP02timerState = &USER_MEMORY_410
REG &PP02timerAcc = &USER_MEMORY_411
MEM &PP02timerAcc = 0
REG &PP02timerPre1 = &USER_MEMORY_412
MEM &PP02timerPre1 = 100
REG &PP02timerPre2 = &USER_MEMORY_413
MEM &PP02timerPre2 = 1000
REG &PP02timerPre4 = &USER_MEMORY_414
MEM &PP02timerPre4 = 0
REG &PP02timerPre5 = &USER_MEMORY_415
MEM &PP02timerPre5 = 1000

//PP03 Data
REG &PP03status = &USER_MEMORY_416
BITREG &PP03status = [|PP03out, |PP03eng, |PP03deeng, |PP03fault, |PP03manualOn, |PP03manualOff, |PP03autoOut, |PP03engEnable, |PP03deengEnable, |PP03faultEnable] 
MEM &PP03status = 896
REG &PP03cmd = &USER_MEMORY_417
REG &PP03timerState = &USER_MEMORY_418
REG &PP03timerAcc = &USER_MEMORY_419
MEM &PP03timerAcc = 0
REG &PP03timerPre1 = &USER_MEMORY_420
MEM &PP03timerPre1 = 500
REG &PP03timerPre2 = &USER_MEMORY_421
MEM &PP03timerPre2 = 1000
REG &PP03timerPre4 = &USER_MEMORY_422
MEM &PP03timerPre4 = 0
REG &PP03timerPre5 = &USER_MEMORY_423
MEM &PP03timerPre5 = 1000

//SV02 Data
REG &SV02status = &USER_MEMORY_424
BITREG &SV02status = [|SV02out, |SV02eng, |SV02deeng, |SV02fault, |SV02manualOn, |SV02manualOff, |SV02autoOut, |SV02engEnable, |SV02deengEnable, |SV02faultEnable] 
MEM &SV02status = 896
REG &SV02cmd = &USER_MEMORY_425
REG &SV02timerState = &USER_MEMORY_426
REG &SV02timerAcc = &USER_MEMORY_427
MEM &SV02timerAcc = 0
REG &SV02timerPre1 = &USER_MEMORY_428
MEM &SV02timerPre1 = 0
REG &SV02timerPre2 = &USER_MEMORY_429
MEM &SV02timerPre2 = 1000
REG &SV02timerPre4 = &USER_MEMORY_430
MEM &SV02timerPre4 = 500
REG &SV02timerPre5 = &USER_MEMORY_431
MEM &SV02timerPre5 = 1000

//SV03 Data
REG &SV03status = &USER_MEMORY_432
BITREG &SV03status = [|SV03out, |SV03eng, |SV03deeng, |SV03fault, |SV03manualOn, |SV03manualOff, |SV03autoOut, |SV03engEnable, |SV03deengEnable, |SV03faultEnable] 
MEM &SV03status = 896
REG &SV03cmd = &USER_MEMORY_433
REG &SV03timerState = &USER_MEMORY_434
REG &SV03timerAcc = &USER_MEMORY_435
MEM &SV03timerAcc = 0
REG &SV03timerPre1 = &USER_MEMORY_436
MEM &SV03timerPre1 = 0
REG &SV03timerPre2 = &USER_MEMORY_437
MEM &SV03timerPre2 = 1000
REG &SV03timerPre4 = &USER_MEMORY_438
MEM &SV03timerPre4 = 500
REG &SV03timerPre5 = &USER_MEMORY_439
MEM &SV03timerPre5 = 1000

//SV04 Data
REG &SV04status = &USER_MEMORY_440
BITREG &SV04status = [|SV04out, |SV04eng, |SV04deeng, |SV04fault, |SV04manualOn, |SV04manualOff, |SV04autoOut, |SV04engEnable, |SV04deengEnable, |SV04faultEnable] 
MEM &SV04status = 896
REG &SV04cmd = &USER_MEMORY_441
REG &SV04timerState = &USER_MEMORY_442
REG &SV04timerAcc = &USER_MEMORY_443
MEM &SV04timerAcc = 0
REG &SV04timerPre1 = &USER_MEMORY_444
MEM &SV04timerPre1 = 0
REG &SV04timerPre2 = &USER_MEMORY_445
MEM &SV04timerPre2 = 1000
REG &SV04timerPre4 = &USER_MEMORY_446
MEM &SV04timerPre4 = 500
REG &SV04timerPre5 = &USER_MEMORY_447
MEM &SV04timerPre5 = 1000

//SV05 Data
REG &SV05status = &USER_MEMORY_448
BITREG &SV05status = [|SV05out, |SV05eng, |SV05deeng, |SV05fault, |SV05manualOn, |SV05manualOff, |SV05autoOut, |SV05engEnable, |SV05deengEnable, |SV05faultEnable] 
MEM &SV05status = 896
REG &SV05cmd = &USER_MEMORY_449
REG &SV05timerState = &USER_MEMORY_450
REG &SV05timerAcc = &USER_MEMORY_451
MEM &SV05timerAcc = 0
REG &SV05timerPre1 = &USER_MEMORY_452
MEM &SV05timerPre1 = 0
REG &SV05timerPre2 = &USER_MEMORY_453
MEM &SV05timerPre2 = 1000
REG &SV05timerPre4 = &USER_MEMORY_454
MEM &SV05timerPre4 = 500
REG &SV05timerPre5 = &USER_MEMORY_455
MEM &SV05timerPre5 = 1000

//SV06 Data
REG &SV06status = &USER_MEMORY_456
BITREG &SV06status = [|SV06out, |SV06eng, |SV06deeng, |SV06fault, |SV06manualOn, |SV06manualOff, |SV06autoOut, |SV06engEnable, |SV06deengEnable, |SV06faultEnable] 
MEM &SV06status = 896
REG &SV06cmd = &USER_MEMORY_457
REG &SV06timerState = &USER_MEMORY_458
REG &SV06timerAcc = &USER_MEMORY_459
MEM &SV06timerAcc = 0
REG &SV06timerPre1 = &USER_MEMORY_460
MEM &SV06timerPre1 = 0
REG &SV06timerPre2 = &USER_MEMORY_461
MEM &SV06timerPre2 = 1000
REG &SV06timerPre4 = &USER_MEMORY_462
MEM &SV06timerPre4 = 500
REG &SV06timerPre5 = &USER_MEMORY_463
MEM &SV06timerPre5 = 1000

//SV08 Data
REG &SV08status = &USER_MEMORY_464
BITREG &SV08status = [|SV08out, |SV08eng, |SV08deeng, |SV08fault, |SV08manualOn, |SV08manualOff, |SV08autoOut, |SV08engEnable, |SV08deengEnable, |SV08faultEnable] 
MEM &SV08status = 896
REG &SV08cmd = &USER_MEMORY_465
REG &SV08timerState = &USER_MEMORY_466
REG &SV08timerAcc = &USER_MEMORY_467
MEM &SV08timerAcc = 0
REG &SV08timerPre1 = &USER_MEMORY_468
MEM &SV08timerPre1 = 0
REG &SV08timerPre2 = &USER_MEMORY_469
MEM &SV08timerPre2 = 1000
REG &SV08timerPre4 = &USER_MEMORY_470
MEM &SV08timerPre4 = 500
REG &SV08timerPre5 = &USER_MEMORY_471
MEM &SV08timerPre5 = 1000

//AC01 Data
REG &AC01status = &USER_MEMORY_472
BITREG &AC01status = [|AC01out, |AC01eng, |AC01deeng, |AC01fault, |AC01manualOn, |AC01manualOff, |AC01autoOut, |AC01engEnable, |AC01deengEnable, |AC01faultEnable] 
MEM &AC01status = 896
REG &AC01cmd = &USER_MEMORY_473
REG &AC01timerState = &USER_MEMORY_474
REG &AC01timerAcc = &USER_MEMORY_475
MEM &AC01timerAcc = 0
REG &AC01timerPre1 = &USER_MEMORY_476
MEM &AC01timerPre1 = 0
REG &AC01timerPre2 = &USER_MEMORY_477
MEM &AC01timerPre2 = 1000
REG &AC01timerPre4 = &USER_MEMORY_478
MEM &AC01timerPre4 = 0
REG &AC01timerPre5 = &USER_MEMORY_479
MEM &AC01timerPre5 = 1000

REG &fd100StepMsgTacc = &USER_MEMORY_549

MEM &CODE_BLANKING=0
MEM &VIEW_MODE_BLANKING=0
MEM &SETPOINT_BLANKING=0
  

RESET_MACRO:
 &fd100StepNumber = 0
 |AFI = OFF
 &T0acc = 0
END

MAIN_MACRO:

 //Get the time since the start of the last main macro scan
 &lastScanTimeFast = &FAST_TIMER1 
 &FAST_TIMER1 = &FAST_TIMER1 - &lastScanTimeFast
 
 &lastScanTimeShort = &SHORT_TIMER1
 &SHORT_TIMER1 = &SHORT_TIMER1 - &lastScanTimeShort 
  
 &LT02_percent = (&CH3 * 1.5)
 &LT07_percent = (&CH1 * 1.472)
 &LT03_percent = (&CH2 * 1)
 
 //OP_MODE - Mode Of Operation
 IF (|SW02_SELECTED = ON) THEN 
  IF (|SW05_SELECTED = ON) THEN 
   &OP_MODE = 1 //Product Ignore Level
  ELSIF (|SW06_SELECTED = ON) THEN 
   &OP_MODE = 2 //Product High Fill Level
  ELSE
   &OP_MODE = 3 //Product Low Fill Level
  ENDIF
 ELSIF (|SW01_SELECTED = ON) THEN 
  IF (|SW03_SELECTED = ON) THEN 
   &OP_MODE = 15 //CIP No Fill
  ELSE
   &OP_MODE = 14 //CIP Fill
  ENDIF
 ELSE
  &OP_MODE = 0 //OFF
 ENDIF     
  
 //FD100 Production
  
 &Temp1 = &fd100StepNumber
 SELECT &fd100StepNumber
  CASE 0: //Reset
   |AC01autoOut = OFF
   |FD100_Fill = OFF
   |PP03_run1 = OFF
   |PP03_run2 = OFF
   |PP03_run3 = OFF
   |PP03_run4 = OFF
   |SV03autoOut = OFF
   |SV04autoOut = OFF
   |SV05autoOut = OFF
   |SV06autoOut = OFF
   |SV08autoOut = OFF
   |IL01_ON = OFF
      
   //Transistion Conditions
   IF (&OP_MODE > 0) THEN  //CIP or Product
    &Temp1 = 1
   ENDIF
   
  CASE 1: //Site Level OK
   |AC01autoOut = OFF
   |FD100_Fill = OFF
   |PP03_run1 = OFF
   |PP03_run2 = OFF
   |PP03_run3 = OFF
   |PP03_run4 = OFF
   |SV03autoOut = OFF
   |SV04autoOut = OFF
   |SV05autoOut = OFF
   |SV06autoOut = OFF
   |SV08autoOut = OFF
   |IL01_ON = OFF
      
   //Transistion Conditions
   SELECT &OP_MODE
    CASE 0: //Off
     &Temp1 = 0
    CASE 1: //Product Ignore Level
     &Temp1 = 2
    CASE 2: //Product High Level
     IF (&LT03_percent < &LT03sp01) THEN
      &Temp1 = 2
     ENDIF
    CASE 3: //Product Low Level
     IF (&LT03_percent < &LT03sp03) THEN
      &Temp1 = 2
     ENDIF
    CASE 14: //CIP Fill
     &Temp1 = 2
    CASE 15: //CIP No Fill
     &Temp1 = 2
    DEFAULT:
     &Temp1 = 0
   ENDSEL
   
  CASE 2: //Check Chemicals
   |AC01autoOut = OFF
   |FD100_Fill = OFF
   |PP03_run1 = OFF
   |PP03_run2 = OFF
   |PP03_run3 = OFF
   |PP03_run4 = OFF
   |SV03autoOut = OFF
   |SV04autoOut = OFF
   |SV05autoOut = OFF
   |SV06autoOut = OFF
   |SV08autoOut = OFF
   |IL01_ON = OFF
      
   //Transistion Conditions
   IF (&OP_MODE = 0) THEN
    &Temp1 = 0
   ENDIF
   IF (|LS01_UNCOVERED = OFF) THEN
    &Temp1 = 3
   ENDIF
   
  CASE 3: //Check Air Compressor
   |AC01autoOut = ON
   |FD100_Fill = OFF
   |PP03_run1 = OFF
   |PP03_run2 = OFF
   |PP03_run3 = OFF
   |PP03_run4 = OFF
   |SV03autoOut = OFF
   |SV04autoOut = OFF
   |SV05autoOut = OFF
   |SV06autoOut = OFF
   |SV08autoOut = OFF
   |IL01_ON = OFF
      
   //Transistion Conditions
   IF (&OP_MODE = 0) THEN
    &Temp1 = 0
   ENDIF
   IF (|LS01_UNCOVERED = ON) THEN
    &Temp1 = 2
   ENDIF
   IF (|PS01_MADE = OFF) THEN
    &Temp1 = 4
   ENDIF

  CASE 4: //Fill Feed Tank
   |AC01autoOut = ON
   |PP03_run1 = OFF
   |PP03_run2 = OFF
   |PP03_run3 = OFF
   |PP03_run4 = OFF
   |SV03autoOut = OFF
   |SV04autoOut = OFF
   |SV05autoOut = OFF
   |SV06autoOut = OFF
   |SV08autoOut = OFF
   |IL01_ON = OFF
   
   SELECT &OP_MODE
    CASE 15: //CIP No Fill
     |FD100_Fill = OFF
    DEFAULT:
     |FD100_Fill = ON
   ENDSEL
      
   //Transistion Conditions
   IF (|LS01_UNCOVERED = ON) THEN
    &Temp1 = 2
   ENDIF
   IF (|PS01_MADE = ON) THEN
    &Temp1 = 3
   ENDIF
   IF (|FD101_FillOk = ON) THEN
    &Temp1 = 5
   ENDIF
   SELECT &OP_MODE
    CASE 0: //Off
     &Temp1 = 0
    CASE 1: //Product Ignore Level
     IF (|FD101_FillOk = ON) THEN
      &Temp1 = 5
     ENDIF
    CASE 2: //Product High Level
     IF (|FD101_FillOk = ON) THEN
      &Temp1 = 5
     ENDIF
    CASE 3: //Product Low Level
     IF (|FD101_FillOk = ON) THEN
      &Temp1 = 5
     ENDIF
    CASE 14: //CIP Fill
     IF (|FD101_FillOk = ON) THEN
      &Temp1 = 5
     ENDIF
    CASE 15: //CIP No Fill
     &Temp1 = 5
    DEFAULT:
     &Temp1 = 0
   ENDSEL

  CASE 5: //Recirc And Check Conductivity
   |AC01autoOut = ON
   |PP03_run1 = ON
   |PP03_run2 = OFF
   |PP03_run3 = OFF
   |PP03_run4 = OFF
   |SV03autoOut = OFF
   |SV04autoOut = OFF
   |SV05autoOut = ON
   |SV06autoOut = OFF
   |SV08autoOut = OFF
   |IL01_ON = OFF
   
   SELECT &OP_MODE
    CASE 15: //CIP No Fill
     |FD100_Fill = OFF
    DEFAULT:
     |FD100_Fill = ON
   ENDSEL
      
   //Transistion Conditions
   IF (|LS01_UNCOVERED = ON) THEN
    &Temp1 = 2
   ENDIF
   IF (|PS01_MADE = ON) THEN
    &Temp1 = 3
   ENDIF   
   SELECT &OP_MODE
    CASE 0: //Off
     &Temp1 = 8
    CASE 1: //Product Ignore Level
     IF (|FD101_FillOk = OFF) THEN
      &Temp1 = 4
     ENDIF
     IF (|CS04_LOW = ON) THEN
      &T0acc = &T0acc + &lastScanTimeFast
      IF (&T0acc > &CS04sp02) THEN
       &Temp1 = 6
      ENDIF
     ELSE
      &T0acc = 0
     ENDIF     
    CASE 2: //Product High Level
     IF (|FD101_FillOk = OFF) THEN
      &Temp1 = 4
     ENDIF
     IF (|CS04_LOW = ON) THEN
      &T0acc = &T0acc + &lastScanTimeFast
      IF (&T0acc > &CS04sp02) THEN
       &Temp1 = 6
      ENDIF
     ELSE
      &T0acc = 0
     ENDIF          
    CASE 3: //Product Low Level
     IF (|FD101_FillOk = OFF) THEN
      &Temp1 = 4
     ENDIF
     IF (|CS04_LOW = ON) THEN
      &T0acc = &T0acc + &lastScanTimeFast
      IF (&T0acc > &CS04sp02) THEN
       &Temp1 = 6
      ENDIF
     ELSE
      &T0acc = 0
     ENDIF
    CASE 14: //CIP Fill
     IF (|FD101_FillOk = OFF) THEN
      &Temp1 = 4
     ENDIF
    CASE 15: //CIP No Fill          
    DEFAULT: 
   ENDSEL      

  CASE 6: //Fill RO Tank
   |AC01autoOut = ON
   |FD100_Fill = ON
   |PP03_run1 = OFF
   |PP03_run2 = ON
   |PP03_run3 = OFF
   |PP03_run4 = OFF
   |SV03autoOut = ON
   |SV04autoOut = OFF
   |SV05autoOut = OFF
   |SV06autoOut = ON
   |SV08autoOut = OFF
   |IL01_ON = OFF
   
   //Transistion Conditions
   IF (|LS01_UNCOVERED = ON) THEN
    &Temp1 = 2
   ENDIF
   IF (|PS01_MADE = ON) THEN
    &Temp1 = 3
   ENDIF      
   SELECT &OP_MODE
    CASE 0: //Off
     &Temp1 = 8
    CASE 1: //Product Ignore Level
     IF (|FD101_FillOk = OFF) THEN
      &Temp1 = 4
     ENDIF
     IF (|CS04_LOW = OFF) THEN
      &Temp1 = 5
     ENDIF
     IF (&LT02_percent > &LT02sp01) THEN
      &Temp1 = 7
     ENDIF     
    CASE 2: //Product High Level
     IF (|FD101_FillOk = OFF) THEN
      &Temp1 = 4
     ENDIF
     IF (|CS04_LOW = OFF) THEN
      &Temp1 = 5
     ENDIF
     IF (&LT02_percent > &LT02sp01) THEN
      &Temp1 = 7
     ENDIF          
    CASE 3: //Product Low Level
     IF (|FD101_FillOk = OFF) THEN
      &Temp1 = 4
     ENDIF
     IF (|CS04_LOW = OFF) THEN
      &Temp1 = 5
     ENDIF
     IF (&LT02_percent > &LT02sp01) THEN
      &Temp1 = 7
     ENDIF
    CASE 14: //CIP Fill
     &Temp1 = 5
    CASE 15: //CIP No Fill
     &Temp1 = 5          
    DEFAULT: 
   ENDSEL   
   

  CASE 7: //Fill Site RO Tank
   |AC01autoOut = ON
   |FD100_Fill = ON
   |PP03_run1 = OFF
   |PP03_run2 = OFF
   |PP03_run3 = OFF
   |PP03_run4 = ON
   |SV03autoOut = OFF
   |SV04autoOut = ON
   |SV05autoOut = OFF
   |SV06autoOut = ON
   |SV08autoOut = OFF
   |IL01_ON = OFF
      
   //Transistion Conditions
   IF (|LS01_UNCOVERED = ON) THEN
    &Temp1 = 2
   ENDIF
   IF (|PS01_MADE = ON) THEN
    &Temp1 = 3
   ENDIF
   SELECT &OP_MODE
    CASE 0: //Off
     &Temp1 = 8
    CASE 1: //Product Ignore Level
     IF (|FD101_FillOk = OFF) THEN
      &Temp1 = 4
     ENDIF
     IF (|CS04_LOW = OFF) THEN
      &Temp1 = 5
     ENDIF
     IF (&LT02_percent < &LT02sp02) THEN
      &Temp1 = 6
     ENDIF     
    CASE 2: //Product High Level
     IF (|FD101_FillOk = OFF) THEN
      &Temp1 = 4
     ENDIF
     IF (|CS04_LOW = OFF) THEN
      &Temp1 = 5
     ENDIF
     IF (&LT02_percent < &LT02sp02) THEN
      &Temp1 = 6
     ENDIF
     IF (&LT03_percent > &LT03sp02) THEN
      &Temp1 = 8
     ENDIF               
    CASE 3: //Product Low Level
     IF (|FD101_FillOk = OFF) THEN
      &Temp1 = 4
     ENDIF
     IF (|CS04_LOW = OFF) THEN
      &Temp1 = 5
     ENDIF
     IF (&LT02_percent < &LT02sp02) THEN
      &Temp1 = 6
     ENDIF
     IF (&LT03_percent > &LT03sp04) THEN
      &Temp1 = 8
     ENDIF
    CASE 14: //CIP Fill
     &Temp1 = 5
    CASE 15: //CIP No Fill
     &Temp1 = 5          
    DEFAULT: 
   ENDSEL   

  CASE 8: //Shutdown
   |AC01autoOut = ON
   |FD100_Fill = OFF
   |PP03_run1 = OFF
   |PP03_run2 = OFF
   |PP03_run3 = ON
   |PP03_run4 = OFF
   |SV03autoOut = OFF
   |SV04autoOut = OFF
   |SV05autoOut = ON
   |SV06autoOut = OFF
   |SV08autoOut = ON
   |IL01_ON = OFF
   &T0acc = &T0acc + &lastScanTimeFast
      
   //Transistion Conditions
   IF (&T0acc > &FD100sp08) OR (&LT02_percent < &LT02sp03) THEN
    &Temp1 = 1
   ENDIF     
  
  DEFAULT:
   &Temp1 = 0
   
 ENDSEL
 
 IF &Temp1 <> &fd100StepNumber THEN
  &fd100StepNumber = &Temp1
  &T0acc = 0
 ENDIF
 
 //Outputs
 IF (|PP03_run1 = ON) THEN
    |PP03autoOut = ON
    &PP03_SPD = &PP03sp01 
 ELSIF (|PP03_run2 = ON) THEN
    |PP03autoOut = ON
    &PP03_SPD = &PP03sp02
 ELSIF (|PP03_run3 = ON) THEN
    |PP03autoOut = ON
    &PP03_SPD = &PP03sp03
 ELSIF (|PP03_run4 = ON) THEN
    |PP03autoOut = ON
    &PP03_SPD = &PP03sp02
 ELSE
    |PP03autoOut = OFF
 ENDIF 
 
 
 //FD101 Feed Tank Level
  
 &Temp1 = &fd101StepNumber
 SELECT &fd101StepNumber
  CASE 0: //Reset
   |FD101_Fill = OFF
   |FD101_FillOk = OFF
      
   //Transistion Conditions
   IF (|FD100_Fill = ON) THEN
    &Temp1 = 1
   ENDIF
   
  CASE 1: //Tank Low Level
   |FD101_Fill = ON
   |FD101_FillOk = OFF
      
   //Transistion Conditions
   IF (|FD100_Fill = OFF) THEN
    &Temp1 = 0
   ENDIF        
   IF (&LT07_percent > &LT07sp02) THEN
    &Temp1 = 2
   ENDIF 

  CASE 2: //Tank Level Ok - No Fill
   |FD101_Fill = OFF
   |FD101_FillOk = ON
      
   //Transistion Conditions
   IF (|FD100_Fill = OFF) THEN
    &Temp1 = 0
   ENDIF        
   IF (&LT07_percent < &LT07sp01) THEN
    &Temp1 = 3
   ENDIF

  CASE 3: //Tank Level Ok - Fill
   |FD101_Fill = ON
   |FD101_FillOk = ON
      
   //Transistion Conditions
   IF (|FD100_Fill = OFF) THEN
    &Temp1 = 0
   ENDIF        
   IF (&LT07_percent > &LT07sp02) THEN
    &Temp1 = 2
   ENDIF
   IF (&LT07_percent < &LT07sp03) THEN
    &Temp1 = 1
   ENDIF
  
  DEFAULT:
   &Temp1 = 0
   
 ENDSEL 
 
 IF &Temp1 <> &fd101StepNumber THEN
  &fd101StepNumber = &Temp1
 ENDIF
 
  //FD102 Feed Tank Fill
  
 &Temp1 = &fd102StepNumber
 SELECT &fd102StepNumber
  CASE 0: //Reset
   |SV02autoOut = OFF
   |PP02autoOut = OFF
      
   //Transistion Conditions
   IF (|FD101_Fill = ON) THEN
    &Temp1 = 1
   ENDIF
   
  CASE 1: //Fill Min Level
   |SV02autoOut = ON
   |PP02autoOut = OFF
      
   //Transistion Conditions
   IF (|FD101_Fill = OFF) THEN
    &Temp1 = 0
   ENDIF
   IF (&LT07_percent > 500) THEN
    &Temp1 = 2
   ENDIF
   
  CASE 2: //Record Level
   |SV02autoOut = ON
   |PP02autoOut = OFF
   &LT07v1 = &LT07_percent 
   
   //Transistion Conditions
   &Temp1 = 3
   
  CASE 3: //Fill Feed Tank - No Chemical
   |SV02autoOut = ON
   |PP02autoOut = OFF
      
   //Transistion Conditions
   IF (|FD101_Fill = OFF) THEN
    &Temp1 = 0
   ENDIF
   IF (&LT07_percent > (&LT07v1 + 200)) THEN
    &Temp1 = 4
   ENDIF
   
  CASE 4: //Fill Feed Tank - Chemical
   |SV02autoOut = ON
   |PP02autoOut = ON
      
   //Transistion Conditions
   IF (|FD101_Fill = OFF) THEN
    &Temp1 = 0
   ENDIF         
  
  DEFAULT:
   &Temp1 = 0
   
 ENDSEL 
 
 IF &Temp1 <> &fd102StepNumber THEN
  &fd102StepNumber = &Temp1
 ENDIF 
 
 //Valve and Motor Logic
 FOR &Temp1 = 1 TO 9 STEP 1
  //Get Values  
  &XXstatus = &XXstatus[&Temp1*8]
  &XXcmd = &XXcmd[&Temp1*8]
  &XXcmd[&Temp1*8] = 0
  &XXtimerState = &XXtimerState[&Temp1*8]
  &XXtimerAcc = &XXtimerAcc[&Temp1*8]
  &XXtimerPre1 = &XXtimerPre1[&Temp1*8]
  &XXtimerPre2 = &XXtimerPre2[&Temp1*8]
  &XXtimerPre4 = &XXtimerPre4[&Temp1*8]
  &XXtimerPre5 = &XXtimerPre5[&Temp1*8]
  
  //cmd 0=none 1=auto 2=manualOff 3=manualOn
  SELECT &XXcmd
   CASE 0:
    //No action
   CASE 1:
    |XXmanualOn = OFF
    |XXmanualOff = OFF

   CASE 2:
    |XXmanualOn = OFF
    |XXmanualOff = ON

   CASE 3:
    |XXmanualOn = ON
    |XXmanualOff = OFF
        
   DEFAULT:

   ENDSEL
  
  //timerState
  SELECT &XXtimerState
   CASE 0: //Deenergised or Stopped
    |XXout = OFF
    IF (|XXfaultEnable = ON AND ((|XXeng = ON AND |XXengEnable = ON) OR (|XXdeeng = OFF AND |XXdeengEnable = ON))) THEN
     |XXfault = ON
    ELSIF |XXfaultEnable = ON THEN
     |XXfault = OFF
    ENDIF    
    IF (|XXmanualOff = ON) THEN
     &XXtimerState = 0
    ELSIF (|XXmanualOn = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 2
    ELSIF (|XXautoOut = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 1
    ENDIF

   CASE 1: //Delay before Energising or Starting
    |XXout = OFF
    IF (|XXfaultEnable = ON AND ((|XXeng = ON AND |XXengEnable = ON) OR (|XXdeeng = OFF AND |XXdeengEnable = ON))) THEN
     |XXfault = ON
    ELSIF |XXfaultEnable = ON THEN
     |XXfault = OFF
    ENDIF 
    &XXtimerAcc = &XXtimerAcc + &lastScanTimeFast
    IF (|XXmanualOff = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 0
    ELSIF ((|XXmanualOn = ON) OR (&XXtimerAcc >= &XXtimerPre1)) THEN
     &XXtimerAcc = 0
     &XXtimerState = 2
    ELSIF (|XXautoOut = OFF) THEN
     &XXtimerAcc = 0
     &XXtimerState = 0  
    ENDIF
    
   CASE 2: //Energising or Starting Time
    |XXout = ON
    IF |XXfaultEnable = ON THEN
     |XXfault = OFF
    ENDIF
    &XXtimerAcc = &XXtimerAcc + &lastScanTimeFast
    IF (|XXmanualOff = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 5
    ELSIF ((|XXmanualOn = OFF) AND (|XXautoOut = OFF)) THEN 
     &XXtimerAcc = 0 
     &XXtimerState = 4 
    ELSIF (&XXtimerAcc >= &XXtimerPre2) THEN 
     &XXtimerAcc = 0 
     &XXtimerState = 3
    ENDIF

   CASE 3: //Energised or Started
    |XXout = ON
    IF (|XXfaultEnable = ON AND ((|XXeng = OFF AND |XXengEnable = ON) OR (|XXdeeng = ON AND |XXdeengEnable = ON))) THEN
     |XXfault = ON
    ELSIF |XXfaultEnable = ON THEN
     |XXfault = OFF
    ENDIF
    IF (|XXmanualOn = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 3
    ELSIF (|XXmanualOff = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 5
    ELSIF (|XXautoOut = OFF) THEN
     &XXtimerAcc = 0
     &XXtimerState = 4
    ENDIF 
   
   CASE 4: //Delay before Deenergising or Stopping
    |XXout = ON
    IF (|XXfaultEnable = ON AND ((|XXeng = OFF AND |XXengEnable = ON) OR (|XXdeeng = ON AND |XXdeengEnable = ON))) THEN
     |XXfault = ON
    ELSIF |XXfaultEnable = ON THEN
     |XXfault = OFF
    ENDIF
    &XXtimerAcc = &XXtimerAcc + &lastScanTimeFast
    IF (|XXmanualOn = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 3
    ELSIF ((|XXmanualOff = ON) OR (&XXtimerAcc >= &XXtimerPre4)) THEN
     &XXtimerAcc = 0
     &XXtimerState = 5
    ELSIF (|XXautoOut = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 3  
    ENDIF 
   
   CASE 5: //Deenergising or Stopping Time
    |XXout = OFF
    IF |XXfaultEnable = ON THEN
     |XXfault = OFF
    ENDIF
    &XXtimerAcc = &XXtimerAcc + &lastScanTimeFast
    IF (|XXmanualOn = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 2
    ELSIF ((|XXmanualOff = OFF) AND (|XXautoOut = ON)) THEN 
     &XXtimerAcc = 0 
     &XXtimerState = 1 
    ELSIF (&XXtimerAcc >= &XXtimerPre5) THEN 
     &XXtimerAcc = 0 
     &XXtimerState = 0
    ENDIF
           
   DEFAULT:
    &XXtimerAcc = 0
    &XXtimerState = 0
   ENDSEL
   
  //Update Values
  &XXstatus[&Temp1*8] = &XXstatus
  &XXtimerState[&Temp1*8] = &XXtimerState
  &XXtimerAcc[&Temp1*8] = &XXtimerAcc  
 NEXT &Temp1

 |SP1 = OFF
 |SP2 = OFF
 |SP3 = OFF
 |SP4 = OFF
 
 |SV02_OPEN = |SV02out
 |SV03_OPEN = |SV03out
 |SV04_OPEN = |SV04out
 |SV05_OPEN = |SV05out
 |SV06_OPEN = |SV06out
 |SV08_OPEN = |SV08out
 |PP02_RUN = |PP02out
 |PP03_RUN = |PP03out
 |AC01_RUN = |AC01out 
 
END



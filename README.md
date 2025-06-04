# LCD

디지털 설계 프로젝트를 위한 FPGA LCD실습

## FPGA
-Libertron사의 EMA-MOD-7V2000T-2-2 모듈 (Xilinx Virtex-7 시리즈 FPGA (XC7V2000T-2FLG1925C)탑재)
-FSM LCD

## -내장 clock 사용 

(IP catalog - clock-clock wizard - Clocking option/Primitive/PLL - OUTPUT clock/33.000)

## -ROM IP Core 사용
(IP catalog - block memory Generator -Basic/Memory Typle/Single Port ROM -PORT A Options/Memory size/24,160000/Always enable/ Primitives Output reg (선택취소) - Other Options/coe파일 추가)

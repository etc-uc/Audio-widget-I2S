EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Regulator_Linear:L7812 U1
U 1 1 5DE0F3BB
P 3900 2350
F 0 "U1" H 3900 2592 50  0000 C CNN
F 1 "L7812" H 3900 2501 50  0000 C CNN
F 2 "" H 3925 2200 50  0001 L CIN
F 3 "http://www.st.com/content/ccc/resource/technical/document/datasheet/41/4f/b3/b0/12/d4/47/88/CD00000444.pdf/files/CD00000444.pdf/jcr:content/translations/en.CD00000444.pdf" H 3900 2300 50  0001 C CNN
	1    3900 2350
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:L7912 U2
U 1 1 5DE0FD7E
P 3900 3500
F 0 "U2" H 3900 3351 50  0000 C CNN
F 1 "L7912" H 3900 3260 50  0000 C CNN
F 2 "" H 3900 3300 50  0001 C CIN
F 3 "http://www.st.com/content/ccc/resource/technical/document/datasheet/c9/16/86/41/c7/2b/45/f2/CD00000450.pdf/files/CD00000450.pdf/jcr:content/translations/en.CD00000450.pdf" H 3900 3500 50  0001 C CNN
	1    3900 3500
	1    0    0    -1  
$EndComp
$Comp
L Diode_Bridge:B40C5000-3x00A D1
U 1 1 5DE11C1D
P 2750 2850
F 0 "D1" H 3094 2896 50  0000 L CNN
F 1 "B40C5000-3x00A" H 3094 2805 50  0000 L CNN
F 2 "Diode_THT:Diode_Bridge_32.0x5.6x17.0mm_P10.0mm_P7.5mm" H 2900 2975 50  0001 L CNN
F 3 "https://diotec.com/tl_files/diotec/files/pdf/datasheets/b40c500033" H 2750 2850 50  0001 C CNN
	1    2750 2850
	1    0    0    -1  
$EndComp
$Comp
L Transformer:TEZ16.0-D-2 TR1
U 1 1 5DE14EA1
P 1850 2800
F 0 "TR1" H 1850 3325 50  0000 C CNN
F 1 "TEZ16.0-D-2" H 1850 3234 50  0000 C CNN
F 2 "Transformer_THT:Transformer_Breve_TEZ-47x57" H 1850 2250 50  0001 C CIN
F 3 "http://www.breve.pl/pdf/ANG/TEZ_ang.pdf" H 1850 2800 50  0001 C CNN
	1    1850 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 2800 2100 2800
Wire Wire Line
	2100 2900 2050 2900
Wire Wire Line
	2050 2500 2350 2500
Wire Wire Line
	2750 2500 2750 2550
Wire Wire Line
	2750 3200 2750 3150
Wire Wire Line
	2100 2800 2100 2900
$Comp
L power:Earth #PWR?
U 1 1 5DE1B452
P 2100 3000
F 0 "#PWR?" H 2100 2750 50  0001 C CNN
F 1 "Earth" H 2100 2850 50  0001 C CNN
F 2 "" H 2100 3000 50  0001 C CNN
F 3 "~" H 2100 3000 50  0001 C CNN
	1    2100 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 3000 2100 2900
Connection ~ 2100 2900
Wire Wire Line
	2450 2850 2450 3500
Wire Wire Line
	2450 3500 3350 3500
Wire Wire Line
	3050 2850 3050 2550
Wire Wire Line
	3050 2350 3350 2350
$Comp
L Device:CP C6
U 1 1 5DE1C6EF
P 3350 2700
F 0 "C6" H 3468 2746 50  0000 L CNN
F 1 "4700uF" H 3468 2655 50  0000 L CNN
F 2 "" H 3388 2550 50  0001 C CNN
F 3 "~" H 3350 2700 50  0001 C CNN
	1    3350 2700
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C5
U 1 1 5DE1D229
P 3350 3150
F 0 "C5" H 3468 3196 50  0000 L CNN
F 1 "4700uF" H 3468 3105 50  0000 L CNN
F 2 "" H 3388 3000 50  0001 C CNN
F 3 "~" H 3350 3150 50  0001 C CNN
	1    3350 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 2550 3350 2350
Connection ~ 3350 2350
Wire Wire Line
	3350 2350 3600 2350
Wire Wire Line
	3350 3300 3350 3500
Connection ~ 3350 3500
Wire Wire Line
	3350 3500 3600 3500
Wire Wire Line
	3350 3000 3350 2900
Wire Wire Line
	3900 2650 3900 2900
Wire Wire Line
	3900 2900 3350 2900
Connection ~ 3900 2900
Wire Wire Line
	3900 2900 3900 3200
Connection ~ 3350 2900
Wire Wire Line
	3350 2900 3350 2850
$Comp
L power:Earth #PWR?
U 1 1 5DE1E31D
P 3200 2950
F 0 "#PWR?" H 3200 2700 50  0001 C CNN
F 1 "Earth" H 3200 2800 50  0001 C CNN
F 2 "" H 3200 2950 50  0001 C CNN
F 3 "~" H 3200 2950 50  0001 C CNN
	1    3200 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 2950 3200 2900
Wire Wire Line
	3200 2900 3350 2900
$Comp
L Device:CP C7
U 1 1 5DE1EAD9
P 4500 2550
F 0 "C7" H 4618 2596 50  0000 L CNN
F 1 "100uF" H 4618 2505 50  0000 L CNN
F 2 "" H 4538 2400 50  0001 C CNN
F 3 "~" H 4500 2550 50  0001 C CNN
	1    4500 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C8
U 1 1 5DE1F15C
P 4500 3200
F 0 "C8" H 4618 3246 50  0000 L CNN
F 1 "100uF" H 4618 3155 50  0000 L CNN
F 2 "" H 4538 3050 50  0001 C CNN
F 3 "~" H 4500 3200 50  0001 C CNN
	1    4500 3200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C9
U 1 1 5DE1FBDE
P 4800 2550
F 0 "C9" H 4915 2596 50  0000 L CNN
F 1 "100nF" H 4915 2505 50  0000 L CNN
F 2 "" H 4838 2400 50  0001 C CNN
F 3 "~" H 4800 2550 50  0001 C CNN
	1    4800 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:C C10
U 1 1 5DE204AA
P 4800 3200
F 0 "C10" H 4915 3246 50  0000 L CNN
F 1 "100nF" H 4915 3155 50  0000 L CNN
F 2 "" H 4838 3050 50  0001 C CNN
F 3 "~" H 4800 3200 50  0001 C CNN
	1    4800 3200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5DE20B94
P 2350 2700
F 0 "C1" H 2465 2746 50  0000 L CNN
F 1 "100nF" H 2465 2655 50  0000 L CNN
F 2 "" H 2388 2550 50  0001 C CNN
F 3 "~" H 2350 2700 50  0001 C CNN
	1    2350 2700
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5DE21363
P 2350 3350
F 0 "C2" H 2465 3396 50  0000 L CNN
F 1 "100nF" H 2465 3305 50  0000 L CNN
F 2 "" H 2388 3200 50  0001 C CNN
F 3 "~" H 2350 3350 50  0001 C CNN
	1    2350 3350
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 5DE219AA
P 2900 2550
F 0 "C3" V 2648 2550 50  0000 C CNN
F 1 "100nF" V 2739 2550 50  0000 C CNN
F 2 "" H 2938 2400 50  0001 C CNN
F 3 "~" H 2900 2550 50  0001 C CNN
	1    2900 2550
	0    1    1    0   
$EndComp
Connection ~ 3050 2550
Wire Wire Line
	3050 2550 3050 2350
Connection ~ 2750 2550
$Comp
L Device:C C?
U 1 1 5DE2241E
P 3050 3000
F 0 "C?" H 3165 3046 50  0000 L CNN
F 1 "C" H 3165 2955 50  0000 L CNN
F 2 "" H 3088 2850 50  0001 C CNN
F 3 "~" H 3050 3000 50  0001 C CNN
	1    3050 3000
	1    0    0    -1  
$EndComp
Connection ~ 3050 2850
Wire Wire Line
	3050 3150 3050 3200
Wire Wire Line
	3050 3200 2750 3200
Connection ~ 2750 3200
Wire Wire Line
	2350 2550 2350 2500
Connection ~ 2350 2500
Wire Wire Line
	2350 2500 2750 2500
Wire Wire Line
	2350 2850 2450 2850
Connection ~ 2450 2850
Wire Wire Line
	2050 3200 2350 3200
Connection ~ 2350 3200
Wire Wire Line
	2350 3200 2750 3200
Wire Wire Line
	2350 3500 2450 3500
Connection ~ 2450 3500
Wire Wire Line
	4500 2400 4500 2350
Wire Wire Line
	4500 2350 4200 2350
Wire Wire Line
	4800 2400 4800 2350
Wire Wire Line
	4800 2350 4500 2350
Connection ~ 4500 2350
Wire Wire Line
	4500 3350 4500 3500
Wire Wire Line
	4500 3500 4200 3500
Wire Wire Line
	4800 3350 4800 3500
Wire Wire Line
	4800 3500 4500 3500
Connection ~ 4500 3500
Wire Wire Line
	4500 3050 4500 2900
Wire Wire Line
	4800 3050 4800 2900
Wire Wire Line
	3900 2900 4500 2900
Connection ~ 4500 2900
Wire Wire Line
	4500 2900 4500 2700
Wire Wire Line
	4500 2900 4800 2900
Connection ~ 4800 2900
Wire Wire Line
	4800 2900 4800 2700
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 5DE29C05
P 950 2850
F 0 "J1" H 868 2525 50  0000 C CNN
F 1 "230VAC" H 868 2616 50  0000 C CNN
F 2 "" H 950 2850 50  0001 C CNN
F 3 "~" H 950 2850 50  0001 C CNN
	1    950  2850
	-1   0    0    1   
$EndComp
$Comp
L Connector_Generic:Conn_01x03 J?
U 1 1 5DE2A954
P 5800 2900
F 0 "J?" H 5880 2942 50  0000 L CNN
F 1 "Conn_01x03" H 5880 2851 50  0000 L CNN
F 2 "" H 5800 2900 50  0001 C CNN
F 3 "~" H 5800 2900 50  0001 C CNN
	1    5800 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 2800 5600 2350
Wire Wire Line
	5600 2350 4800 2350
Connection ~ 4800 2350
Wire Wire Line
	5600 3000 5600 3500
Wire Wire Line
	5600 3500 4800 3500
Connection ~ 4800 3500
Wire Wire Line
	4800 2900 5600 2900
$Comp
L Device:Fuse F1
U 1 1 5DE2F108
P 1400 2600
F 0 "F1" V 1203 2600 50  0000 C CNN
F 1 "0.22A" V 1294 2600 50  0000 C CNN
F 2 "" V 1330 2600 50  0001 C CNN
F 3 "~" H 1400 2600 50  0001 C CNN
	1    1400 2600
	0    1    1    0   
$EndComp
Wire Wire Line
	1550 2600 1650 2600
Wire Wire Line
	1250 2600 1250 2750
Wire Wire Line
	1250 2750 1150 2750
Wire Wire Line
	1150 2850 1250 2850
Wire Wire Line
	1250 2850 1250 3000
Wire Wire Line
	1250 3000 1650 3000
$EndSCHEMATC

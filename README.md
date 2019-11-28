# Audio-widget-I2S
**Interfata audio USB utilizand un AVR32 pe protocolul I2S**

## Introducere
>
>Inca din timpurile dinaintea erei digitale, consumatorii de audio **asa zisii audiofili** au fost in cautare de metode pentru reducerea la minim a distorsiunilor transmise catre difuzoare,si implicit,percepute de urechea umana.In vremea respectiva,data fiind si complexitatea destul de redusa a dispozitivelor,ideea reducerii distorsiunilor in sisteme era destul de limitata de topologiile propuse,de aceea aparitia sistemelor digitale de procesare in audio a dus la reducerea drastica a neajunsurilor semnalelor analogice.Pentru **puristi** , circuitele digitale si DSP-urile sunt considerate _un sacrilegiu_ adus audiofiliei,dar este unul justificat,deoarece in ciuda complexitatii mai ridicate fata de un circuit analog pur , sistemele digitale sunt mult mai eficiente fata de complementele sale,iar posibilitatea customizarii lor este foarte mare (spre deosebire de un circuit analogic unde,pentru a modifica o caracteristica trebuie regandit tot circuitul,in cazul unui circuit digital cu uC este doar o problema de software).

>Aparitia interfetelor audio s-a facut odata cu dezvoltarea PC-urilor si inregistrarea de muzica/sunete pe medii digitale , in pofida benzilor magnetice si a discurilor de vinil , deoarece era necesara o metoda de redare a sunetelor stocate pe calculatoarele vremii. De altfel,primele asa zise **placi de sunet** si-au facut aparitia prin calculatoare in jurul generatiei 80486 , cand deja exista o oarecare structura de operare stabila pe 16 biti , iar pentru o esantionare simpla a sunetelor erau arhisuficiente instructiunile implementate de Intel in procesoarele respective.
>>_Daca facem referinta la vremurile actuale,se poate spune ca practic nici nu se punea problema de calitate sau termenul de **Hi-Fi** in acele vremuri,dar acele sunete au reprezentat ceea ce urma sa fie boom-ul erei digitale_
>
>Ca si istorie a acestei ere in care traim,se pot scrie foarte multe lucruri deja cunoscute,asa ca voi incerca sa ma concentrez pe esential.

>Ideea de "calitate audio" pe digital a aparut in momentul lansarii pe piata mondiala a CD-ului (acel lucru care acum multora dintre noi ni se pare atat de outdated,ori chiar nu il mai folosim),dar el a avut cea mai mare influenta in aparitia de tehnologii de compresie si codare audio.Ca si concept,ideea de CD a aparut prin anul 1980 ,cand Philips si Sony au incheiat un parteneriat de cercetare in domeniul digital,dorindu-se un mediu de stocare unic transmisibil,care sa aibe un spatiu de stocare a informatiilor mult mai mare decat cel al dischetelor "floppy" si al benzilor magnetice,dar totusi sa nu coste cat un hard disk al vremurilor (memo: un hard disk de tip Winchester avea o capacitate de maxim 128MB , cantarea in jur de 15-20kg si era cam cat un desktop SFF actual ca dimensiuni si costa in jur de ~5.000 de dolari unul?).
>>Standardul CD a fost definitivat in jurul anului 1983,iar in urma intelegerii realizate intre cele 2 concerne se va realiza trecerea industriei audio catre acest mediu.

>Se pune problema "compresiei audio".In a nutshell,algoritmul de compresie audio se refera la un standard de scriere-redare a sunetelor pe calculatoare. Calculatoarele,la momentul respectiv avand sisteme de operare stabile precum UNIX si DOS (vorbind de anii '80,dar regula se aplica si in prezent pe sistemele actuale),pentru a reda sunetele stocate pe medii precum hard-diskul se folosesc de niste software numite **codec** .
>>Codecurile,in esenta,sunt niste pseudo-drivere pe care sistemul de operare le interpreteaza atunci cand se executa in sistem un fisier cu extensia ce corespunde codecului respectiv.
>>Adica,spre exemplu, avem un fisier cu extensia ".mp3" , SO va sti ca la instantierea acestui fisier va trebui sa apeleze un Codec LAME(Lame Ain't an MP3 Encoder - care este o derivatie imbunatatita de-a lungul anilor de diversi programatori din conceptul original gandit de institutul Fraunhofer din Germania).

>De altfel , toate procedeele de redare/compresie si extensiile de sistem au fost posibile datorita codarii PCM (Pulse Code Modulation).
PCM reprezinta transformarea semnalelor analogice in semnale digitale printr-un algoritm de esantionare constanta a amplitudinii semnalului analogic ,iar fiecare esantion este cuantizat la cea mai apropiata valoare dintr-o gama de cuante apropiate.
>>**Codarea PCM prezinta 2 proprietati ce determina calitatea conversiei semnalului original raportat la acesta : rata de esantionare a semnalului si _bit depth_,care reprezinta cantitatea de biti al fiecarui esantion realizat (un CD-Audio prezinta un bit depth de 16 biti per esantion , pe cand un Blu-ray sau DVD-Audio 24 de biti per esantion).**
>>> Extensiile posibile unei compresii PCM sunt ".wav" ,".L16",".PCM",".AIFF",".AU"

>Pe baza codarii/compresiei PCM a fisierelor audio, cei de la Philips au realizat in anul 1986 (si ulterior revizuit in 1996) un protocol de transmisie seriala al datelor audio intre dispozitive / circuite integrate , protocol care inca se foloseste cu succes si in prezent in dispozitivele audio. Este cunoscut sub acronimul I2S sau IIS **Inter-IC Sound** si se bazeaza pe o magistrala sincrona de transmisie de date (clockul de transmisie intre circuite este separat de magistrala de date,deci implicit receptorul nu mai are nevoie de un circuit suplimentar de refacere a frontului de ceas trimis de emitator).
>Protocolul este relativ usor de interpretat, in principal avem de-a face cu 3 semnale : bit clock line(**BCLK**) , word clock line (cunoscut sub denumirea oficiala de 'word select' **WS** sau 'left-right clock' **LRCLK** ) si cel putin o linie de date multiplexata **SD**

>>Adeseori se mai poate intalni peste cele 3 semnale cunoscute inca un semnal de tact (care nu face parte din protocol) cu rolul de a sincroniza operatiile interne ale DAC-urilor cu cele ale controllerului . Este gasit sub acronimul de "Master clock" **MCLK**
>>>Frecventa tipica de lucru se calculeaza dupa formula : **MCLK = 256 * LRCLK**

![500px-I2S_Timing svg](https://user-images.githubusercontent.com/54248886/66950287-bf636680-f060-11e9-9627-63df32e9b9f9.png)

###### Cum functioneaza protocolul:

>Semnalul de "Word Select" permite dispozitivului receptor sa 'vada' ce canal urmeaza sa fie trimis , deoarece I2S permite ca pe aceeasi linie de date sa fie trimise 2 canale,fiind un semnal cu factor de umplere 50% si frecventa egala cu cea de esantionare a semnalului trimis.
>>**Pentru semnale stereo , in brosura de specificatii a I2S se spune ca semnalul audio de pe canalul stang se transmite pe palierul de 0 al Word Select , iar canalul drept pe palierul de 1 . De obicei , semnalul "Word Select" este sincronizat dupa fronturile cazatoare ale semnalului BCLK , deoarece datele sunt zavorate pe fronturile crescatoare**.
>>
>Se stabileste semnul liniei de date si se codeaza in complement fata de 2 cu primul bit MSB-ul . **Acest lucru permite ca numarul de biti per cadru sa fie arbitrar , fara a fi nevoie de "negociere" intre emitator si receptor **.

## Specificatii montaj:

1.
 a)Microcontroller utilizat:  Atmel AT32UC3A3256 
 >>>  A complete system-on-chip 32-bit AVR microcontroller. It is designed for cost-sensitive embedded applications that require low power consumption, high code density and high performance.

 >>> The microcontroller's Memory Protection Unit (MPU) and fast, flexible interrupt controller support the latest real-time operating systems. Higher computation capabilities are achievable using a rich set of DSP instructions. The device incorporates on-chip flash and SRAM memories for secure and fast access. 64 KBytes of SRAM are directly coupled to the 32-bit AVR UC3 for performance optimization. Two blocks of 32 Kbytes SRAM are independently attached to the high speed bus matrix for real ping-pong management.

 >>> The microcontroller achieves exceptionally high data throughput by combining the multi-layered 32-bit AVR databus,128 KB on-chip SRAM with triple high speed interfaces, multi-channel peripheral, memory-to-memory DMA controller, high-speed USB embedded host, SD/SDIO card, MLC NAND flash with ECC, and SDRAM interfaces.

 >>> This device features 256KB internal high-speed flash and full-duplex multi-channel I2S audio interface.
 
 b) DAC utilizat: PCM5102A

 >>>The PCM510xA devices are a family of monolithic CMOS-integrated circuits that include a stereo digital-to-analog converter and additional support circuitry in a small TSSOP package. The PCM510xA devices use the latest generation of TI’s advanced segment-DAC architecture to achieve excellent dynamic performance and improved tolerance to clock jitter.

 c) Amplificator/buffer iesire folosit : TPA6120
 >>>In applications requiring a high-power output, very high fidelity headphone amplifier, the TPA6120A2 replaces a costly discrete design and allows music, not the amplifier, to be heard. The TPA6120A2’s current-feedback AB amplifier architecture delivers high bandwidth, extremely low noise, and up to 128dB of dynamic range.
 
2.Utilizeaza USB Audio Class 1 / 2.

3.Capabilitati de redare audio pana la 24bit/96kHz (bit depth / sampling rate).

4.Tensiune de alimentare: 5V (doar daca utilizam DAC-ul si interfata I2S) , +12/-12V (daca se utilizeaza si amplificatorul final)

5.Consum max: 1-1,5A (este necesara alimentare suplimentara deoarece amplificatorul final de casti se alimenteaza diferential) 

### Constructie montaj:

Contructia se bazeaza pe un design modular , iar in acest sens voi concepe intregul sistem pe 4 placi:
 - una o va constitui interfata emulatoare usb-i2s
 - o placa pentru DAC si , eventual , buffere de iesire
 - o placa pentru amplificatorul final
 - o placa pentru alimentare suplimentara

Ideea conceperii montajului intr-un sistem modular este pentru imbunatatirea "lantului" pe decursul timpului (ex. realizarea unui DAC mai performant din perspectiva SNR / PSRR sau schimbarea unei surse liniare cu una in comutatie sau adaugarea de acumulatori pentru portabilitate etc.)

De altfel,un montaj modular poate presupune o asezare mai buna in cutie si,totodata, un ecranaj mai bun al partilor **mai sensibile** fata de circuitul de alimentare.
![IMAG1202](https://user-images.githubusercontent.com/54248886/69480411-e6efe080-0e0f-11ea-8b53-cbce3b7b18eb.jpg)
![IMAG1204](https://user-images.githubusercontent.com/54248886/69480420-f707c000-0e0f-11ea-8b5e-79ab937f0673.jpg)
![IMAG1206](https://user-images.githubusercontent.com/54248886/69480430-05ee7280-0e10-11ea-9400-69c43f24d674.jpg)

#### Particularitate software:

Ideea interfetei I2S este bazata pe un proiect deja existent in mediul online , anume SDR-Widget https://github.com/borgestrand/sdr-widget

Asadar hardware-ul din spatele acestui sistem a fost dezvoltat in asa fel incat firmware-ul cu care am programat AVR-ul sa fie direct compatibil.
Din punct de vedere functional, din software-ul dezvoltat in acel proiect am folosit doar mediul de comunicare audio via USB (UAC1 si UAC2) si partea de control software a volumului.

Consider ca nu este necesar sa uploadez toate sursele C pentru generarea firmware-ului , asa ca voi atasa fisierul HEX(.elf) continand versiunea stabila de firmware pentru acest sistem.


#### Programarea microcontrollerului:

Seria UC3A3 de la Atmel(Microchip-ish or whatsoever) au incarcate din fabricatie un bootloader ce contine un USB DFU(Device Firmware Upgrade).
DFU este un protocol ce se regaseste in orice tip de terminal ce are propriul sistem de operare,deoarece faciliteaza operatiunea de rescriere a software-ului deja setat in terminalul respectiv utilizand o interfata de comunicare uzuala.

De aceea , microcontrolerul pe care l-am utilizat in montaj (AT32UC3A3256) l-am programat cu doar un USB si programul ATMEL FLIP 3.4.7 , utilizand din acesta batchisp-ul (pentru ca,prin constructia sa , programul Flip nu suporta la un nivel stabil aceasta serie de uC-uri).

![image](https://user-images.githubusercontent.com/54248886/69480608-a1341780-0e11-11ea-83ec-910466c1f9c6.png)

Nu mai pot reproduce inca o data procesul de programare (sau il voi mai face ulterior daca dezvolt un alt firmware mai performant pentru cerinta data), dar comanda de programare pe care am utilizat-o este:
**batchisp -device at32uc3a3256 -hardware usb -operation erase f memory flash blankcheck loadbuffer widget.elf program verify start reset 0**
Unde widget.elf se inlocuieste cu denumirea HEX-ului de urcat pe uC.

Dupa introducerea comenzii se executa programarea uC-ului in 11 pasi:

AT32UC3A3256 - USB - USB/DFU

Device selection....................... PASS

Hardware selection..................... PASS

Opening port........................... PASS

Reading Bootloader version............. PASS    1.0.3

Erasing................................ PASS

Selecting FLASH........................ PASS

Blank checking......................... PASS    0x00000 0x3ffff

Parsing ELF file....................... PASS    widget.elf

WARNING: The user program and the bootloader overlap!

Programming memory..................... PASS    0x00000 0x1c43f

Verifying memory....................... PASS    0x00000 0x1c43f

Starting Application................... PASS    RESET   0


Summary:  Total 11   Passed 11   Failed 0

Dupa programarea uC-ului calculatorul "teoretic" ar trebui sa il recunoasca automat si sa instantieze driverul necesar utilizarii acestuia. Cel putin in Windows 10 nu exista probleme de compatibilitate a driverelor, recunoscandu-le automat la conectarea interfetei. Posibil sa existe probleme de "backwards compatibility" a firmware-ului cu versiunile mai vechi de Windows,dar se rezolva instaland manual "inf drivers".

## Utilizare:

![Asio_logo](https://user-images.githubusercontent.com/54248886/69481196-d04d8780-0e17-11ea-891d-d0f364f49dae.png)


Ca si software , interfata este gandita destul de simplist,deoarece se considera ca este suficient doar un control al volumului,niciun fel de egalizare grafica sau corectie de tonuri.
Software-ul de control este scris pe framework-ul ASIO (_Audio Stream Input-Output_).
Ca si un mic memo : ASIO este un protocol de drivere open-sourced pentru "sound card-uri" specificat in industria audio de firma Steinberg.
Ca si functionare a protocolului : ASIO produce un bypass al caii audio normale la nivel de aplicatie din sistemul de operare utilizat,astfel incat sa se evite "layer-ele" suplimentare la nivel de software.Acest lucru permite aplicatiei sa se conecteze la sound card direct,fara intermedierea sistemului de operare in procesul respectiv.Acest lucru duce la o reducere foarte mare a latentei de transfer a informatiei audio de la soft la hard.


![Foobar2000_logo_2014](https://user-images.githubusercontent.com/54248886/69500290-707fdb00-0f02-11ea-9650-a19ed6225774.png)

>>Foobar2000 **logo de mai sus** este un player audio freeware (nu este necesara licenta de utilizare) pentru Microsoft Windows, iOS, si Android dezvoltat de Peter Pawłowski.Ca si software este cunoscut designul sau extrem de modular , multitudinea de caracteristici si flexibilitatea in configurare pentru user.
>>Acest player suporta foarte multe formaturi audio , prezinta o multitudine de caracteristici organizarea fisierelor , metadata si are implementata o interfata de convertor utilizabila in linie de comanda (transcodare fisiere si ripping CD-Audio). 

![image](https://user-images.githubusercontent.com/54248886/69500447-cbfe9880-0f03-11ea-9537-2f1b52a718ac.png)

In poza , aplicatia redand un fisier audio .FLAC (lossless audio codec) , configurat pentru output pe WASAPI* , buffer length minim pentru jitter scazut intre interfata de comunicare si controller.

>>>> **Ca si ASIO , WASAPI (Windows Audio Session API) este un plugin utilizat in audio pentru a permite trecerea fluxului de date audio direct intre terminalul audio din aplicatia ce reda fisierele audio**
>>>> Diferenta principala dintre ASIO si WASAPI este ca , primul este un plugin open-source (poate fi luat si modificat in drivere de oricine) , pe cand cel din urma este conceput de MICROSOFT si na...copyright in a nutshell daca vrea cineva sa modifice core-ul plugin-ului.

![image](https://user-images.githubusercontent.com/54248886/69500504-6f4fad80-0f04-11ea-988d-c1e252b3e5ac.png)

>>>Ca si comparatie intre cele 2 pluginuri, ambele sunt foarte usor de utilizat si instalat , cu precizarea ca ASIO functioneaza cu doar cu dispozitivele ce au descriptori dedicati in driverele lor , pe cand WASAPI functioneaza cu orice fel de endpoint device , atata timp cat este selectat pluginul ca si output pentru device-ul respectiv si nu adresa "Direct Sound".

>>>> **De precizat ar mai fi ca,atata timp cat un eveniment WASAPI / ASIO este executat , nu se mai reda niciun flow audio din partea altor aplicatii pana nu se incheie evenimentul respectiv**


### Ansamblare

Pentru incapsularea proiectului am ales sa separ sursa de alimentare de partea de DAC+Amplif casca pentru a evita producerea de zgomot inutil in sistem. **ideea este tocmai de a avea un zgomot minim in tot lantul si atunci este de preferat ca sursa sa stea cat mai departe de elementele sensibile ale sistemului**

Asadar , pentru incapsularea amplificatorului am comandat o carcasa din aluminiu eloxat argintiu de la Hammond,cu dimensiunile 220x103x31mm (LxlxH) , iar pentru sursa probabil voi utiliza o cutie de ramificatie electrica **de aparataj** pentru ca nu are prea mare importanta aspectul ei (ca oricare alta sursa de alimentare, va sta intr-un loc prea putin vizibil).

![image](https://www.hammfg.com/files/products/1455/1455l2201rb.jpg)

Pentru alimentare voi monta pe ambele carcase o mufa DIN 3P ce se asigura cu o piulita de blocare , cu 3 pini deoarece amplificatorul se alimenteaza diferential.

#### Masuri pentru evitarea producerii/captarii de zgomot in circuit:

1.Decuplarea alimentarilor cu condensatoare de valoare foarte mica (capabilitate de lucru in frecvente mari) - zeci/sute nF si de valoare f. mare (capabilitate de lucru in frcvente mici).

2.Torsadarea cablurilor de alimentare din carcasa (reducerea emisiilor em. in circuit).

3.Separarea pe cat posibil a circuitelor de semnal mic fata de cele de alimentare.

4.Utilizarea unui punct comun de legatura a maselor din intregul circuit (star pattern sau line pattern , in cazul meu voi utiliza un line pattern deoarece nu sunt implicati curenti mari de circuit - max 1A peak).

5.Utilizare de filtraj cat mai generos - capacitatile mari de filtrare implica un riplu foarte mic al sursei de alimentare,deci posibilitatea aparitiei unui zgomot perturbator pe alimentare minim.
>>Cu riscul aparitiei unui curent de incarcare foarte mare,se recomanda utilizarea de capacitati mari pentru evitarea riplului,mai ales in circuite unde este nevoie de curenti mari pe perioade scurte.
>>>Problema curentilor mari de incarcare se rezolva cu niste rezistente serie cu condensatorii (zeci de ohmi),care sa limiteze curentul prin ei la pornire,dupa aceea rezistentele se sunteaza cu un releu si se utilizeaza normal **soft-start empiric**

**RIPLU -> componenta alternativa aparuta la ciclurile de incarcare-descarcare ale condensatorilor intr-un redresor**

## Limitari si probleme aparute de-a lungul constructiei:

Cea mai mare problema am avut-o la ansamblare...un cosmar si jumatate din perspectiva unei persoane ce a lucrat mai tot timpul cu componente THT si acum s-a lovit de "zidul" lipirii de componente SMD. Am facut si prostia de a ma apuca si fix de cea mai complicata placa mai intai , cea a interfetei USB-I2S, cei 144 de pini ai uC-ului mi-au dat de furca pana l-am lipit cum trebuie,deoarece m-am incapatanat sa il lipesc pin cu pin cu letconul si la un moment dat aveam efectiv mai multe scurturi intre pini decat pini lipiti cum trebuie de placa.Dar acest mic detaliu a fost rezolvat cu mult flux,efect capilar si injuraturi cand nu voia fludorul sa plece dintre pini pe talpa varfului folosit.
De altfel ,toate componentele 0603 de pe aceasta placa mi-au provocat o mare placere de a invoca sfinti de-a lungul lipirii lor.
Apexul a fost atins la ora 3 noaptea,dupa ce am terminat de lipit placuta interfetei,am legat-o la USB si am realizat,cu stupoare,ca nu face nimic...nu se conecta la calculator.Din nou,nervi injuraturi,abtineri din a tranti minunea peste tot.
A doua zi am rezolvat problema in 10 minute : stabilizatorul 5V-3.3V de pe placa avea un pin " in aer " si nu aveam output pentru alimentarea uC-ului.

**Morala ar fi ca: prea multe beri si oboseala dupa 12 ore de alergat dintr-o parte in alta dauneaza bunei atentii asupra realizarii unui montaj.**

Montarea placii DAC a fost pretty straightforward , nu am intampinat cine stie ce dificultati, mai ales acum avand experienta lipirii "ghindoacelor" 0603 pe placa interfetei ... componentele 1206 si integratul SSOP cu 20 de pini au fost PARFUM!!

Placa amplificatorului am montat-o si cam atat, pana acum m-am folosit doar de mufa de casca pentru a vedea daca functioneaza dacul cum trebuie.Urmeaza sa montez si sursa de alimentare si o voi testa si pe aceasta.

Singura limitare "constructiva" mi-am creat-o singur,din pricina carcasei alese pentru circuit. Am ales o carcasa cu inaltimea de 31mm, insuficient pentru inaltimea potentiometrului pe PCB-ul amplificatorului.Am fAacut aceasta eroare deoarece nu am tinut cont ca primele caneluri de suport pentru cablaje incep de la aproximativ 5mm fata de fundul carcasei , ceea ce ar insemna ca depasesc inaltimea montarii capacului cu potentiometrul cu vreo 2mm din ce am masurat.

Solutia: montat potentiometrul si mufa de casca solitare pe panoul frontal si facut legaturi cu PCB-ul prin cabluri torsadate si mufate.

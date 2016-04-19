# fprpiled
Fp Rpi LED

A Free Pascal/Lazarus project as Raspberry Pi GPIO access sample

FpiRpiLed may be compiled on generic GNU/Linux (and maybe Windows & Mac) systems as on Raspberry Pi. This program is useful only on Raspi, as it is aimed to play with some LEDs connected to the Raspi GPIO ports with just a bunch of buttons to turn LEDs on and off.

Binary versions compiled on systems other than Raspberry Pi will run but will have the actual access to GPIO ignored (via compiler directives) and therefore can be used as example of the program UI. Binry versions compiled for ARM will try to actually access GPIO (it is supposed to be compiled for and run on Raspberry Pi or compatible hardware).

Port numbers may be assigned to GUI controls associated to different kind of LED: single color , RGB, double color; the program has a dedicated form which should make such operation quite simple.

Remember that LEDs have to be connected using resistors of proper value in order to avoid damages. Please look around on the Net to gather further informations if you ar not sure about what you're doing (you may find many examples on Pi+LED).

I also suggest using a breadbord and GPIO breakout board.

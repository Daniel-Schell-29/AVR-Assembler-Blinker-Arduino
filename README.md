# Arduino-LED-blink-pattern-assembly-
This project implements a simple LED-sequence on an Arduino Uno R3 using the AVR-Assembler Language.
My goal was to get a deeper understanding of the internal workings of the Processor without the assistance of modern libraries or languages.

## What It Does

The LED follows a dynamic pattern that gradually changes timing:
- Starts blinking at 1 second ON / 1 second OFF
- Gradually increases to 2 seconds ON / 2 seconds OFF (in 250ms steps)
- Then decreases back down to 250ms ON / 250ms OFF
- Resets and repeats
  
**Implementation**
- The main logic is written in AVR Assembly(main.S), with a minimal C++ wrapper(Arduino_IDEstarter.ino) to upload it with the Arduino IDE

**To run this project:**
1. Open the [.ino script in /code](code/Arduino_IDEstarter.ino) in the Arduino IDE
2. Add the [Assembly script in /code](code/main.S) as another tab **in the same project**
3. Compile and upload it to the Arduino Uno R3 using the Arduino IDe

**Assembly highlights:**
- Direct port manipulation (DDRB, PORTB registers)
- Custom nested-loop delay function optimized for 16MHz clock
- State machine for counting up/down through timing intervals
- Disabled interrupts for timing precision

**Used Hardware**
- Arduino Uno R3
- 1xLED (at digital Pin 12, PB4)
- 1x 220Ω series resistor

**Setup**
Here's the setup of the electrical circuit and a demo of the Blinking sequence:
- ![Setup Photo](media/setup_photo.jpg)
- ![Blinking sequence demo video](media/blink_demo.mp4)

# Arduino-LED-blink-pattern-assembly-
This project implements a simple LED-sequence on an Arduino Uno R3 using the AVR-Assembler Language.
My goal was to get a deeper understanding of the internal workings of the Processor without the assistence of modern libarys or languages.

**Functions**
-LED connected to digital PIN 12 gets turned on and off in a pre-determined pattern( 1s. --> 2.s --> 250ms) with each step being 250ms.
-Self coded **delay** function with minimal overhead. Mathematically the difference should be less than 0.05%
-The pattern starts with 1s on and 1s off then both the time off and on going up 250ms until it reaches 2s and going back
  down in steps in 250ms until the time on and off are both 250ms. Then it resets and starts at 1s again.

**Used Hardware**
-Arduino Uno R3
-1xLED
-1x 220Ω Pull-down resistor

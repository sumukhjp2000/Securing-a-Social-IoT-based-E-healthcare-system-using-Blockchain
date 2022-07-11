Screenshot | Video Demonstration
---|---
![](src/app%20screenshot.png) | [![Project Demonstration](src/thumbnail.jpeg)](https://youtu.be/2zm26Cbve4A)

# THE SENSORS WE HAVE Used:
# Arduino-MAX30100

[![Build Status](https://travis-ci.org/oxullo/Arduino-MAX30100.svg?branch=master)](https://travis-ci.org/oxullo/Arduino-MAX30100)

Arduino library for the Maxim Integrated MAX30100 oximetry / heart rate sensor.

![MAX30100](http://www.mouser.com/images/microsites/Maxim_MAX30100.jpg)

## Disclaimer

The library is offered only for educational purposes and it is not meant for medical uses.
Use it at your sole risk.

## Notes

Maxim integrated stopped the production of the MAX30100 in favor of MAX30101 and MAX30102.
Therefore this library won't be seeing any further improvement, besides fixes.

*IMPORTANT: when submitting issues, make sure to fill ALL the fields indicated in the template text of the issue. The issue will be marked as invalid and closed immediately otherwise.*

## Hardware

This library has been tested with the MikroElektronika Heart rate click daughterboard:

http://www.mikroe.com/click/heart-rate/

along with an Arduino UNO r3. Any Arduino supporting the Wire library should work.

The only required connection to the sensor is the I2C bus (SDA, SCL lines, pulled up).

An example which shows a possible way to wire up the sensor is shown in
[extras/arduino-wiring.pdf](extras/arduino-wiring.pdf)

Note: The schematics above shows also how to wire up the interrupt line, which is
currently not used by the library.

### Pull-ups

Since the I2C interface is clocked at 400kHz, make sure that the SDA/SCL lines are pulled
up by 4,7kOhm or less resistors.

## Architecture

The library offers a low-level driver class, MAX30100.
This component allows for low level communication with the device.

A rather simple but working implementation of the heart rate and SpO2 calculation
can be found in the PulseOximeter class.

This high level class sets up the sensor and data processing pipelines in order to
offer a very simple interface to the data:

 * Sampling frequency set to 100Hz
 * 1600uS pulse width, full sampling 16bit dynamic
 * IR LED current set to 50mA
 * Heart-rate + SpO2 mode

The PulseOximeter class is not optimised for battery-based projects.

## Examples

The included examples show how to use the PulseOximeter class:

 * MAX30100_Minimal: a minimal example that dumps human-readable results via serial
 * MAX30100_Debug: used in conjunction with the Processing pde "rolling_graph" (extras folder), to show the sampled data at various processing stages
 * MAX30100_RawData: demonstrates how to access raw data from the sensor
 * MAX30100_Tester: this sketch helps to find out potential issues with the sensor

## Troubleshooting

Run the MAX30100_Tester example to inspect the state of your rig.
When run with a properly connected sensor, it should print:

```
Initializing MAX30100..Success
Enabling HR/SPO2 mode..done.
Configuring LEDs biases to 50mA..done.
Lowering the current to 7.6mA..done.
Shutting down..done.
Resuming normal operation..done.
Sampling die temperature..done, temp=24.94C
All test pass. Press any key to go into sampling loop mode
```

Pressing any key, a data stream with the raw values from the photodiode sampling red
and infrared is presented.
With no finger on the sensor, both values should be close to zero and jump up when
a finger is positioned on top of the sensor.


Typical issues when attempting to run the examples:

### I2C error or garbage data

In particular when the tester fails with:

```
Initializing MAX30100..FAILED: I2C error
```

This is likely to be caused by an improper pullup setup for the I2C lines.
Make sure to use 4,7kOhm resistors, checking if the breakout board in use is equipped
with pullups.

### Logic level compatibility

If you're using a 5V-based microcontroller but the sensor breakout board pulls SDA and SCL up
to 3.3V, you should ensure that its inputs are compatible with the 3.3V logic levels.
An original Atmel ATMega328p considers anything above 3V as HIGH, so it might work well without
level shifting hardware.

Since the MAX30100 I2C pins maximum ratings aren't bound to Vdd, a cheap option to avoid
level shifting is to simply pull SDA and SCL up to 5V instead of 3.3V.

### Sketchy beat frequency readouts

The beat detector uses the IR LED to track the heartbeat. The IR LED is biased
by default at 50mA on all examples, excluding the Tester (which sets it to 7.6mA).
This value is somehow critical and it must be experimented with.

The current can be adjusted using PulseOximeter::setIRLedCurrent().
Check the _MAX30100_Minimal_ example.

### Advanced debugging

Two tools are available for further inspection and error reporting:

* extras/recorder: a python script that records a session that can be then analysed with the provided collection of jupyter notebooks
* extras/rolling_graph: to be used in conjunction with _MAX30100_Debug_ example, it provides a visual feedback of the LED tracking and heartbeat detector

Both tools have additional information on the README.md in their respective directories.

## Tested devices

* Arduino UNO r3, Mikroelektronika Heart rate click (https://shop.mikroe.com/heart-rate-click)

This combination works without level shifting devices at 400kHz I2C clock rate.

* Arduino UNO r3, MAX30100 custom board with 4.7kOhm pullups to 5V to SDA, SCL, INT

As above, working at 400kHz

* Sparkfun Arduino Pro 328p 8MHz 3.3V, Mikroelektronika Heart rate click

Even if this combination works (MAX30100 communication), the slower clock speed fails to deliver
the required performance deadlines for a 100Hz sampling.

## Troubled breakouts

This breakout board: http://www.sunrom.com/m/5337

Has pullups on the Vdd (1.8V) line. To make it work, the three 4k7 pullups must be
desoldered and external 4.7k pullups to Vcc of the MCU must be added.

# *****************************************************************


# Arduino-AD8232|Sound Card ECG
The **Sound Card ECG** program provides a simple interface to view and measure ECG signals obtained through the sound card (using a line-in or microphone jack).

### Download
A click-to-run EXE is available: **[SoundCardECG.zip](https://raw.githubusercontent.com/swharden/SoundCardECG/master/download/SoundCardECG.zip)** (version 1.5)

### Hardware Notes

Notes | Image
---|---
**AD8232 ECG Module**: My preferred ECG device (and the one I used in the screenshot) is a [AD8232](https://www.analog.com/media/en/technical-documentation/data-sheets/ad8232.pdf) breakout board ([SparkFun](https://www.sparkfun.com/products/12650)) feeding the signal directly into the microphone jack of my PC. | ![](graphics/sound-card-ecg-AD8232.jpg)
**Lead Placement**: The AD8232 works best if leads are placed in one of these configurations | ![](graphics/ecg-lead-placement.png)
**DIY ECG with 1 Op-Amp**: Those interested in building an ECG circuit from scratch may find my [DIY ECG with a Single Op-Amp](https://github.com/swharden/diyECG-1opAmp) (an LM-741) project interesting. | ![](graphics/1-opamp-circuit.jpg)
# ------------------------------------------------------------------------------
# MICROPROCESSORS USED:
![](src/arduino.jpeg) 

<p align="center">
	<img src="http://content.arduino.cc/brand/arduino-color.svg" width="50%" />
</p>

Arduino is an open-source physical computing platform based on a simple I/O
board and a development environment that implements the Processing/Wiring
language. Arduino can be used to develop stand-alone interactive objects or
can be connected to software on your computer (e.g. Flash, Processing and MaxMSP).
The boards can be assembled by hand or purchased preassembled; the open-source
IDE can be downloaded for free at [https://arduino.cc](https://www.arduino.cc/en/Main/Software)

![Github](https://img.shields.io/github/v/release/arduino/Arduino)

## More info at

-  [Our website](https://www.arduino.cc/)

-  [The forums](https://forum.arduino.cc/)

-  Follow us on [Twitter](https://twitter.com/arduino)
-  And like us at [Facebook](https://www.facebook.com/official.arduino)

## Bug reports and technical discussions

-  To report a *bug* in the software or to request *a simple enhancement* go to [Github Issues](https://github.com/arduino/Arduino/issues)

-  More complex requests and technical discussion should go on the [Arduino Developers
mailing list](https://groups.google.com/a/arduino.cc/forum/#!forum/developers)

-  If you're interested in modifying or extending the Arduino software, we strongly
suggest discussing your ideas on the
[Developers mailing list](https://groups.google.com/a/arduino.cc/forum/#!forum/developers)
 *before* starting to work on them.
That way you can coordinate with the Arduino Team and others,
giving your work a higher chance of being integrated into the official release

### Security

If you think you found a vulnerability or other security-related bug in this project, please read our
[security policy](https://github.com/arduino/Arduino/security/policy) and report the bug to our Security Team 🛡️
Thank you!

e-mail contact: security@arduino.cc

## Installation

Detailed instructions for installation in popular operating systems can be found at:

-  [Linux](https://www.arduino.cc/en/Guide/Linux) (see also the [Arduino playground](https://playground.arduino.cc/Learning/Linux))
-  [macOS](https://www.arduino.cc/en/Guide/macOS)
-  [Windows](https://www.arduino.cc/en/Guide/Windows)

## Contents of this repository

This repository contains just the code for the Arduino IDE itself.
Originally, it also contained the AVR and SAM Arduino core and libraries
(i.e.  the code that is compiled as part of a sketch and runs on the
actual Arduino device), but those have been moved into their own
repositories.  They are still automatically downloaded as part of the
build process and included in built releases, though.

The repositories for these extra parts can be found here:
-   Non-core specific Libraries are listed under: <https://github.com/arduino-libraries/>
    (and also a few other places, see `build/build.xml`).

-   The AVR core can be found at: <https://github.com/arduino/ArduinoCore-avr>

-   Other cores are not included by default but installed through the
    board manager. Their repositories can also be found under
    <https://github.com/arduino/>.

## Building and testing

Instructions for building the IDE and running unit tests can be found on
the wiki:
-   <https://github.com/arduino/Arduino/wiki/Building-Arduino>
-   <https://github.com/arduino/Arduino/wiki/Testing-Arduino>

## Credits

Arduino is an open source project, supported by many.

The Arduino team is composed of Massimo Banzi, David Cuartielles, Tom Igoe
and David A. Mellis.

Arduino uses
[GNU avr-gcc toolchain](https://gcc.gnu.org/wiki/avr-gcc),
[GCC ARM Embedded toolchain](https://launchpad.net/gcc-arm-embedded),
[avr-libc](https://www.nongnu.org/avr-libc/),
[avrdude](https://www.nongnu.org/avrdude/),
[bossac](http://www.shumatech.com/web/products/bossa),
[openOCD](http://openocd.org/)
and code from [Processing](https://www.processing.org)
and [Wiring](http://wiring.org.co).

Icon and about image designed by [ToDo](https://www.todo.to.it/)

# *****************************************************************
# ESP8266
![](src/esp8266.png) 
Documentation and help with the ESP8266 chip/boards/modules. 

You can find the entire article [here](https://tttapa.github.io/ESP8266/Chap01%20-%20ESP8266.html), or you can just download it.

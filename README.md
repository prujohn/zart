## Zart - Dart Implementation of Infocom Z-Machine ##
	West of House
	You are standing in an open field west of a white house, with a 
	boarded front door. You could circle the house to the north or south.
	There is a small mailbox here.

	>

Some of my most memorable early gaming experiences were playing Infocom interactive fiction games.

This project is a labor of love.  I'll start with z-machine v3 and see where it goes...
	
Enjoy!

## Features ##
* Plays V3, V5, V7, and V8 games (see "Limitations" below)
* Supports loading raw game files (.z3, .z5, .z8, etc)
* Supports loading .zblorb files, but only uses the game file from the package at this time.
* Separates the UI implementation from the core interpreter functions, providing extensibility
to virtually any platform that Dart runs on (currently Mac, Linux, Windows, and Web).

## Limitations ##

### Older Games May Not Work ###
Some games, especially ones compiled with older version of Inform, may not
work properly.  Trial and error is the only way to know.

The older Infocom games (V3 & V5) appear to work fine.

Games compiled with the latest Inform 7 appear to work fine.

## Playing the Mini-Zork Game ##
There is a web-based version (Chrome or Dartium only, for now):

http://www.lucastudios.com/demos/zart/zartweb.html

The web version uses the Buckshot UI library:

https://github.com/prujohn/Buckshot

## Want to author your own IF games? ##
http://inform7.com/

## Next Steps ##
* Bug fixes, optimization, enhancements to some op codes.
* Add in some detection to warn if the game file may not be playable.
* Improve the web interpreter (not included with this library) to support
split screening, cursor positioning, etc.

## Debugging ##
There is a VERY basic runtime debugger included.  To enter it, type **/!** at any prompt.
Doing so will drop you into a simple REPL.

### Debug Commands ###
* **locals** - dumps out locals for the current routine.
* **globals** - dumps out globals.
* **dictionary** - dumps out the game dictionary.
* **move x to y** - moves object #x to object #y
* **object x** - dumps info regarding object #x.
* **enable (tracing|verbose)** - enables tracing or verbose debug mode.
* **disable (tracing|verbose)** - disables tracing or verbose debug mode.
* **header** - dumps header information
* **dump addr len** dumps memory from address 'addr' to length
* **stacks** - dumps the call stack and the game stack.
* **q** - leave debug mode and return to game.
* **n or Enter** - advance to the next instruction.

You can also enable tracing and/or verbose with:

	Debugger.enableDebug = true;  //toggles all debug options
    Debugger.enableTrace = true;
    Debugger.enableVerbose = true;
    
## Reference Material ##
* Z-Machine Spec: http://www.gnelson.demon.co.uk/zspec/index.html

## Acknowledgements ##
Adam Smith's RNG lib "DRandom" (found here: https://github.com/financeCoding/DRandom/blob/master/DRandom.dart)

## License ##
Source Code: Apache 2.0 (see LICENSE file)

Game files include are covered under their own applicable copyrights 
and licensing.


import 'package:zart/dictionary.dart';
import 'package:zart/game_exception.dart';
import 'package:zart/engines/engine.dart';

class MemoryMap {

  // A word address specifies an even address in the bottom 128K of memory
  // (by giving the address divided by 2). (Word addresses are used only in the abbreviations table.)

  final List<int> memList; //each element in the array represents a byte of z-machine memory.

  // memory map address offsets
  int abbrAddress;
  int objectsAddress;
  int globalVarsAddress;
  int staticMemAddress;
  int dictionaryAddress;
  int highMemAddress;
  int programStart;
  Dictionary dictionary;

  MemoryMap(List bytes)
    : memList = List.from(bytes);


  // Reads a global variable (word)
  int readGlobal(int which){

   //if (which == 0) return Z.stack.pop();

   if (which < 0x10 || which > 0xff) {
     throw GameException('Global lookup register out of range.');
   }

   //global 0x00 means pop from stack
   return loadw(globalVarsAddress + ((which - 0x10) * 2));
  }

  // Writes a global variable (word)
  void writeGlobal(int which, int value){
   // if (which == 0) return Z.stack.push(value);

    if (which < 0x10 || which > 0xff) {
      throw GameException('Global lookup register out of range.');
    }

      storew(globalVarsAddress + ((which - 0x10) * 2), value);
  }

  // static and dynamic memory (1.1.1, 1.1.2)
  /// Get byte from a given [address].
  int loadb(int address){
    assert(address != null);
    checkBounds(address);
    return memList[address] & 0xff;
  }

  /// Get a 2-byte word from given [address]
  int loadw(int address){
    assert(address != null);
    checkBounds(address);
    checkBounds(address + 1);
    return _getWord(address);
  }

  //dynamic memory only (1.1.1)
  //put byte
  void storeb(int address, int value){
    assert(address != null);
    checkBounds(address);
    //TODO validate

    assert(value != null && (value <= 0xff && value >= 0));

    memList[address] = value;
  }

  //put word
  void storew(int address, int value){
    assert(address != null);
    checkBounds(address);
    checkBounds(address + 1);

    if (value > 0xffff) {
      throw GameException('word out of range');
    }

    if (value < 0){
      //convert to 16-bit signed neg
      value = Engine.dartSignedIntTo16BitSigned(value);
    }

    assert(value >= 0);

    assert(((value >> 8) & 0xff) == (value >> 8));

    memList[address] = value >> 8;
    memList[address + 1] = value & 0xff;
  }

  int _getWord(int address) {
    var word = ((memList[address] << 8) | memList[address + 1]) & 0xffff;
    // if (address == 6){
    //   print("address index: ${address}, word: $word");
    //   print("address: ${BinaryHelper.binaryOf(memList[address])}, address << 8: ${BinaryHelper.binaryOf(memList[address] << 8)}, address + 1: ${BinaryHelper.binaryOf(memList[address+1])} ");
    //   print("address<<8 | address + 1: = ${BinaryHelper.binaryOf(((memList[address] << 8) | memList[address + 1]))}");
    //   print("final: ${BinaryHelper.binaryOf(((memList[address] << 8) | memList[address + 1]) & 0xffff)}");
    // }

    //no Dart negative values should be present.
    assert(word >= 0);
    return word;
  }

  void checkBounds(int address){
   assert(address != null);

   if ((address == null) || (address < 0) || (address > memList.length - 1)){

    // Debugger.debug('out of bounds memory. upper: ${_mem.length}, address: $address');

     throw GameException('Attempted access to memory address'
       ' that is out of bounds: $address (hex: 0x${address.toRadixString(16)}).  Max memory is: ${memList.length}');
   }
  }

  String dump(int address, int howMany){
    return getRange(address, howMany).map((o)=> '0x${o.toRadixString(16)}').toString();
  }

  List getRange(int address, int howMany){
    checkBounds(address);
    checkBounds(address + howMany);
    return memList.getRange(address, howMany) as List<int>;
  }

  int get size => memList.length;

}

import 'package:zart/z_machine.dart';
import 'package:zart/debugger.dart';

class GameException implements Exception {
  final int addr;
  final String msg;

  GameException(this.msg) : addr = Z.engine.PC - 1 {
    print(this);
  }

  String toString() {
    try {
      return 'Z-Machine exception: [0x${addr.toRadixString(16)}] $msg\n';
    } on Exception catch (_) {
      return msg;
    }
  }
}

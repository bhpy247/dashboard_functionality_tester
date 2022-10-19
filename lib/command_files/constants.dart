import 'package:serial_port_win32/serial_port_win32.dart';

class MyConstants {

  static late SerialPort _port;

  set port(SerialPort value) {
    _port = value;
  }

  SerialPort get port => _port;
}
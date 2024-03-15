import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:control/device.dart';

class SelectBondedDevicePage extends StatefulWidget {
  final bool checkAvailability;
  // 确保onChatPage的参数类型和使用位置匹配
  final Function(BluetoothDevice) onChatPage;

  const SelectBondedDevicePage({
    this.checkAvailability = true, 
    required this.onChatPage
  });

  @override
  _SelectBondedDevicePageState createState() => _SelectBondedDevicePageState();
}

enum _DeviceAvailability {
  no,
  maybe,
  yes,
}

// 使用组合代替继承
class _DeviceWithAvailability {
  final BluetoothDevice device;
  _DeviceAvailability availability;
  int? rssi;

  _DeviceWithAvailability({
    required this.device,
    this.availability = _DeviceAvailability.maybe,
    this.rssi,
  });
}

class _SelectBondedDevicePageState extends State<SelectBondedDevicePage> {
  List<_DeviceWithAvailability> devices = [];
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  bool _isDiscovering = false;

  @override
  void initState() {
    super.initState();
    _isDiscovering = widget.checkAvailability;
    if (_isDiscovering) {
      _startDiscovery();
    }
    FlutterBluetoothSerial.instance.getBondedDevices().then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices.map((device) => _DeviceWithAvailability(device: device)).toList();
      });
    });
  }

  void _restartDiscovery() {
    setState(() => _isDiscovering = true);
    _startDiscovery();
  }

  void _startDiscovery() {
    _discoveryStreamSubscription = FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      final existingIndex = devices.indexWhere((element) => element.device.address == r.device.address);
      if (existingIndex >= 0) {
        setState(() {
          devices[existingIndex].availability = _DeviceAvailability.yes;
          devices[existingIndex].rssi = r.rssi;
        });
      }
    });

    _discoveryStreamSubscription!.onDone(() => setState(() => _isDiscovering = false));
  }

  @override
  void dispose() {
    _discoveryStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select device'),
        actions: <Widget>[
          _isDiscovering
              ? FittedBox(
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.replay),
                  onPressed: _restartDiscovery,
                )
        ],
      ),
      body: ListView(
        children: devices.map((_device) => BluetoothDeviceListEntry(
            device: _device.device,
            onTap: () => widget.onChatPage(_device.device),
            // 根据需要添加其他参数，如 enabled 或 rssi
          )).toList(),
      ),
    );
  }
}

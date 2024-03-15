import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  final void Function() onTap; // 明确指定onTap的类型
  final BluetoothDevice device;

  // 构造函数参数类型也应与onTap匹配
  BluetoothDeviceListEntry({required this.onTap, required this.device});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.devices),
      title: Text(device.name ?? "Unknown device"), // 处理device.name可能为null的情况
      subtitle: Text(device.address.toString()),
      trailing: ElevatedButton(
        child: Text('Connect'),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // 设置按钮的背景颜色
        ),
      ),
    );
  }
}

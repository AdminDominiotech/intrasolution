import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Device {
  Device._();
  static final Device info = Device._();

  DeviceInfoPlugin? _device;
  PackageInfo? _package;

  DeviceInfoPlugin get _deviceInfo {
    if (_device != null) return _device!;
    _device = DeviceInfoPlugin();
    return _device!;
  }

  Future<PackageInfo> get _packageInfo async {
    if (_package != null) return _package!;
    _package = await PackageInfo.fromPlatform();
    return _package!;
  }

  int get getPlatformInt {
    if (Platform.isAndroid) {
      return 1;
    }
    if (Platform.isIOS) {
      return 2;
    }
    return 1;
  }

  Future<String> getModelDevice() async {
    if (Platform.isAndroid) {
      var device = await _deviceInfo.androidInfo;
      return '${device.brand} ${device.model}';
    }
    if (Platform.isIOS) {
      var device2 = await _deviceInfo.iosInfo;
      return 'Apple ${device2.utsname.machine}';
    } else {
      return 'ModelDevice Desconocido';
    }
  }

  Future<String> getVersion() async {
    var package = await _packageInfo;
    return package.version;
  }
}

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../constant_definition.dart';
import 'local_device_entity.dart';

abstract class LocalDeviceRepository {
  Future<LocalDevice> load();

  Future<bool> save(String identifier);

  Future<bool> delete();

  Future<LocalDevice> preloadData(LocalDevice device);

  Future<LocalDevice> updateTimezone(LocalDevice device);
}

/// Little copy pasting is better than little dependency
/// This repository save device data in shared preferences
class LocalDeviceSimpleRepository extends LocalDeviceRepository {
  static const String key = 'deviceId';

  final Logger logger = Logger('LoadLocalDevice');

  /// Load device model by id, with the default identifier
  @override
  Future<LocalDevice> load() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    // identifier
    String identifier;

    // check existing device key
    if (sp.containsKey(key)) {
      identifier = sp.getString(key);
      logger.fine('Local device id found $identifier');
    } else {
      identifier = Uuid().v4();
      logger.fine('Create new device id $identifier');
      // save to shared repository
      await save(identifier);
    }

    return LocalDevice.init(identifier);
  }

  @override
  Future<bool> save(String identifier) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    logger.fine('Save local device id $identifier');

    return await sp.setString(key, identifier);
  }

  @override
  Future<bool> delete() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    // TransactionLocalDataSource.db.deleteTransactions();

    logger.fine('Delete local device id');

    return await sp.remove(key);
  }

  /// Update device data, exclude the current location
  @override
  Future<LocalDevice> preloadData(LocalDevice device) async {
    String name;
    String osType;
    String osVersion;

    // update specific os
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidDeviceInfo =
          await DeviceInfoPlugin().androidInfo;

      name = androidDeviceInfo.model;
      osType = OSType.android;
      osVersion = androidDeviceInfo.version.release;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosDeviceInfo = await DeviceInfoPlugin().iosInfo;

      name = iosDeviceInfo.name;
      osType = OSType.ios;
      osVersion = iosDeviceInfo.systemVersion;
    } else {
      throw OSError('OS is not supported');
    }

    logger.fine('Device name: $name');
    logger.fine('Device osType: $osType');
    logger.fine('Device osVersion: $osVersion');

    // get package and device info
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    logger.fine('Device appVersion: $appVersion');
    logger.fine('Device buildNumber: $buildNumber');

    // update timezone
    String timezone = await FlutterNativeTimezone.getLocalTimezone();

    logger.fine('Device timezone: $timezone');

    return device.copyWith(
      name: name,
      osType: osType,
      osVersion: osVersion,
      appVersion: appVersion,
      buildNumber: buildNumber,
      timezone: timezone,
    );
  }

  @override
  Future<LocalDevice> updateTimezone(LocalDevice device) async {
    String timezone = await FlutterNativeTimezone.getLocalTimezone();

    return device.copyWith(timezone: timezone);
  }
}

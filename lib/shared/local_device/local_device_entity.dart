import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../constant_definition.dart';

/// Local device entity represent data of running device.
///
/// It's value should always be updated whenever the application started.
/// Except, the identifier.
///
/// Identifier is always created when the application running for the first time.
/// It won't be deleted unless the local storage is deleted or the application
/// is uninstalled (with default setting of deleting storage data).
class LocalDevice extends Equatable {
  /// UUID v4 of this device.
  ///
  /// Which means, each installed apps has unique identifier. This is useful
  /// to track whether a user has logged in in a new device or not.
  final String identifier;

  /// Device name
  final String name;

  /// Loaded from current app version
  final String appVersion;

  /// Loaded from current app build number
  final String buildNumber;

  /// Alternatively filled with device location.
  final double latitude;

  /// Alternatively filled with device location.
  final double longitude;

  /// Loaded from os type
  /// See [OSType] for available const
  final String osType;

  /// Loaded from os version
  final String osVersion;

  /// Loaded from device timezone
  final String timezone;

  /// Disable using this class without initializing identifier
  LocalDevice._({
    @required this.identifier,
    this.name,
    this.appVersion,
    this.buildNumber,
    this.latitude,
    this.longitude,
    this.osType,
    this.osVersion,
    this.timezone,
  }) : assert(identifier != null);

  /// Initiate local device but must provide identifier
  factory LocalDevice.init(String identifier) {
    return LocalDevice._(
      identifier: identifier,
    );
  }

  // Copy the data
  LocalDevice copyWith({
    String name,
    String appVersion,
    String buildNumber,
    double latitude,
    double longitude,
    String osType,
    String osVersion,
    String timezone,
  }) {
    return LocalDevice._(
      identifier: identifier,
      name: name ?? this.name,
      appVersion: appVersion ?? this.appVersion,
      buildNumber: buildNumber ?? this.buildNumber,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      osType: osType ?? this.osType,
      osVersion: osVersion ?? this.osVersion,
      timezone: timezone ?? this.timezone,
    );
  }

  @override
  List<Object> get props => [identifier];

  @override
  String toString() {
    return 'LocalDevice{identifier: $identifier, name: $name, appVersion: $appVersion, buildNumber: $buildNumber, latitude: $latitude, longitude: $longitude, osType: $osType, osVersion: $osVersion, timezone: $timezone}';
  }
}

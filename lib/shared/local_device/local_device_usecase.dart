import 'local_device_entity.dart';
import 'local_device_repository.dart';

class LocalDeviceUpdateTimezoneUseCase {
  final LocalDeviceRepository repository;

  LocalDeviceUpdateTimezoneUseCase(this.repository)
      : assert(repository != null);

  /// Update local device location data. Will throw error if permission is not
  /// accepted
  Future<LocalDevice> call(LocalDevice device) async {
    return await repository.updateTimezone(device);
  }
}

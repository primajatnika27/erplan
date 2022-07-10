import 'package:equatable/equatable.dart';

class DeviceEntity extends Equatable {
  final String macAddress;
  final String ipAddress;

  DeviceEntity({
    required this.macAddress,
    required this.ipAddress,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        macAddress,
        ipAddress,
      ];
}

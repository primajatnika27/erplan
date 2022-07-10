import 'package:equatable/equatable.dart';

class LanguageModel extends Equatable {
  final int version;
  final String url;

  LanguageModel({required this.version, required this.url});

  @override
  List<Object> get props => [version, url];

  /// dummy response
  factory LanguageModel.dummyLanguages() {
    return LanguageModel(
      version: 1,
      url:
          "https://drive.google.com/u/0/uc?id=1En7vb0nszsKIz4-9A9--7N0_qmczPoMh&export=download",
    );
  }
}

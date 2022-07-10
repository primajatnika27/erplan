import '../../data/model/core/language_model.dart';

abstract class LanguageRepositoryRemote {
  Future<LanguageModel> get();
}

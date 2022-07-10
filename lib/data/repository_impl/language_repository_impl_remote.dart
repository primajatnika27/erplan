import '../../domain/repository/language_repository_remote.dart';
import '../model/core/language_model.dart';

class LanguageRepositoryImplRemote extends LanguageRepositoryRemote {
  @override
  Future<LanguageModel> get() async {
    await Future.delayed(Duration(seconds: 3));
    return LanguageModel.dummyLanguages();
  }
}

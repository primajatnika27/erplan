import 'package:flutter_modular/flutter_modular.dart';

import '../presentation/login/page.dart';
import '../presentation/registration/page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/login',
          child: (_, args) => AuthLoginPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/register',
          child: (_, args) => AuthRegistrationPage(),
          transition: TransitionType.rightToLeft,
        ),
      ];
}

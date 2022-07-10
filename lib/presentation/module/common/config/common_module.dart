import 'package:flutter_modular/flutter_modular.dart';

import '../presentatiton/splash/page.dart';

class CommonModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => SplashPage(),
          transition: TransitionType.rightToLeft,
        ),
      ];
}

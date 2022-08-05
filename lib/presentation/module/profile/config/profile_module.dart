import 'package:flutter_modular/flutter_modular.dart';

import '../presentation/page.dart';

class ProfileModule extends Module {
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => [];

  @override
  // TODO: implement routes
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => ProfilePage(),
          transition: TransitionType.rightToLeft,
        ),
      ];
}

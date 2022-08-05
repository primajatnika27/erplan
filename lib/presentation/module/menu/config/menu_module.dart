import 'package:flutter_modular/flutter_modular.dart';

import '../presentation/employee/page.dart';
import '../presentation/leaves/page.dart';
import '../presentation/leaves/presentation/add_leaves.dart';
import '../presentation/main_menu/page.dart';

class MenuModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => MainMenuPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/employee',
          child: (_, args) => EmployeeMenuPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/leaves',
          child: (_, args) => LeavesMenuPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/leaves/add',
          child: (_, args) => AddLeavesPage(),
          transition: TransitionType.downToUp,
        ),
      ];
}

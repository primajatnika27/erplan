import 'package:flutter_modular/flutter_modular.dart';

import '../../../../data/repository_impl/employee_repository_impl.dart';
import '../../../../domain/repository/employee_repository.dart';
import '../../../core/app.dart';
import '../presentation/employee/bloc.dart';
import '../presentation/employee/page.dart';
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
      ];
}

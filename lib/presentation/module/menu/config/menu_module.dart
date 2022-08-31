import 'package:flutter_modular/flutter_modular.dart';

import '../presentation/approval/approval_detail/page.dart';
import '../presentation/approval/page.dart';
import '../presentation/employee/page.dart';
import '../presentation/employee/presentation/create_employee/page.dart';
import '../presentation/employee/presentation/detail_employee/page.dart';
import '../presentation/leaves/page.dart';
import '../presentation/leaves/presentation/list_leave/page.dart';
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
          '/create/employee',
          child: (_, args) => CreateEmployeePage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/detail/employee',
          child: (_, args) => DetailEmployeePage(entity: args.data),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/list/leaves',
          child: (_, args) => ListLeavePage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/leaves',
          child: (_, args) => LeavesMenuPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/approval',
          child: (_, args) => ApprovalPage(),
          transition: TransitionType.rightToLeft,
        ),
        ChildRoute(
          '/approval/details',
          child: (_, args) => ApprovalDetailPage(entity: args.data),
          transition: TransitionType.rightToLeft,
        ),
      ];
}

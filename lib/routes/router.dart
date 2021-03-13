import 'package:auto_route/auto_route_annotations.dart';
import 'package:horizon_project_management/ui/edit_project_page.dart';
import 'package:horizon_project_management/ui/edit_task_page.dart';
import 'package:horizon_project_management/ui/home_page.dart';
import 'package:horizon_project_management/ui/login_page.dart';
import 'package:horizon_project_management/ui/project_details_page.dart';
import 'package:horizon_project_management/ui/splash_screen.dart';
import 'package:horizon_project_management/ui/edit_employee_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashScreen, initial: true, name: "InitialRoute"),
    MaterialRoute(page: HomePage, initial: false),
    MaterialRoute(page: LoginPage, initial: false),
    MaterialRoute(page: ProjectDetailsPage, initial: false),
    MaterialRoute(page: EditProjectPage, initial: false),
    MaterialRoute(page: EditTaskPage, initial: false),
    MaterialRoute(page: EditEmployeePage, initial: false),

    // if you want to add new page, you have to add new entry in here and run the following code in terminal
    // flutter packages pub run build_runner build


  ],
)
class $NewRouter {
}
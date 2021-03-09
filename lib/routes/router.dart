import 'package:auto_route/auto_route_annotations.dart';
import 'package:horizon_project_management/ui/home_page.dart';
import 'package:horizon_project_management/ui/login_page.dart';
import 'package:horizon_project_management/ui/splash_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashScreen, initial: true, name: "InitialRoute"),
    MaterialRoute(page: HomePage, initial: false),
    MaterialRoute(page: LoginPage, initial: false),
  ],
)
class $NewRouter {
}
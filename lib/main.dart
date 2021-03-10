import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horizon_project_management/routes/router.gr.dart';
import 'package:horizon_project_management/ui/home_page.dart';
import 'package:horizon_project_management/ui/splash_screen.dart';
import 'package:horizon_project_management/values/colors.dart';

// this must be a top-level function

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  static const String _title = 'Insight';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: SplashScreen(),
      onGenerateRoute: NewRouter(),
      builder: ExtendedNavigator.builder(
        router: NewRouter(
        ),
        builder: (context, extendedNav) => Theme(
          data: ThemeData(
            //fontFamily: "Rubik",
            primaryColor: AppColors.MAIN_COLOR,
            primaryColorLight: AppColors.LIGHT_MAIN_COLOR,
            splashColor: AppColors.LIGHT_MAIN_COLOR,
            accentColor: AppColors.LIGHT_MAIN_COLOR,
            buttonColor: AppColors.MAIN_COLOR,
            brightness: Brightness.light,
            fontFamily: 'Roboto',
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0)),

          ),
          child: extendedNav,
        ),
      ),
    );
  }

}
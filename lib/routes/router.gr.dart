// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/project_model.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';
import '../ui/change_status_page.dart';
import '../ui/edit_employee_page.dart';
import '../ui/edit_project_page.dart';
import '../ui/edit_task_page.dart';
import '../ui/home_page.dart';
import '../ui/login_page.dart';
import '../ui/project_details_page.dart';
import '../ui/splash_screen.dart';

class Routes {
  static const String InitialRoute = '/';
  static const String homePage = '/home-page';
  static const String loginPage = '/login-page';
  static const String projectDetailsPage = '/project-details-page';
  static const String editProjectPage = '/edit-project-page';
  static const String editTaskPage = '/edit-task-page';
  static const String editEmployeePage = '/edit-employee-page';
  static const String changeStatusPage = '/change-status-page';
  static const all = <String>{
    InitialRoute,
    homePage,
    loginPage,
    projectDetailsPage,
    editProjectPage,
    editTaskPage,
    editEmployeePage,
    changeStatusPage,
  };
}

class NewRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.InitialRoute, page: SplashScreen),
    RouteDef(Routes.homePage, page: HomePage),
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(Routes.projectDetailsPage, page: ProjectDetailsPage),
    RouteDef(Routes.editProjectPage, page: EditProjectPage),
    RouteDef(Routes.editTaskPage, page: EditTaskPage),
    RouteDef(Routes.editEmployeePage, page: EditEmployeePage),
    RouteDef(Routes.changeStatusPage, page: ChangeStatusPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    HomePage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomePage(),
        settings: data,
      );
    },
    LoginPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginPage(),
        settings: data,
      );
    },
    ProjectDetailsPage: (data) {
      final args = data.getArgs<ProjectDetailsPageArguments>(
        orElse: () => ProjectDetailsPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProjectDetailsPage(
          key: args.key,
          project: args.project,
        ),
        settings: data,
      );
    },
    EditProjectPage: (data) {
      final args = data.getArgs<EditProjectPageArguments>(
        orElse: () => EditProjectPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditProjectPage(
          key: args.key,
          project: args.project,
        ),
        settings: data,
      );
    },
    EditTaskPage: (data) {
      final args = data.getArgs<EditTaskPageArguments>(
        orElse: () => EditTaskPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditTaskPage(
          key: args.key,
          task: args.task,
          project: args.project,
        ),
        settings: data,
      );
    },
    EditEmployeePage: (data) {
      final args = data.getArgs<EditEmployeePageArguments>(
        orElse: () => EditEmployeePageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditEmployeePage(
          key: args.key,
          user: args.user,
        ),
        settings: data,
      );
    },
    ChangeStatusPage: (data) {
      final args = data.getArgs<ChangeStatusPageArguments>(
        orElse: () => ChangeStatusPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChangeStatusPage(
          key: args.key,
          project: args.project,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ProjectDetailsPage arguments holder class
class ProjectDetailsPageArguments {
  final Key key;
  final Project project;
  ProjectDetailsPageArguments({this.key, this.project});
}

/// EditProjectPage arguments holder class
class EditProjectPageArguments {
  final Key key;
  final Project project;
  EditProjectPageArguments({this.key, this.project});
}

/// EditTaskPage arguments holder class
class EditTaskPageArguments {
  final Key key;
  final Task task;
  final Project project;
  EditTaskPageArguments({this.key, this.task, this.project});
}

/// EditEmployeePage arguments holder class
class EditEmployeePageArguments {
  final Key key;
  final User user;
  EditEmployeePageArguments({this.key, this.user});
}

/// ChangeStatusPage arguments holder class
class ChangeStatusPageArguments {
  final Key key;
  final Project project;
  ChangeStatusPageArguments({this.key, this.project});
}

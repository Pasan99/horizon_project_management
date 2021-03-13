import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:horizon_project_management/models/constants.dart';
import 'package:horizon_project_management/routes/router.gr.dart';
import 'package:horizon_project_management/ui/common/shimmers/shimmer_list_type_1.dart';
import 'package:horizon_project_management/utilties/user_helper.dart';
import 'package:horizon_project_management/values/colors.dart';
import 'package:horizon_project_management/viewmodels/employee_fragment_viewmodel.dart';

import 'package:provider/provider.dart';

class EmployeesFragment extends StatefulWidget {
  @override
  _EmployeesFragmentState createState() => _EmployeesFragmentState();
}

class _EmployeesFragmentState extends State<EmployeesFragment> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmployeeFragmentViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Employees"),
          actions: [
            Consumer<EmployeeFragmentViewModel>(
                builder: (context, model, child) {
                  return GestureDetector(
                    onTap: (){
                      model.getEmployees();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Icon(Icons.refresh),
                    ),
                  );
                }
            ),
            UserHelper().getCachedUser() != null
                && UserHelper().getCachedUser().role == RoleTypes.ADMIN ? ElevatedButton.icon(
              onPressed: (){
                ExtendedNavigator.of(context).push(
                    Routes.editEmployeePage,
                    arguments: EditEmployeePageArguments(
                    )
                );
              },
              icon: Icon(Icons.add), label: Text("New Employee"),
            ) : Container(),
          ],
        ),
        body: SafeArea(
          child: Consumer<EmployeeFragmentViewModel>(
              builder: (context, model, child) {
                return model.users != null ? ListView(
                  children: model.users.map<Widget>((user) {
                    return GestureDetector(
                      onTap: (){
                        if (UserHelper().getCachedUser() != null
                            && UserHelper().getCachedUser().role == RoleTypes.ADMIN) {
                          ExtendedNavigator.of(context).push(
                              Routes.editEmployeePage,
                              arguments: EditEmployeePageArguments(user: user));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 6),
                        child: Material(
                          borderRadius: BorderRadius.circular(4.0),
                          elevation: 2,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: ClipOval(
                                        child: Container(
                                          child: Center(
                                            child: Text(
                                              user.name.substring(0,1).toUpperCase(),
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.TEXT_WHITE),
                                            ),
                                          ),
                                          color: user.color,
                                          width: 40, height: 40,)
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            user.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            user.email,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(height: 4,),
                                      Row(
                                        children: [
                                          Text(
                                            user.role,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12
                                            ),
                                          ),
                                        ],
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ) : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ShimmerListType1(),
                );
              }
          ),
        ),
      ),
    );
  }
}

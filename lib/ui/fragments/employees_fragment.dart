import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:horizon_project_management/routes/router.gr.dart';
import 'package:horizon_project_management/ui/common/shimmers/shimmer_list_type_1.dart';
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
            ElevatedButton.icon(
              onPressed: (){
                ExtendedNavigator.of(context).push(
                    Routes.editEmployeePage,
                    arguments: EditEmployeePageArguments(
                    )
                );
              },
              icon: Icon(Icons.add), label: Text("New Employee"),
            ),
          ],
        ),
        body: SafeArea(
          child: Consumer<EmployeeFragmentViewModel>(
              builder: (context, model, child) {
                return model.users != null ? ListView(
                  children: model.users.map<Widget>((user) {
                    return GestureDetector(
                      onTap: (){
                        ExtendedNavigator.of(context).push(Routes.editEmployeePage,
                            arguments: EditEmployeePageArguments(user:user));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 6),
                        child: Material(
                          borderRadius: BorderRadius.circular(4.0),
                          elevation: 2,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        user.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24
                                        ),
                                      ),
                                      Text(
                                        user.contact,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
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
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12
                                        ),
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

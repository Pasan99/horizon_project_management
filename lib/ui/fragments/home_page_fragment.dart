import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:horizon_project_management/models/constants.dart';
import 'package:horizon_project_management/routes/router.gr.dart';
import 'package:horizon_project_management/ui/common/shimmers/shimmer_list_type_1.dart';
import 'package:horizon_project_management/utilties/user_helper.dart';
import 'package:horizon_project_management/viewmodels/home_fragment_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePageFragment extends StatefulWidget {
  @override
  _HomePageFragmentState createState() => _HomePageFragmentState();
}

class _HomePageFragmentState extends State<HomePageFragment> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeFragmentViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Projects"),
          actions: [
            Consumer<HomeFragmentViewModel>(
              builder: (context, model, child) {
                return GestureDetector(
                  onTap: (){
                    model.getProjects();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Icon(Icons.refresh),
                  ),
                );
              }
            ),
            UserHelper().getCachedUser() != null
                && UserHelper().getCachedUser().role == RoleTypes.MANAGER  ? ElevatedButton.icon(
                onPressed: (){
                  ExtendedNavigator.of(context).push(
                      Routes.editProjectPage,
                    arguments: EditProjectPageArguments(
                    )
                  );
                },
                icon: Icon(Icons.add), label: Text("New Project"),
            )  : Container(),
          ],
        ),
        body: SafeArea(
          child: Consumer<HomeFragmentViewModel>(
              builder: (context, model, child) {
                return model.projects != null ? ListView(
                  children: model.projects.map<Widget>((project) {
                    return GestureDetector(
                      onTap: (){
                        ExtendedNavigator.of(context).push(Routes.projectDetailsPage,
                            arguments: ProjectDetailsPageArguments(project: project));
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
                                        project.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24
                                        ),
                                      ),
                                      Text(
                                        project.status,
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
                                        project.client,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(height: 4,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          "LKR " + project.cost.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14
                                          ),
                                        ),
                                        Text(
                                          "   ( managed by " + project.manager.name + " )",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    child: Divider(
                                      height: 1,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Start : " + project.startDate.toDate().toString().substring(0,10),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12
                                        ),
                                      ),
                                      Text(
                                        "End : " + project.endDate.toDate().toString().substring(0,10),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(height: 12,)
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

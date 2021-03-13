import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:horizon_project_management/models/constants.dart';
import 'package:horizon_project_management/models/project_model.dart';
import 'package:horizon_project_management/routes/router.gr.dart';
import 'package:horizon_project_management/ui/common/shimmers/shimmer_list_type_1.dart';
import 'package:horizon_project_management/utilties/user_helper.dart';
import 'package:horizon_project_management/values/colors.dart';
import 'package:horizon_project_management/viewmodels/project_details_page_viewmodel.dart';
import 'package:provider/provider.dart';

class ProjectDetailsPage extends StatefulWidget {
  final Project project;

  const ProjectDetailsPage({Key key, this.project}) : super(key: key);

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProjectDetailsPageViewModel(widget.project),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.MAIN_COLOR,
          label: Text(
            "Add",
            style: TextStyle(color: AppColors.TEXT_WHITE),
          ),
          icon: Icon(
            Icons.add,
            color: AppColors.TEXT_WHITE,
          ),
          onPressed: () {
            ExtendedNavigator.of(context).push(Routes.editTaskPage,
                arguments:
                    EditTaskPageArguments(project: widget.project, task: null));
          },
        ),
        appBar: AppBar(
          title: Text(widget.project.name),
          actions: [
            Consumer<ProjectDetailsPageViewModel>(
                builder: (context, model, child) {
              return GestureDetector(
                  onTap: () {
                    model.getTasks();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(Icons.refresh),
                  ));
            }),
            UserHelper().getCachedUser() != null &&
                    UserHelper().getCachedUser().role == RoleTypes.MANAGER
                ? GestureDetector(
                    onTap: () {
                      ExtendedNavigator.of(context).push(Routes.changeStatusPage,
                          arguments: ChangeStatusPageArguments(
                              project: widget.project));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(Icons.warning_outlined),
                    ))
                : Container(),
            UserHelper().getCachedUser() != null &&
                    UserHelper().getCachedUser().role == RoleTypes.MANAGER
                ? GestureDetector(
                    onTap: () {
                      ExtendedNavigator.of(context).push(Routes.editProjectPage,
                          arguments: EditProjectPageArguments(
                              project: widget.project));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16, left: 8),
                      child: Icon(Icons.edit),
                    ))
                : Container(),
          ],
        ),
        body: SafeArea(
          child: Consumer<ProjectDetailsPageViewModel>(
              builder: (context, model, child) {
            return model.tasks != null
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tasks",
                              style: TextStyle(fontSize: 24),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        // labelStyle: textStyle,
                                        hintText: 'Employee',
                                        labelText: "Employee",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0))),
                                    isEmpty:
                                        model.currentSelectedEmployee == '',
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: model.currentSelectedEmployee,
                                        isDense: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            model.currentSelectedEmployee =
                                                newValue;
                                            state.didChange(newValue);
                                            model.filterTasks();
                                          });
                                        },
                                        items: model.employees.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value.id,
                                            child: Text(value.name),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: model.tasks.map<Widget>((task) {
                            return GestureDetector(
                              onTap: () {
                                ExtendedNavigator.of(context).push(
                                    Routes.editTaskPage,
                                    arguments: EditTaskPageArguments(
                                        project: widget.project, task: task));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 6),
                                child: Material(
                                  borderRadius: BorderRadius.circular(4.0),
                                  elevation: 2,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        3) *
                                                    1.6,
                                                child: Text(
                                                  task.title,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Text(
                                                task.status,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  task.description,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 12,
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Row(
                                              children: [
                                                ClipOval(
                                                    child: Container(
                                                  child: Center(
                                                    child: Text(
                                                      task.assignee.name
                                                          .substring(0, 1)
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  color: task.assignee.color,
                                                  width: 40,
                                                  height: 40,
                                                )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child:
                                                      Text(task.assignee.name),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 12,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ShimmerListType1(),
                  );
          }),
        ),
      ),
    );
  }
}

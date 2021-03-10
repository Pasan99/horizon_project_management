import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:horizon_project_management/models/constants.dart';
import 'package:horizon_project_management/models/project_model.dart';
import 'package:horizon_project_management/models/task_model.dart';
import 'package:horizon_project_management/viewmodels/edit_task_page_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  final Project project;

  const EditTaskPage({Key key, this.task, this.project}) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? "New Task" : "Edit Task"),),
      body: ChangeNotifierProvider(
        create: (context) => EditTaskPageViewModel(widget.task, widget.project),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Consumer<EditTaskPageViewModel>(
                  builder: (context, model, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: 24,),
                        FormField<String>(
                          validator: (value) {
                            if (model.currentSelectedStatus == null || model.currentSelectedStatus == '') {
                              return 'Project Manager cannot be empty';
                            }
                            return null;
                          },
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                // labelStyle: textStyle,
                                  hintText: 'Task Status',
                                  labelText: "Task Status",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                              ),
                              isEmpty: model.currentSelectedStatus == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: model.currentSelectedStatus,
                                  isDense: true,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      model.currentSelectedStatus = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: model.statuses.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        Container(height: 8,),
                        TextFormField(
                          controller: model.titleController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Task Title cannot be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Task Title',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                          ),
                          // initialValue: widget.project == null ? "" : widget.project.name,
                        ),
                        Container(height: 8,),
                        TextFormField(
                          controller: model.descriptionController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Task Description cannot be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Task Description',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                          ),
                          // initialValue: widget.project == null ? "" : widget.project.name,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Divider(height: 1,),
                        ),
                        Container(height: 8,),
                        FormField<String>(
                          validator: (value) {
                            if (model.currentSelectedAssignee == null || model.currentSelectedAssignee == '') {
                              return 'Assignee cannot be empty';
                            }
                            return null;
                          },
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                // labelStyle: textStyle,
                                  hintText: 'Assignee',
                                  labelText: "Assignee",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                              ),
                              isEmpty: model.currentSelectedAssignee == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: model.currentSelectedAssignee,
                                  isDense: true,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      model.currentSelectedAssignee = newValue;
                                      state.didChange(newValue);
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
                        Container(height: 8,),
                        Consumer<EditTaskPageViewModel>(
                            builder: (context, model, child) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: ElevatedButton.icon(
                                  onPressed: isEnabled ?() async {
                                    // Validate returns true if the form is valid, or false
                                    // otherwise.
                                    if (_formKey.currentState.validate()) {
                                      // If the form is valid, display a Snackbar.
                                      setState(() {
                                        isEnabled = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text('Processing Data')));
                                      bool result = await model.saveTask();
                                      if (result){
                                        ExtendedNavigator.of(context).pop();
                                      }
                                      else{
                                        setState(() {
                                          isEnabled = true;
                                        });
                                      }
                                    }
                                  } : null,
                                  label: Text("Save Task"), icon: Icon(Icons.save),
                                ),
                              );
                            }
                        ),
                      ],
                    );
                  }
              ),
            ),
          ),
        ),
      ),
    );
  }
}

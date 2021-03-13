import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:horizon_project_management/values/colors.dart';
import 'package:horizon_project_management/viewmodels/edit_project_page_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:horizon_project_management/models/project_model.dart';
import 'package:provider/provider.dart';

class EditProjectPage extends StatefulWidget {
  final Project project;

  const EditProjectPage({Key key, this.project}) : super(key: key);

  @override
  _EditProjectPageState createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.project == null ? "New Projects" : "Edit Project"),),
      body: ChangeNotifierProvider(
        create: (context) => EditProjectPageViewModel(widget.project),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Consumer<EditProjectPageViewModel>(
                builder: (context, model, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 16,),
                      TextFormField(
                        controller: model.nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Project Name cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Project Name',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                        ),
                        // initialValue: widget.project == null ? "" : widget.project.name,
                      ),
                      Container(height: 8,),
                      DateTimeField(
                        format: format,
                        controller: model.startDateController,
                        validator: (value) {
                          if (value == null) {
                            return 'Start Date cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Start Date',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                        ),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                      Container(height: 8,),
                      DateTimeField(
                        format: format,
                        validator: (value) {
                          if (value == null) {
                            return 'End Date cannot be empty';
                          }
                          return null;
                        },
                        controller: model.endDateController,
                        decoration: InputDecoration(
                            labelText: 'End Date',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                        ),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                      Container(height: 8,),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Project Cost cannot be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: model.costController,
                        decoration: InputDecoration(
                            labelText: 'Project Cost',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                        ),
                        // initialValue: widget.project == null ? "0" : widget.project.cost.toString(),
                      ),
                      Container(height: 8,),
                      TextFormField(
                        controller: model.clientController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Project Client cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Project Client (Name)',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Divider(height: 1,),
                      ),
                      Container(height: 8,),
                      FormField<String>(
                        validator: (value) {
                          if (model.currentSelectedManager == null || model.currentSelectedManager == '') {
                            return 'Project Manager cannot be empty';
                          }
                          return null;
                        },
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              // labelStyle: textStyle,
                                hintText: 'Project Manager',
                                labelText: "Project Manager",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                            ),
                            isEmpty: model.currentSelectedManager == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: model.currentSelectedManager,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    model.currentSelectedManager = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: model.managers.map((value) {
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
                      Consumer<EditProjectPageViewModel>(
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
                                  bool result = await model.saveProject();
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
                              label: Text("Save Project"), icon: Icon(Icons.save),
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

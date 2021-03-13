import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:flutter/material.dart';
import 'package:horizon_project_management/models/constants.dart';
import 'package:horizon_project_management/models/user_model.dart';

import 'package:horizon_project_management/viewmodels/edit_employee_page_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:intl/intl.dart';
import 'package:horizon_project_management/utilties/user_helper.dart';
import 'package:provider/provider.dart';

class EditEmployeePage extends StatefulWidget {
  final User user;

  const EditEmployeePage({Key key, this.user}) : super(key: key);

  @override
  _EditEmployeePageState createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");

  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user == null ? "New Employee" : "Edit Employee"),),
      body: ChangeNotifierProvider(
        create: (context) => EditEmployeePageViewModel(widget.user),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Consumer<EditEmployeePageViewModel>(
                builder: (context, model, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 16,),
                      TextFormField(
                        controller: model.nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Employee Name cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Employee Name',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                        ),
                        // initialValue: widget.project == null ? "" : widget.project.name,
                      ),
                      Container(height: 16,),
                      FormField<String>(
                        validator: (value) {
                          if (model.currentSelectedRole == null || model.currentSelectedRole == '') {
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
                            isEmpty: model.currentSelectedRole == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isDense: true,
                                value: model.currentSelectedRole,
                                onChanged:  (String newValue) {
                                  setState(() {
                                    model.currentSelectedRole = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: [RoleTypes.EMPLOYEE, RoleTypes.MANAGER, RoleTypes.ADMIN].map((value) {
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: model.emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                        ),
                        // initialValue: widget.project == null ? "0" : widget.project.cost.toString(),
                      ),
                      Container(height: 8,),
                      TextFormField(
                        controller: model.contactController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Project Client cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Contact',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                        ),
                      ),
                    Container(height: 8,),
                    widget.user == null ? TextFormField(

                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        obscureText: true,
                      controller: model.passwordController,
                        decoration: InputDecoration(
                            labelText: 'Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                        ),
                      ) : Container(),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Divider(height: 1,),
                      ),
                      Consumer<EditEmployeePageViewModel>(
                        builder: (context, model, child) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: isEnabled ?() async {
                                    // Validate returns true if the form is valid, or false
                                    // otherwise.
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        isEnabled = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text('Processing Data')));


                                      Auth.UserCredential userCredential;
                                      if(widget.user==null){
                                        userCredential= await UserHelper().registerWithPassword(model.emailController.text,model.passwordController.text);

                                      }
                                      bool result = await model.saveUser(userCredential);
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
                                  label: Text("Save Employee"), icon: Icon(Icons.save),
                                ),
                                Container(width: 12,),
                                ElevatedButton.icon(
                                  onPressed: isEnabled ?() async {
                                    // Validate returns true if the form is valid, or false
                                    // otherwise.
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        isEnabled = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text('Deleting User')));

                                      bool result = await model.deleteUser();
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
                                  label: Text("Delete Employee"), icon: Icon(Icons.delete),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.redAccent,
                                  ),
                                ),
                              ],
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

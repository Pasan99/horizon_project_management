import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:horizon_project_management/models/constants.dart';
import 'package:horizon_project_management/viewmodels/change_status_page_viewmodel.dart';
import 'package:horizon_project_management/viewmodels/edit_project_page_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:horizon_project_management/models/project_model.dart';
import 'package:provider/provider.dart';

class ChangeStatusPage extends StatefulWidget {
  final Project project;

  const ChangeStatusPage({Key key, this.project}) : super(key: key);

  @override
  _ChangeStatusPageState createState() => _ChangeStatusPageState();
}

class _ChangeStatusPageState extends State<ChangeStatusPage> {
  final _formKey = GlobalKey<FormState>();
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change Project Status"),),
      body: ChangeNotifierProvider(
        create: (context) => ChangeStatusPageViewModel(widget.project),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Consumer<ChangeStatusPageViewModel>(
                  builder: (context, model, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: 18,),
                        FormField<String>(
                          validator: (value) {
                            if (model.currentStatus == null || model.currentStatus == '') {
                              return 'Project status cannot be empty';
                            }
                            return null;
                          },
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                // labelStyle: textStyle,
                                  hintText: 'Project Status',
                                  labelText: "Project Status",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                              ),
                              isEmpty: model.currentStatus == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: model.currentStatus,
                                  isDense: true,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      model.currentStatus = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: [ProjectStatus.ONGOING, ProjectStatus.ONHOLD, ProjectStatus.CANCELLED, ProjectStatus.FINISHED].map((value) {
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
                        model.currentStatus == ProjectStatus.ONHOLD ?  TextFormField(
                          controller: model.onHoldReasonController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'On Hold reason cannot be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'On Hold reason',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))
                          ),
                          // initialValue: widget.project == null ? "" : widget.project.name,
                        ) : Container(),
                        Padding(
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
                                    .showSnackBar(SnackBar(content: Text('Saving Data')));
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
                            label: Text("Save Status"), icon: Icon(Icons.save),
                          ),
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

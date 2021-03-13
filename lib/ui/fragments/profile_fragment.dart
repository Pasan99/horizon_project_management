import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:horizon_project_management/main.dart';
import 'package:horizon_project_management/models/user_model.dart';
import 'package:horizon_project_management/routes/router.gr.dart';
import 'package:horizon_project_management/viewmodels/employee_fragment_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:horizon_project_management/utilties/user_helper.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';
void main()=>runApp(MyApp());
class ProfileFragment extends StatefulWidget {

  @override
  _ProfileFragmentState createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  // debugPrint(results );

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  //User currentUser =   FirebaseAuth.instance.currentUser;
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),

        actions: [
           ElevatedButton.icon(
            onPressed: (){
              UserHelper().logout(context);
            }
            ,
             icon: Icon(Icons.logout), label: Text("Logout"),
          ),
        ],
      ),

        body: new Container(
          color: Colors.white,

          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[

                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                           'Personal Information',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                      _status ? _getEditIcon() : new Container(),
                                      ],
                                    )
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Name',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField (
                                        decoration: const InputDecoration(
                                          hintText: "Enter Your Name",
                                        ),
                                      readOnly: true,
                                      onChanged: null,
                                      // controller: nameController,
                                      initialValue: UserHelper().getCachedUser().name,
                                      enabled: !_status,
                                      autofocus: !_status,

                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                        "Email",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        readOnly: true,
                                        initialValue: UserHelper().getCachedUser().email,
                                        // controller: emailController,
                                        decoration: const InputDecoration(

                                            hintText: "Enter Email ID"),
                                     enabled: !_status,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Role',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        readOnly: true,
                                        initialValue: UserHelper().getCachedUser().role,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Mobile Number"),
                                     enabled: !_status,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'New Password',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new   TextFormField(
                                        controller:passwordController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Password is required';
                                          }
                                          if (value != reEnterPasswordController.text){
                                            return "Passwords did not match";
                                          }
                                          return null;
                                        },
                                        enabled: !_status,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Enter the valid password',

                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Re-enter New Password',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new   TextFormField(
                                        controller:reEnterPasswordController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Password is required';
                                          }
                                          if (value != passwordController.text){
                                            return "Passwords did not match";
                                          }
                                          return null;
                                        },
                                        enabled: !_status,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Enter the valid password',

                                        ),
                                      ),
                                    ),
                                  ],
                                )),

                            !_status ? _getActionButtons() : new Container(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));


  }
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate()) {
                          print(passwordController.text);
                          UserHelper().changePassword(passwordController.text);
                          _status = true;
                          FocusScope.of(context).requestFocus(new FocusNode());
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                              SnackBar(content: Text(
                                  'Data Saved Successfully')));
                        }
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}


import 'package:flutter/material.dart';

class EmployeesFragment extends StatefulWidget {
  @override
  _EmployeesFragmentState createState() => _EmployeesFragmentState();
}

class _EmployeesFragmentState extends State<EmployeesFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Employees"),),
      body: Container(),
    );
  }
}

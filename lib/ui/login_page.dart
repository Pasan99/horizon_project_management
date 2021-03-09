import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:horizon_project_management/routes/router.gr.dart';
import 'package:horizon_project_management/utilties/user_helper.dart';
import 'package:horizon_project_management/values/colors.dart';
import 'package:horizon_project_management/viewmodels/login_page_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoginButtonShown = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => LoginPageViewModel(context),
        child: SafeArea(
          child: Container(
            color: AppColors.BACK_WHITE_COLOR,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 30,
                    color: AppColors.BACK_WHITE_COLOR,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 80),
                          child: Image.asset(
                            "assets/images/illus_login.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 24,
                    left: 32,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset(
                        "assets/images/ic_logo.png",
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 114,
                    left: 38,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Project Manager',
                          style: TextStyle(
                              color: AppColors.MAIN_COLOR,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        )),
                  ),
                  Positioned(
                    top: 130,
                    left: 38,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'by Horizon Pvt Ltd',
                          style: TextStyle(
                              color: AppColors.MAIN_COLOR,
                              fontWeight: FontWeight.w300,
                              fontSize: 12),
                        )),
                  ),
                  Consumer<LoginPageViewModel>(
                      builder: (context, model, child) {
                        return Positioned(
                          top: (MediaQuery.of(context).size.width / 2) + 40,
                          left: 24,
                          right: 24,
                          child: Container(
                            child: Column(
                              children: [
                                Material(
                                  elevation: 12,
                                  color: AppColors.BACK_WHITE_COLOR,
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 32, horizontal: 32),
                                    child: Form(
                                        key: _formKey,
                                        child: Column(children: <Widget>[
                                          TextFormField(
                                            obscureText: false,
                                            controller: _emailController,
                                            decoration: InputDecoration(
                                                labelText: 'Email',
                                                hintStyle: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12),
                                                icon: Icon(Icons.email)),
                                            // The validator receives the text that the user has entered.
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Email Cannot be Empty';
                                              }
                                              return null;
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: TextFormField(
                                              obscureText: true,
                                              controller: _passwordController,
                                              decoration: InputDecoration(
                                                icon: Icon(Icons.vpn_key),
                                                labelText: 'Password',
                                              ),
                                              // The validator receives the text that the user has entered.
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Password Cannot be Empty';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ])),
                                  ),
                                ),
                                Container(
                                  height: 12,
                                ),
                                isLoginButtonShown ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 8),
                                  child: ButtonTheme(
                                    height: 50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    minWidth:
                                    MediaQuery.of(context).size.width - 50,
                                    child: OutlineButton.icon(
                                      icon: Icon(
                                        Icons.login,
                                        color: AppColors.MAIN_COLOR,
                                      ),
                                      borderSide:
                                      BorderSide(color: AppColors.MAIN_COLOR),
                                      splashColor: AppColors.LIGHT_MAIN_COLOR,
                                      label: Padding(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 24),
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: AppColors.MAIN_COLOR),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          setState(() {
                                            isLoginButtonShown = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                              SnackBar(content: Text(
                                                  'Processing Data')));
                                          bool a = await model.loginUser(
                                              email: _emailController.text,
                                              password: _passwordController
                                                  .text);
                                          SnackBar(
                                              content: Text(
                                                  a.toString()));
                                          if (a) {
                                            await UserHelper().renewUser();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Successfully Logged In')));
                                            ExtendedNavigator.of(context)
                                                .popAndPush(Routes.homePage);
                                          }
                                          else {
                                            setState(() {
                                              isLoginButtonShown = true;
                                            });
                                          }
                                        }
                                        },
                                      color: AppColors.MAIN_COLOR,
                                    ),
                                  ),
                                ) : Container(
                                  height: 50,
                                  child: SpinKitFadingCircle(
                                    size: 30,
                                    color: AppColors.MAIN_COLOR,
                                  ),
                                ),
                                Container(
                                  height: 12,
                                ),
                                Container(
                                  height: 24,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookie_twitter/src/appstate_container.dart';
import 'package:hookie_twitter/src/network/api_service.dart';
import 'package:hookie_twitter/src/service_locator.dart';
import 'package:hookie_twitter/src/utils/nav_service.dart';
import 'package:hookie_twitter/src/widgets/ibackground3.dart';
import 'package:hookie_twitter/src/widgets/ibox.dart';
import 'package:hookie_twitter/src/widgets/ibutton.dart';
import 'package:hookie_twitter/src/widgets/iinputField2.dart';
import 'package:hookie_twitter/src/widgets/iinputField2Password.dart';
import 'package:oktoast/oktoast.dart';

import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final editControllerName = TextEditingController();
  final editControllerPassword = TextEditingController();

  String name;
  String password;

  @override
  void dispose() {
    editControllerName.dispose();
    editControllerPassword.dispose();
    super.dispose();
  }

  _submit() async {
    if (name == null && password == null) {
      showToast(' Both fields are required');
    } else {
      EasyLoading.show(status: 'Logging you in');
      await sl.get<ApiService>().login(username: name, password: password).then(
        (result) {
          EasyLoading.dismiss();

          if (result == true) {
            sl.get<NavigatorService>().pushReplacementNamed('/home');
          } else {
            showToast(result);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: StateContainer.of(context).theme.colorBackground,
        body: Stack(
          children: <Widget>[
            IBackground4(
              width: 100.0.w,
              colorsGradient: StateContainer.of(context).theme.colorsGradient,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 10.0.h),
                width: 100.0.w,
                child: _body(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        sl.get<NavigatorService>().pushNamed('/register');
                      }, // needed
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 20),
                        child: Text(
                            "Don't have an account? Create", // ""Don't have an account? Create",",
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: StateContainer.of(context)
                                .theme
                                .text16boldWhite),
                      )),
                  InkWell(
                      onTap: () {
                        // _pressForgotPasswordButton();
                      }, // needed
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text("Forgot Password", // "Forgot password",
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: StateContainer.of(context)
                                .theme
                                .text16boldWhite),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, right: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            "Let's start with Login", // "Let's start with LogIn!"
            style: StateContainer.of(context).theme.text20boldWhite,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        IBox(
            color: StateContainer.of(context).theme.colorBackgroundDialog,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: IInputField2(
                      hint: "Username", // "Login"
                      icon: Icons.alternate_email,
                      onChangeText: (String value) {
                        setState(() {
                          name = value.trim();
                        });
                      },
                      colorDefaultText:
                          StateContainer.of(context).theme.colorPrimary,
                      colorBackground: StateContainer.of(context)
                          .theme
                          .colorBackgroundDialog,
                      controller: editControllerName,
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: IInputField2Password(
                    hint: "Password", // "Password"
                    icon: Icons.vpn_key,
                    onChangeText: (String value) {
                      setState(() {
                        password = value.trim();
                      });
                    },
                    colorDefaultText:
                        StateContainer.of(context).theme.colorPrimary,
                    colorBackground:
                        StateContainer.of(context).theme.colorBackgroundDialog,
                    controller: editControllerPassword,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: IButton(
                      textStyle:
                          StateContainer.of(context).theme.text16boldWhite,
                      text: 'Login',
                      color: StateContainer.of(context).theme.colorPrimary,
                      colorText: Colors.white,
                      pressButton: () {
                        _submit();
                      }),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            )),
      ],
    );
  }
}

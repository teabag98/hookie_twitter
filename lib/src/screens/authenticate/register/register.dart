import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookie_twitter/src/appstate_container.dart';
import 'package:hookie_twitter/src/common/theme.dart';
import 'package:hookie_twitter/src/network/api_service.dart';
import 'package:hookie_twitter/src/service_locator.dart';
import 'package:hookie_twitter/src/utils/nav_service.dart';
import 'package:hookie_twitter/src/widgets/iappBar.dart';
import 'package:hookie_twitter/src/widgets/ibackground3.dart';
import 'package:hookie_twitter/src/widgets/ibox.dart';
import 'package:hookie_twitter/src/widgets/ibutton.dart';

import 'package:hookie_twitter/src/widgets/iinputField2.dart';
import 'package:hookie_twitter/src/widgets/iinputField2Password.dart';
import 'package:oktoast/oktoast.dart';

import 'package:sizer/sizer.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController editControllerName = TextEditingController();
  final TextEditingController editControllerEmail = TextEditingController();
  final TextEditingController editControllerPassword1 = TextEditingController();
  final TextEditingController editControllerPassword2 = TextEditingController();
  final TextEditingController defaultLocation = TextEditingController();
  final TextEditingController editControllerPhone = TextEditingController();

  String dropdownValue = 'Gender';
  String genderVal = '0';

  _submit() async {
    if (editControllerName.value.text.isEmpty ||

        editControllerPassword1.value.text.isEmpty ||
        editControllerPassword2.value.text.isEmpty ||
        editControllerPhone.value.text.isEmpty) {
      showToast('All fields are required');
    } else if (editControllerPassword1.value.text.trim() !=
        editControllerPassword2.value.text.trim()) {
      showToast('Password must match');
    } else {
      EasyLoading.show(status: 'Registering your account');
      await sl
          .get<ApiService>()
          .register(
            email: editControllerEmail.value.text.trim(),
            password: editControllerPassword1.value.text.trim(),
            phone: editControllerPhone.value.text.trim(),
            username: editControllerName.value.text.trim(),
            gender: genderVal
          )
          .then(
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
  void dispose() {
    super.dispose();

    editControllerName.dispose();
    editControllerEmail.dispose();
    editControllerPhone.dispose();
    defaultLocation.dispose();
    editControllerPassword1.dispose();
    editControllerPassword2.dispose();
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
            IAppBar(context: context, text: "", color: Colors.white),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: 100.0.w,
                child: _body(),
              ),
            )
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
            "Create an Account!", // "Create an Account!"
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
                      icon: Icons.account_circle,
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
                  child: IInputField2(
                    hint: "E-mail Address", // "E-mail address",
                    icon: Icons.alternate_email,
                    colorDefaultText:
                        StateContainer.of(context).theme.colorPrimary,
                    colorBackground:
                        StateContainer.of(context).theme.colorBackgroundDialog,
                    controller: editControllerEmail,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: IInputField2(
                    hint: "Phone Number", // "Phone number"
                    icon: Icons.phone,
                    colorDefaultText:
                        StateContainer.of(context).theme.colorPrimary,
                    colorBackground:
                        StateContainer.of(context).theme.colorBackgroundDialog,
                    controller: editControllerPhone,
                    type: TextInputType.phone,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: AppThemeData.primary),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });

                if(dropdownValue == "Gender"){
                  genderVal = "0";
                }
                if(dropdownValue == "Male"){
                  genderVal = "1";
                }
                if(dropdownValue == "Female"){
                  genderVal = "2";
                }
              },
              items: <String>['Gender','Male','Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: IInputField2Password(
                      hint: "Password", // "Password"
                      icon: Icons.vpn_key,
                      colorDefaultText:
                          StateContainer.of(context).theme.colorPrimary,
                      colorBackground: StateContainer.of(context)
                          .theme
                          .colorBackgroundDialog,
                      controller: editControllerPassword1,
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: IInputField2Password(
                      hint: "Confirm Password", // "Confirm Password"
                      icon: Icons.vpn_key,
                      colorDefaultText:
                          StateContainer.of(context).theme.colorPrimary,
                      colorBackground: StateContainer.of(context)
                          .theme
                          .colorBackgroundDialog,
                      controller: editControllerPassword2,
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: IButton(
                      textStyle:
                          StateContainer.of(context).theme.text16boldWhite,
                      text: 'Create Account',
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








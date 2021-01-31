import 'package:flutter/material.dart';


class AppFoodRoute{

  Map<String, StatefulWidget> routes = {
    // "/onboard" : OnBoardingScreen(),
    // "/login" : LoginScreen(),
    // "/forgot" : ForgotScreen(),
    // "/createaccount" : CreateAccountScreen(),
    // // "/verifyphone" : VerifyPhoneNumberScreen(),
    // "/main" : MainScreen(),
    // "/notify" : NotificationScreen(),
    // "/language" : LanguageScreen(),
    // "/help" : HelpScreen(),
    // "/term" : TermOfServiceScreen(),
    // "/dishesdetails" : DishesDetailsScreen(),
    // "/restaurantdetails" : RestaurantDetailsScreen(),
    // "/categorydetails" : CategoryDetailsScreen(),
    // "/map" : MapScreen(),
    // "/delivery" : DeliveryScreen(),
    // "/payment" : PaymentScreen(),
    // "/orderdetails" : OrderDetailsScreen(),

  };


  List<StatefulWidget> _stack = List<StatefulWidget>();

  int _seconds = 0;

  disposeLast(){
    if (_stack.isNotEmpty)
      _stack.removeLast();
    _printStack();
  }

  setDuration(int seconds){
    _seconds = seconds;
  }

  // pushLanguage(BuildContext _context, Function(String) callback){
  //   var _screen = LanguageScreen(callback : callback);
  //   _stack.add(_screen);
  //   _printStack();
  //   Navigator.push(
  //     _context,
  //     PageRouteBuilder(
  //       transitionDuration: Duration(seconds: _seconds),
  //       pageBuilder: (_, __, ___) => _screen,
  //     ),
  //   );
  //   _seconds = 0;
  // }

  // push(BuildContext _context, String name){
  //   var _screen = routes[name];
  //   if (name == "/main")
  //     mainScreen = _screen;
  //   _stack.add(_screen);
  //   _printStack();
  //   Navigator.push(
  //     _context,
  //     PageRouteBuilder(
  //       transitionDuration: Duration(seconds: _seconds),
  //       pageBuilder: (_, __, ___) => _screen,
  //     ),
  //   );
  //   _seconds = 0;
  // }

  // pushToStart(BuildContext _context, String name) {
  //   var _screen = routes[name];
  //   if (name == "/main")
  //     mainScreen = _screen;
  //   _stack.clear();
  //   _stack.add(_screen);
  //   _printStack();
  //   Navigator.pushAndRemoveUntil(
  //       _context,
  //       PageRouteBuilder(
  //         transitionDuration: Duration(seconds: _seconds),
  //         pageBuilder: (_, __, ___) => _screen,
  //       ),
  //       (route) =>route == null
  //   );
  //   _seconds = 0;
  // }

  _printStack(){
    var str = "Screens Stack: ";
    for (var item in _stack)
      str = "$str -> $item";
    print(str);
  }

  pop(BuildContext context){
    Navigator.pop(context);
  }

  popToMain(BuildContext context){
    var _lenght = _stack.length;
    for (int i = 0; i < _lenght-1; i++) {
      pop(context);
    }
  }

}
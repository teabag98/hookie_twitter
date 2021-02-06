import 'package:flutter/material.dart';
import 'package:hookie_twitter/src/common/theme.dart';
import 'package:hookie_twitter/src/models/user.dart';
import 'package:hookie_twitter/src/service_locator.dart';
import 'package:hookie_twitter/src/utils/sharedprefsutil.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class _InheritedStateContainer extends InheritedWidget {
  // Data is your entire state. In our case just 'User'
  final StateContainerState data;

  // You must pass through a child and your state.
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  // that rely on your state.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class StateContainer extends StatefulWidget {
  // You must pass through a child.
  final Widget child;

  StateContainer({@required this.child});

  // This is the secret sauce. Write your own 'of' method that will behave
  // Exactly like MediaQuery.of and Theme.of
  // It basically says 'get the data from the widget of this type.
  static StateContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()
        .data;
  }

  @override
  StateContainerState createState() => StateContainerState();
}

/// App InheritedWidget
/// This is where we handle the global state and also where
/// we interact with the server and make requests/handle+propagate responses
///
/// Basically the central hub behind the entire app
class StateContainerState extends State<StateContainer> {
  final Logger log = sl.get<Logger>();

  // UserModel user;

  bool isOnline = false;

  User user;

  AppThemeData theme = AppThemeData();

  @override
  void initState() {
    super.initState();

    theme.init();

    sl.get<SharedPrefsUtil>().getUser().then((userDetails) {
      setState(() {
        if (userDetails != null) {
          user = userDetails;
          // sl.get<ApiService>().user = userDetails;
        }
      });
      log.d(user.email);
      log.e(user.email);
    });

    // sl.get<SharedPrefsUtil>().getToken().then((value) {
    //   if (value != null) {
    //     setState(() {
    //       token = value;
    //     });
    //   }
    // });

    // sl.get<sSharedPrefsUtil>().getDefaultPay().then((payInt) {
    //   if (payInt != null) {
    //     setState(() {
    //       pay = payInt;
    //     });
    //   }
    // });

    // sl.get<ApiService>().getToken();

    // sl.get<Fcm>().configFcm();

    // sl.get<Fcm>().getAppToken().then((value) {
    //   if (value != null) {
    //     setState(() {
    //       appInstallId = value;
    //     });
    //   }
    // });

    _permissons();
  }

  _permissons() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.location, Permission.locationWhenInUse].request();

    log.d(statuses[Permission.location]);
    log.d(statuses[Permission.locationWhenInUse]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Simple build method that just passes this state through
  // your InheritedWidget
  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookie_twitter/src/appstate_container.dart';
import 'package:hookie_twitter/src/screens/authenticate/login/login.dart';
import 'package:hookie_twitter/src/screens/authenticate/register/register.dart';
import 'package:hookie_twitter/src/screens/home/mapnavigation.dart';
import 'package:hookie_twitter/src/screens/home/home.dart';
import 'package:hookie_twitter/src/screens/onboarding.dart';
import 'package:hookie_twitter/src/service_locator.dart';
import 'package:hookie_twitter/src/utils/nav_service.dart';
import 'package:hookie_twitter/src/utils/sharedprefsutil.dart';
import 'package:hookie_twitter/src/widgets/ibackground3.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            //initialize SizerUtil()
            SizerUtil().init(constraints, orientation);
            return OKToast(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: StateContainer.of(context).theme.primarySwatch,
                ),
                title: 'Hookie',
                initialRoute: '/',
                navigatorKey: sl.get<NavigatorService>().navigatorKey,
                builder: EasyLoading.init(),
                onGenerateRoute: (RouteSettings settings) {
                  switch (settings.name) {
                    case '/':
                      return MaterialPageRoute(
                        builder: (_) => Splash(),
                        settings: settings,
                      );
                    case '/mainscreen':
                      return MaterialPageRoute(
                          builder: (_) => MainScreen(),
                        settings: settings
                      );

                    case '/home':
                      return MaterialPageRoute(
                        builder: (_) => HomeScreen(),
                        settings: settings,
                      );

                    case '/intro_welcome':
                      return MaterialPageRoute(
                        builder: (_) => OnBoarding(),
                        settings: settings,
                      );

                    case '/login':
                      return MaterialPageRoute(
                        builder: (_) => Login(),
                        settings: settings,
                      );

                    case '/register':
                      return MaterialPageRoute(
                        builder: (_) => Register(),
                        settings: settings,
                      );

                    default:
                      return null;
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  bool _hasCheckedLoggedIn;

  Future checkedLoggedIn() async {
    if (!_hasCheckedLoggedIn) {
      _hasCheckedLoggedIn = true;
    } else {
      return;
    }
    try {
      bool firstLaunch = await sl.get<SharedPrefsUtil>().getFirstLaunch();

      await sl.get<SharedPrefsUtil>().setFirstLaunch();

      if (firstLaunch) {
        sl.get<NavigatorService>().pushReplacementNamed('/intro_welcome');
      }

      print('--------First Launch-------');
      print('--------$firstLaunch-------');

      bool isloggedIn = false;

      await sl.get<SharedPrefsUtil>().getUser().then((user) {
        if (user.id != null) {
          isloggedIn = true;
        }
        print(user.id);
      });

      if (isloggedIn) {
        sl.get<NavigatorService>().pushReplacementNamed('/mainscreen');
      } else {
        if (firstLaunch) {
          sl.get<NavigatorService>().pushReplacementNamed('/intro_welcome');
        } else {
          sl.get<NavigatorService>().pushReplacementNamed('/login');
        }
      }
    } catch (e) {
      print(e);
      // Case of errors clear db
      await sl.get<SharedPrefsUtil>().deleteAll();
      _hasCheckedLoggedIn = false;
      checkedLoggedIn();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _hasCheckedLoggedIn = false;

    checkedLoggedIn();

    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) => checkedLoggedIn());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Account for user changing locale when leaving the app
    switch (state) {
      case AppLifecycleState.paused:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        super.didChangeAppLifecycleState(state);
        break;
      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: StateContainer.of(context).theme.colorBackground,
          ),
          IBackground4(
            width: 100.0.w,
            colorsGradient: StateContainer.of(context).theme.colorsGradient,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: "Hookie",
                  child: Container(
                    width: 30.0.w,
                    child: Image.asset("assets/images/logo.png",
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                CircularProgressIndicator(
                  backgroundColor:
                      StateContainer.of(context).theme.colorCompanion4,
                  strokeWidth: 1,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

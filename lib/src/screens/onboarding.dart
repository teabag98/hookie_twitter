import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hookie_twitter/src/appstate_container.dart';
import 'package:hookie_twitter/src/service_locator.dart';
import 'package:hookie_twitter/src/utils/nav_service.dart';

import 'package:sizer/sizer.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding>
    with SingleTickerProviderStateMixin {
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  // Data for pages
  //
  List<Page> pages = [
    Page(
        image: AssetImage('assets/images/onboard_1.jpg'),
        title: 'Hookie',
        bodyText: 'Get hooked up in minutes'),
    Page(
        image: AssetImage('assets/images/onboard_2.jpg'),
        title: 'Hookie',
        bodyText: 'Get hooked up in minutes'),
    Page(
        image: AssetImage('assets/images/onboard_3.jpg'),
        title: 'Hookie',
        bodyText: 'Get hooked up in minutes'),
  ];

  //
  // User press "Skip" button
  //
  _pressSkipButton() {
    print("User pressed \"Skip\" button");
    // route.pushToStart(context, "/login");

    sl.get<NavigatorService>().pushReplacementNamed('/login');
  }

  //
  // User press "Down" button
  //
  _pressDownButton() {
    print("User pressed \"Down\" button");
    // route.pushToStart(context, "/login");
    sl.get<NavigatorService>().pushReplacementNamed('/login');
  }

  // Page select listener.
  //
  _pageSelect(int index) {
    print("Current page: $index");
  }

  //
  //////////////////////////////////////////////////////////////////////////////////////////////////////

  Animation<double> _animation;
  AnimationController _controller;
  double _fraction = 100.0;
  var _curIndex = 0;
  var _curIndex2 = 0;
  var _duration = 1000;
  var _move = false;

  bool _moveBack = false;

  @override
  void initState() {
    _pageSelect(0);
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: _duration), vsync: this);
    _animation = Tween(begin: 100.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      })
      ..addStatusListener(
            (status) {
          if (status == AnimationStatus.completed) {
            _move = false;
            if (_moveBack) {
              _moveBack = false;
              if (_curIndex > 0) {
                _curIndex--;
                _pageSelect(_curIndex);
              }
            } else if (_curIndex < pages.length - 1) {
              _curIndex++;
              _pageSelect(_curIndex);
            }
            _controller.reset();
          }
          //}else if(status == AnimationStatus.dismissed)
          // _controller.forward();
        },
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void go() {
    if (_move) return;
    if (_curIndex < pages.length - 1) {
      _move = true;
      _curIndex2 = _curIndex2 + 1;
      _controller.forward();
    }
  }

  void goBack() {
    if (_move) return;
    if (_curIndex > 0) {
      _move = true;
      _curIndex2 = _curIndex - 1;
      _moveBack = true;
      _controller.forward();
    }
  }

  var _fraction2 = 100.0;
  var _lineHeight = 5.0;
  DragStartDetails _dragStartPosition;

  @override
  Widget build(BuildContext context) {
    var _if = pages[_curIndex].image;
    var _ifTitle = pages[_curIndex].title;
    var _ifbodyText = pages[_curIndex].bodyText;

    var _ib = pages[_curIndex].image;
    var _ibTitle = pages[_curIndex].title;
    var _ibbodyText = pages[_curIndex].bodyText;

    if (_curIndex + 1 < pages.length) {
      _ib = pages[_curIndex + 1].image;
      _ibTitle = pages[_curIndex + 1].title;
      _ibbodyText = pages[_curIndex + 1].bodyText;
    }
    if (_moveBack) {
      if (_curIndex > 0) {
        _ib = pages[_curIndex - 1].image;
        _ibTitle = pages[_curIndex - 1].title;
        _ibbodyText = pages[_curIndex - 1].bodyText;
      }
    }

    if (_move) _fraction2 = _fraction;

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragStart: (DragStartDetails details) {
          _dragStartPosition = details;
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          if (_dragStartPosition.globalPosition.dx > details.globalPosition.dx)
            go();
          else
            goBack();
        },
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Hero(
                  tag: "Hookie",
                  child: Container(
                    width: 30.0.w,
                    child: Image.asset("assets/images/logo.png",
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),

            // Background
            Container(
              color: StateContainer.of(context).theme.colorBackground,
              width: 100.0.w,
              height: 100.0.h,
              child: _buildInfo(_ib, _ibTitle, _ibbodyText, _fraction2),
            ),

            // foreground
            ClipPath(
              clipper: BezierClipper(
                clock: _fraction,
              ),
              child: Container(
                  color: StateContainer.of(context).theme.colorBackground,
                  width: 100.0.w,
                  height: 100.0.h,
                  child: _buildInfo(_if, _ifTitle, _ifbodyText, 0)),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  //color: Colors.red,
                  height: 60,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: _buildline(),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: _buildButtonSkip("Skip", 255) // "Skip",
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: _buildButtonSkip("Down", 0) // "Down",
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _buildButtonSkip(String text, int i) {
    var alpha = i - (255 / (pages.length - 1) * (_curIndex2));
    var m = (_curIndex2 * (100 / pages.length)).toDouble();
    if (i == 0) {
      m = 100 - ((_curIndex2 + 1) * 100 / pages.length).toDouble();
      alpha = -alpha;
    }
    if (pages.length == 1) alpha = 255;
    return AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: m),
        child: InkWell(
            onTap: () {
              if (i == 255) _pressSkipButton();
              if (i == 0) _pressDownButton();
            }, // needed
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                text,
                style: TextStyle(
                  color: Color(0xFF9E9E9E).withAlpha(alpha.toInt()),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            )));
  }

  _buildline() {
    var idx = 30.0.w;
    double x = idx / (pages.length - 1) * _curIndex2;
    if (pages.length == 1) x = idx / 2;
    if (x > idx) x = idx - 1;
    return Container(
        height: _lineHeight,
        margin: EdgeInsets.only(left: 10),
        child: AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.easeOutQuint,
            margin: EdgeInsets.only(left: idx - x, right: x),
            child: Row(children: _list())));
  }

  _list() {
    var list = List<Widget>();
    for (int i = 0; i < pages.length; i++) {
      Color color = Colors.grey;
      if (i == _curIndex2)
        color = StateContainer.of(context).theme.colorPrimary;
      list.add(Container(
          margin: EdgeInsets.only(right: 2),
          width: (60.0.w) / pages.length,
          height: _lineHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
          )));
    }
    return list;
  }

  _buildInfo(var _ib, String _ibTitle, String _ibbodyText, double _fraction2) {
    return Container(
        child: Stack(
          children: <Widget>[
            Container(
                width: 100.0.w,
                height: 60.0.h,
                child: Container(
                  padding: EdgeInsets.only(top: _fraction2),
                  child: Image(image: _ib, fit: BoxFit.cover),
                )),
            Container(
                margin: EdgeInsets.only(top: 30.0.h),
                width: 100.0.w,
                height: 30.0.h,
                child: DecoratedBox(
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            StateContainer.of(context)
                                .theme
                                .colorBackground
                                .withAlpha(0),
                            StateContainer.of(context)
                                .theme
                                .colorBackground
                                .withAlpha(100),
                            StateContainer.of(context).theme.colorBackground
                          ])),
                )),
            Container(
                margin: EdgeInsets.only(top: 30.0.h),
                width: 100.0.w,
                height: 30.0.h,
                child: DecoratedBox(
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            StateContainer.of(context)
                                .theme
                                .colorBackground
                                .withAlpha(0),
                            StateContainer.of(context)
                                .theme
                                .colorBackground
                                .withAlpha(100),
                            StateContainer.of(context).theme.colorBackground
                          ])),
                )),
            Container(
              margin: EdgeInsets.only(
                top: 65.0.h,
                left: 30,
                right: 30,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: _fraction2 / 5),
                      child: Text(
                        _ibTitle,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        style: StateContainer.of(context).theme.text20boldPrimary,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _ibbodyText,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: StateContainer.of(context).theme.text16,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class BezierClipper extends CustomClipper<Path> {
  double clock = 100;
  BezierClipper({this.clock});

  @override
  Path getClip(Size size) {
    var start = size.height * clock / 100;

    Path path = new Path();
    path.lineTo(0, start);
    if (clock != 100)
      path.quadraticBezierTo(
          size.width / 2, start - size.height * 0.4, size.width, start);
    else
      path.lineTo(size.width, start);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class Page {
  final AssetImage image;
  final String title;
  final String bodyText;

  Page({this.image, this.title, this.bodyText});
}

class RevealProgressButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RevealProgressButtonState();
}

class _RevealProgressButtonState extends State<RevealProgressButton>
    with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  double _fraction = 0.0;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter:
      RevealProgressButtonPainter(_fraction, MediaQuery.of(context).size),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 3000), () {
      reveal();
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  void reveal() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });

    _controller.forward();
  }
}

class RevealProgressButtonPainter extends CustomPainter {
  double _fraction = 0.0;
  Size _screenSize;

  RevealProgressButtonPainter(this._fraction, this._screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    var finalRadius =
    sqrt(pow(_screenSize.width, 2) + pow(_screenSize.height, 2));
    var radius = 24.0 + finalRadius * _fraction;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

  @override
  bool shouldRepaint(RevealProgressButtonPainter oldDelegate) {
    return oldDelegate._fraction != _fraction;
  }
}
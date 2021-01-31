import 'package:flutter/material.dart';
import 'package:hookie_twitter/src/appstate_container.dart';
import 'package:hookie_twitter/src/common/theme.dart';
import 'package:hookie_twitter/src/models/user.dart';
import 'package:hookie_twitter/src/service_locator.dart';
import 'package:hookie_twitter/src/utils/nav_service.dart';
import 'package:hookie_twitter/src/widgets/iinkwell.dart';

class Header extends StatefulWidget {
  final String title;
  final Function onMenuClick;
  final bool nomenu;
  final bool white;
  final bool transparent;
  Header(
      {Key key,
      this.title,
      this.onMenuClick,
      this.nomenu = false,
      this.white = false,
      this.transparent = false})
      : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  ///////////////////////////////////////////////////////////////////////////////
  //
  var _iconMenu = "assets/images/menu.png";
  var _iconBack = "assets/images/back.png";
  var _iconNotify = "assets/images/notifyicon.png";

  Color _color = Colors.black;

  _onBackClick() {
    sl.get<NavigatorService>().pop();
  }

  _onMenuClick() {
     print("User click menu button");
     if (widget.onMenuClick != null) widget.onMenuClick();
  }

  _onNotifyClick() {
    // print("User click Notify button");
    // route.push(context, "/notify");
  }

  _onAvatarClick() {
    // print("User click avatar button");
    // route.popToMain(context);
//    if (widget.nomenu)
//      Navigator.pop(context);
    // route.mainScreen.route("account");
  }

  AppThemeData theme;
  User user;

  @override
  void initState() {
    super.initState();

  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    theme = StateContainer.of(context).theme;
    user = StateContainer.of(context).user;
  }

  @override
  Widget build(BuildContext context) {
    _color = theme.colorDefaultText;
    if (widget.white) _color = Colors.white;

    String _title = "";
    if (widget.title != null) _title = widget.title;

    Widget _menu = IInkWell(
      child: _iconMenuWidget(),
      onPress: _onMenuClick,
    );
    if (widget.nomenu)
      _menu = IInkWell(
        child: _iconBackWidget(),
        onPress: _onBackClick,
      );

    var _style = theme.text16bold;
    if (widget.white != null && widget.white) _style = theme.text16boldWhite;

    var _box = BoxDecoration(
      color: theme.colorBackground,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 3,
          blurRadius: 5,
          offset: Offset(3, 3),
        ),
      ],
    );
    if (widget.transparent) _box = BoxDecoration();

    return Container(
      height: 30,
      decoration: _box,
      child: Row(
        children: <Widget>[
          _menu,
          Expanded(
            child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  _title,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: _style,
                )),
          ),
          IInkWell(
            child: _notify(),
            onPress: _onNotifyClick,
          ),
          IInkWell(
            child: _avatar(),
            onPress: _onAvatarClick,
          ),
        ],
      ),
    );
  }

  _avatar() {
    return Container(
      child: CircleAvatar(
        backgroundImage:
            AssetImage(user.profilePic ?? 'assets/images/user.jpg'),
        radius: 12,
      ),
      margin: EdgeInsets.only(left: 5, top: 2, bottom: 2, right: 10),
    );
  }

  _iconMenuWidget() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      child: UnconstrainedBox(
        child: Container(
          height: 25,
          width: 25,
          child: Image.asset(
            _iconMenu,
            fit: BoxFit.contain,
            color: _color,
          ),
        ),
      ),
    );
  }

  _iconBackWidget() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      child: UnconstrainedBox(
        child: Container(
          height: 25,
          width: 25,
          child: Image.asset(
            _iconBack,
            fit: BoxFit.contain,
            color: _color,
          ),
        ),
      ),
    );
  }

  _notify() {
    return UnconstrainedBox(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
        height: 25,
        width: 30,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: UnconstrainedBox(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  height: 25,
                  width: 30,
                  child: Image.asset(
                    _iconNotify,
                    fit: BoxFit.contain,
                    color: _color,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: theme.colorPrimary,
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '12',
                    style: theme.text10white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

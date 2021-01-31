import 'package:flutter/material.dart';

class IListX extends StatefulWidget {
  final Widget icon;
  final String text;
  final TextStyle textStyle;
  final Function(bool) press;
  final Color iconColor;
  final bool initState;
  final Color activeColor;
  final Color inactiveTrackColor;
  IListX({this.text = "", this.icon, this.textStyle,
    this.press, this.iconColor = Colors.black,
    this.initState = false, this.activeColor, this.inactiveTrackColor
  });

  @override
  _IListXState createState() => _IListXState();
}

class _IListXState extends State<IListX> {

  bool _notify = false;

  @override
  void initState() {
    _notify = widget.initState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget _icon = Container();
    if (widget.icon != null)
      _icon = widget.icon;
    TextStyle _textStyle = TextStyle();
    if (widget.textStyle != null)
      _textStyle = widget.textStyle;

    return Stack(
      children: <Widget>[
        ListTile(
            leading: _icon,
            title: Text(widget.text,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.left,
                style: _textStyle)
        ),

      ],
    );
  }

}
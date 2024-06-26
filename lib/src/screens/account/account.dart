import 'package:flutter/material.dart';
import 'package:hookie_twitter/src/common/lang.dart';
import 'package:hookie_twitter/src/common/theme.dart';
import 'package:hookie_twitter/src/models/user.dart';
import 'package:hookie_twitter/src/widgets/iAvatarWithPhoto.dart';
import 'package:hookie_twitter/src/widgets/iAvatarWithPhotoFileCaching.dart';
import 'package:hookie_twitter/src/widgets/ibutton2.dart';
import 'package:hookie_twitter/src/widgets/ilist4.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AccountScreen extends StatefulWidget {
  final Function(String) onDialogOpen;
  AccountScreen({Key key, this.onDialogOpen}) : super(key: key);
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Lang strings = Lang();
  // Theme
//
  AppThemeData theme = AppThemeData();

 static User user = User();
  ///////////////////////////////////////////////////////////////////////////////
  //

  _onChangePassword(){
    widget.onDialogOpen("changePassword");
  }

  _pressEditProfileButton(){
    print("User pressed Edit profile");
    widget.onDialogOpen("EditProfile");
  }

  _pressLogOutButton()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('loggedIn', false);
    print("User pressed Log Out");
    //account.logOut();
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  }

  _makePhoto(){
    print("Make photo");
    widget.onDialogOpen("makePhoto");
  }



  //
  //
  ///////////////////////////////////////////////////////////////////////////////
  var windowWidth;
  var windowHeight;



  @override
  void initState() {
    super.initState();
    setState(() {
    });
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery
        .of(context)
        .size
        .width;
    windowHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: MediaQuery
                .of(context)
                .padding
                .top + 40),
            child: Container(
                child: ListView(
                  padding: EdgeInsets.only(top: 0),
                  shrinkWrap: true,
                  children: _getList(),
                )
            ),
          ),

        ],

    );
  }

  _getList() {
    var list = List<Widget>();

    list.add(
        Stack(
          children: [
            IAvatarWithPhotoFileCaching(
              // avatar: ,
              color: theme.colorPrimary,
              colorBorder: theme.colorGrey,
              callback: _makePhoto,
            ),
            _logoutWidget(),
          ],
        ));

    list.add(SizedBox(height: 10,));

    list.add(Container(
      color: theme.colorBackgroundGray,
      child: _userInfo(),
    ));

    list.add(SizedBox(height: 30,));

    list.add(Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: _logout()
    ));

    list.add(SizedBox(height: 30,));

    list.add(Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: _changePassword()
    ));

    list.add(SizedBox(height: 100,));

    return list;
  }

  _changePassword(){
    return Container(
      alignment: Alignment.center,
      child: IButton2(
          color: theme.colorPrimary,
          text: strings.get(127),                           // Change password
          textStyle: theme.text14boldWhite,
          padding: 40,
          pressButton: _onChangePassword
      ),
    );
  }

  _logout(){
    return Container(
      alignment: Alignment.center,
      child: IButton2(
          color: theme.colorPrimary,
          text: strings.get(128),                           // Edit profile
          textStyle: theme.text14boldWhite,
          padding: 40,
          pressButton: _pressEditProfileButton
      ),
    );
  }

  _logoutWidget(){
    return  Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 10, right: 10),
      child: Stack(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorBackgroundDialog,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: Icon(Icons.exit_to_app, color: theme.colorDefaultText..withOpacity(0.1), size: 30),
          ),
          Positioned.fill(
            child: Material(
                color: Colors.transparent,
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.grey[400],
                  onTap: (){
                    _pressLogOutButton();
                  }, // needed
                )),
          )
        ],
      ),);
  }


  
  _userInfo(){
          return ListView(
            shrinkWrap: true,
              children: [
              ListTile(
              title:IList4(text: "${strings.get(57)}:", // "Username",
    ),
    subtitle:Text("${user.username}"??'username')
    ),
    SizedBox(height: 10),
    ListTile(
    title:IList4(text: "${strings.get(58)}:", // "Username",
    ),
    subtitle:Text("${user.email}"??'email')
    ),
    SizedBox(height: 10),
    ListTile(
    title:IList4(text: "${strings.get(59)}:", // "Username",
    ),
    subtitle:Text("${user.phone}"??'xxx435644')
    ),
    SizedBox(height: 10),
    ]
          ) ;       // SizedBox(height: 10,
  }
}
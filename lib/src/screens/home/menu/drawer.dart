import 'package:flutter/material.dart';
import 'package:hookie_twitter/src/appstate_container.dart';
import 'package:hookie_twitter/src/models/user.dart';
import 'package:hookie_twitter/src/service_locator.dart';
import 'package:hookie_twitter/src/utils/sharedprefsutil.dart';
import 'package:hookie_twitter/src/widgets/iList6.dart';
import 'package:hookie_twitter/src/widgets/iListX.dart';
import 'package:hookie_twitter/src/widgets/iline.dart';
import 'package:hookie_twitter/src/widgets/ilist5.dart';
import 'package:oktoast/oktoast.dart';

class Menu extends StatelessWidget {
  Menu({this.context, this.callback});
  @required
  final BuildContext context;

  final Function(String) callback;

  static User user = User();

  @override
  Widget build(BuildContext context) {
    user = StateContainer.of(context).user;

    return Drawer(
      child: Container(
        color: StateContainer.of(context).theme.colorBackground,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             SizedBox(height: MediaQuery
                 .of(context)
                 .padding
                 .top,),

            Container(
             height: 90,
              child: Row(
                children: <Widget>[
                  UnconstrainedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(1, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                            user.profilePic ?? 'assets/images/user.jpg'),
                        radius: 35,
                      ),
                      margin: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 10),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          user.username,
                          style: StateContainer.of(context)
                              .theme
                              .text18boldPrimary,
                        ),
                        Text(
                          user.email,
                          style: StateContainer.of(context).theme.text16,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ILine(),
            // _item(1, "Home", "assets/images/home.png",),
            //
            // _item(2, "Notifications", "assets/images/notifyicon.png"),
            //
            //
            // _item(7, "Help & Support",
            //     "assets/images/help.png"), // Help & Support
            //
            // _item(8, "Account", "assets/images/settings.png"), // "Account",
            IListX(
              icon:UnconstrainedBox(
                  child: Container(
                      height: 25,
                      width: 25,
                      child: Image.asset(
                        "assets/images/home.png",
                        fit: BoxFit.contain,
                        color: StateContainer.of(context).theme.colorPrimary,
                      )
                  )
              ),
              text: "home",
              textStyle: StateContainer.of(context).theme.text16bold,
              activeColor: StateContainer.of(context).theme.colorPrimary,
              inactiveTrackColor: StateContainer.of(context).theme.colorGrey,
            ),
            IListX(
              icon:UnconstrainedBox(
                  child: Container(
                      height: 25,
                      width: 25,
                      child: Image.asset(
                        "assets/images/help.png",
                        fit: BoxFit.contain,
                        color: StateContainer.of(context).theme.colorPrimary,
                      )
                  )
              ),
              text: "help & support",
              textStyle: StateContainer.of(context).theme.text16bold,
              activeColor: StateContainer.of(context).theme.colorPrimary,
              inactiveTrackColor: StateContainer.of(context).theme.colorGrey,
            ),
            IListX(
              icon:UnconstrainedBox(
                  child: Container(
                      height: 25,
                      width: 25,
                      child: Image.asset(
                        "assets/images/settings.png",
                        fit: BoxFit.contain,
                        color: StateContainer.of(context).theme.colorPrimary,
                      )
                  )
              ),
              text: "Account",
              textStyle: StateContainer.of(context).theme.text16bold,
              activeColor: StateContainer.of(context).theme.colorPrimary,
              inactiveTrackColor: StateContainer.of(context).theme.colorGrey,
            ),

            IListX(
              icon:UnconstrainedBox(
                  child: Container(
                      height: 25,
                      width: 25,
                      child: Image.asset(
                        "assets/images/notifyicon.png",
                        fit: BoxFit.contain,
                        color: StateContainer.of(context).theme.colorPrimary,
                      )
                  )
              ),
              text: "notifications",
              textStyle: StateContainer.of(context).theme.text16bold,
              activeColor: StateContainer.of(context).theme.colorPrimary,
              inactiveTrackColor: StateContainer.of(context).theme.colorGrey,
            ),
            IListX(
              icon:UnconstrainedBox(
                  child: Container(
                      height: 25,
                      width: 25,
                      child: Image.asset(
                        "assets/images/help.png",
                        fit: BoxFit.contain,
                        color: StateContainer.of(context).theme.colorPrimary,
                      )
                  )
              ),
              text: "Terms of service",
              textStyle: StateContainer.of(context).theme.text16bold,
              activeColor: StateContainer.of(context).theme.colorPrimary,
              inactiveTrackColor: StateContainer.of(context).theme.colorGrey,
            ),

            IList5(
              icon: UnconstrainedBox(
                  child: Container(
                      height: 25,
                      width: 25,
                      child: Image.asset(
                        "assets/images/notifyicon.png",
                        fit: BoxFit.contain,
                        color: StateContainer.of(context).theme.colorPrimary,
                      )
                  )
              ),
              initState: true,
              text: "Online/ Offline", // Notifications
              textStyle: StateContainer.of(context).theme.text16bold,
              activeColor: StateContainer.of(context).theme.colorPrimary,
              inactiveTrackColor: StateContainer.of(context).theme.colorGrey,
              press: (bool online) {
                if(online == true){
                  showToast('Online');
                  final SharedPrefsUtil db = sl.get<SharedPrefsUtil>();
                  db.set('status', true);
                   build(context);
                }
                if(online == false){
                  final SharedPrefsUtil db = sl.get<SharedPrefsUtil>();
                  db.set('status', false);
                  build(context);
                }


              },
            ),
            _item(11, "Terms of Service", "assets/images/help.png"),

            ILine(),
          ],
        ),
      ),
    );
  }

  _onMenuClickItem(int id) {
    print("User click menu item: $id");
    switch (id) {
      case 1: // home
        callback("home");
        break;
      case 2: // notifications
        // route.push(context, "/notifications");
        break;
      case 3: // My Orders
        // callback("orders");
        break;
      case 4: // Wish List
        // callback("favorites");
        break;
      case 7: // Help
        // route.push(context, "/help");
        break;
      case 8: // Settings
        // callback("account");
        break;
      case 9: // Language
        // route.pushLanguage(context, callback);
        break;
      // case 10: // dark & light mode
      //   theme.changeDarkMode();
      //   callback("redraw");
      //   break;
      // case 11: // term of service
      //   route.push(context, "/term");
      //   break;
    }
  }

  _item(int id, String name, String imageAsset) {
    return Stack(
      children: <Widget>[
        ListTile(
          title: Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
          ),
          leading: UnconstrainedBox(
              child: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset(
                    imageAsset,
                    fit: BoxFit.contain,
                    color: StateContainer.of(context).theme.colorPrimary,
                  ))),
        ),
        Positioned.fill(
          child: Material(
            child: InkWell(
              splashColor: Colors.grey[400],
              onTap: () {
                // Navigator.pop(context);
                _onMenuClickItem(id);
              }, // needed
            ),
          ),
        )
      ],
    );
  }
}

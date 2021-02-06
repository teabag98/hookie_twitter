import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookie_twitter/src/models/user.dart';
import 'package:hookie_twitter/src/service_locator.dart';
import 'package:hookie_twitter/src/utils/sharedprefsutil.dart';

import '../../../appstate_container.dart';

class ProfileDialog extends StatefulWidget {
  @override
  _ProfileDialogState createState() => _ProfileDialogState();
}



class _ProfileDialogState extends State<ProfileDialog> {

  SharedPrefsUtil  db = sl.get<SharedPrefsUtil>();

   static User user = User();

  @override
  void initState(){
    super.initState();
    // db.getUser().then((value) => user = value);
  }


  @override
  void dispose(){
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    user = StateContainer.of(context).user;// TODO: implement build

    return Scaffold(
      body: AlertDialog(
        content: Container(
          color: StateContainer.of(context).theme.colorBackground,
          height: MediaQuery.of(context).size.height*0.8,
          width: MediaQuery.of(context).size.width*0.8,
          child:
              Column(
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
                             'assets/images/useAvatar.png'),
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
                       user.username??"",
                          style: StateContainer.of(context)
                              .theme
                              .text18boldPrimary,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          user.email??"",
                          style: StateContainer.of(context).theme.text16,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          user.phone??"",
                          style: StateContainer.of(context).theme.text16,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                      Icons.exit_to_app,
                      color: StateContainer.of(context).theme.colorDefaultText..withOpacity(0.1),
                      size: 30),
                  Positioned.fill(
                    child: Material(
                        color: Colors.transparent,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.grey[400],
                          onTap: ()async{
                            await db.deleteAll();
                          }, // needed
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      child: Text('Close'),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
      ),

    )
    );
  }

}








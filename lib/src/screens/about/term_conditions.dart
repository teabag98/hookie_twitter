import 'package:flutter/material.dart';
import 'package:hookie_twitter/src/appstate_container.dart';
import 'package:hookie_twitter/src/screens/home/menu/header.dart';
import 'package:hookie_twitter/src/widgets/ibackground3.dart';

import 'package:sizer/sizer.dart';

class TermsofService extends StatefulWidget {
  @override
  _TermsofServiceState createState() => _TermsofServiceState();
}

class _TermsofServiceState extends State<TermsofService> {
  String _terms = """
        These Terms and Conditions constitute a legally binding agreement made between you, whether personally or on behalf of an entity (“you”) and [business entity name] (“we,” “us” or “our”), concerning your access to and use of the [website name.com] website as well as any other media form, media channel, mobile website or mobile application related, linked, or otherwise connected thereto (collectively, the “Site”). \n\nYou agree that by accessing the Site, you have read, understood, and agree to be bound by all of these Terms and Conditions. If you do not agree with all of these Terms and Conditions, then you are expressly prohibited from using the Site and you must discontinue use immediately. \n\nSupplemental terms and conditions or documents that may be posted on the Site from time to time are hereby expressly incorporated herein by reference. We reserve the right, in our sole discretion, to make changes or modifications to these Terms and Conditions at any time and for any reason. \n\nWe will alert you about any changes by updating the “Last updated” date of these Terms and Conditions, and you waive any right to receive specific notice of each such change.
      """;

  @override
  Widget build(BuildContext context) {
    var topPadding = MediaQuery.of(context).padding.top;
    var theme = StateContainer.of(context).theme;

    return Scaffold(
      backgroundColor: theme.colorBackground,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: topPadding),
            width: 100.0.w,
            height: 30.0.h,
            child: IBackground4(
              width: 100.0.w,
              colorsGradient: theme.colorsGradient,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: 30.0.h + 40 + topPadding, left: 20, right: 20),
            width: 100.0.w,
            height: 70.0.h,
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "Terms and Conditions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  _terms,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 10.0.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: topPadding),
            height: 40,
            child: Header(
              nomenu: true,
              transparent: true,
              white: true,
            ),
          ),
        ],
      ),
    );
  }
}

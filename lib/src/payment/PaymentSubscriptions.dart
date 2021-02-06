import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:flutterwave/widgets/home/flutterwave_payment.dart';
import 'package:hookie_twitter/src/models/subscription.dart';
import 'package:hookie_twitter/src/service_locator.dart';
import 'package:hookie_twitter/src/utils/sharedprefsutil.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart';

class SubscriptionPayment extends StatefulWidget {
  @override
  _SubscriptionPaymentState createState() => _SubscriptionPaymentState();
}

class _SubscriptionPaymentState extends State<SubscriptionPayment> {
  final String txref = "My_unique_transaction_reference_123";
   double amount = 100;
  final String currency = FlutterwaveCurrency.KES;
  final int accountBalance = 0;
  // final SharedPrefsUtil db = sl.get<SharedPrefsUtil>();

  Subscription subscription = Subscription();

  var phone;
  SharedPrefsUtil db;


  @override
  void initState(){
    super.initState();
      db = sl.get<SharedPrefsUtil>();
     db.getUser().then((value) => phone = value.phone);

  }

  @override
  void dispose(){
    super.dispose();
  }

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Subscriptions'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Container(
  //                 decoration: BoxDecoration(
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.cyan,
  //                         blurRadius: 10.0,
  //                         spreadRadius: 7.0,
  //                         offset: Offset(
  //                           5.0, // Move to right 10  horizontally
  //                           5.0, // Move to bottom 5 Vertically
  //                         ),)
  //                     ]
  //                 ),
  //                 child:Column(
  //                   children: [
  //                     Text('Standard'),
  //                     Text('Get to meet people in standard platform'),
  //                     Text('ksh 100/month'),
  //                     RaisedButton(
  //                       onPressed:(){
  //                         processPayment();
  //                         // Navigator.push(context,
  //                         //     MaterialPageRoute(builder: (BuildContext context) => SubscriptionPayment()));
  //                       } ,
  //                       child: Text('Buy subscription'),
  //                       color: Colors.cyan,
  //                     )
  //                   ],
  //                 ),
  //                 padding: EdgeInsets.all(10.0),
  //               ),
  //               Container(
  //                 decoration: BoxDecoration(
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.cyan,
  //                         blurRadius: 10.0,
  //                         spreadRadius: 7.0,
  //                         offset: Offset(
  //                           5.0, // Move to right 10  horizontally
  //                           5.0, // Move to bottom 5 Vertically
  //                         ),)
  //                     ]
  //                 ),
  //                 child:Column(
  //                   children: [
  //                     Text('Premium'),
  //                     Text('Get to meet people in premium platform'),
  //                     Text('ksh 1000/month'),
  //                     RaisedButton(
  //                       onPressed:(){} ,
  //                       child: Text('Buy subscription'),
  //                       color: Colors.cyan,
  //                     )
  //                   ],
  //                 ),
  //                 padding: EdgeInsets.all(10.0),
  //               ),
  //               Container(
  //                 decoration: BoxDecoration(
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.cyan,
  //                         blurRadius: 10.0,
  //                         spreadRadius: 7.0,
  //                         offset: Offset(
  //                           5.0, // Move to right 10  horizontally
  //                           5.0, // Move to bottom 5 Vertically
  //                         ),)
  //                     ]
  //                 ),
  //                 child:Column(
  //                   children: [
  //                     Text('Party'),
  //                     Text('Plan a party with unlimited people'),
  //                     Text('ksh 5000/month'),
  //                     RaisedButton(
  //                       onPressed:(){} ,
  //                       child: Text('Buy subscription'),
  //                       color: Colors.cyan,
  //                     )
  //                   ],
  //                 ),
  //                 padding: EdgeInsets.all(10.0),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('close',style: TextStyle(color: Colors.black54),),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // return SafeArea(
    //   child: Scaffold(
    //     body:SingleChildScrollView(
    //       child: ListBody(
    //         children: <Widget>[
    //           Container(
    //             decoration: BoxDecoration(
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.cyan,
    //                     blurRadius: 10.0,
    //                     spreadRadius: 7.0,
    //                     offset: Offset(
    //                       5.0, // Move to right 10  horizontally
    //                       5.0, // Move to bottom 5 Vertically
    //                     ),)
    //                 ]
    //             ),
    //             child:Column(
    //               children: [
    //                 Text('Standard'),
    //                 Text('Get to meet people in standard platform'),
    //                 Text('ksh 100/month'),
    //                 RaisedButton(
    //                   onPressed:(){
    //                     processPayment();
    //                     // Navigator.push(context,
    //                     //     MaterialPageRoute(builder: (BuildContext context) => SubscriptionPayment()));
    //                   } ,
    //                   child: Text('Buy subscription'),
    //                   color: Colors.cyan,
    //                 )
    //               ],
    //             ),
    //             padding: EdgeInsets.all(10.0),
    //           ),
    //           Container(
    //             decoration: BoxDecoration(
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.cyan,
    //                     blurRadius: 10.0,
    //                     spreadRadius: 7.0,
    //                     offset: Offset(
    //                       5.0, // Move to right 10  horizontally
    //                       5.0, // Move to bottom 5 Vertically
    //                     ),)
    //                 ]
    //             ),
    //             child:Column(
    //               children: [
    //                 Text('Premium'),
    //                 Text('Get to meet people in premium platform'),
    //                 Text('ksh 1000/month'),
    //                 RaisedButton(
    //                   onPressed:(){} ,
    //                   child: Text('Buy subscription'),
    //                   color: Colors.cyan,
    //                 )
    //               ],
    //             ),
    //             padding: EdgeInsets.all(10.0),
    //           ),
    //           Container(
    //             decoration: BoxDecoration(
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.cyan,
    //                     blurRadius: 10.0,
    //                     spreadRadius: 7.0,
    //                     offset: Offset(
    //                       5.0, // Move to right 10  horizontally
    //                       5.0, // Move to bottom 5 Vertically
    //                     ),)
    //                 ]
    //             ),
    //             child:Column(
    //               children: [
    //                 Text('Party'),
    //                 Text('Plan a party with unlimited people'),
    //                 Text('ksh 5000/month'),
    //                 RaisedButton(
    //                   onPressed:(){} ,
    //                   child: Text('Buy subscription'),
    //                   color: Colors.cyan,
    //                 )
    //               ],
    //             ),
    //             padding: EdgeInsets.all(10.0),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  width: width *0.99,
                  height:height*0.3,
                  child: Card(
                    color: Colors.white54,
                    elevation: 10.0,
                    shadowColor: Colors.cyan,
                    child: Column(
                      children: [
                        Text('Standard'),
                        Text('Meet people on Standard  platform'),
                        Row(
                          children: [
                            FlatButton(onPressed: (){processPayment();}, child: Text('KES 100/month'),color: Colors.cyanAccent),
                            FlatButton(onPressed: () => {processPayment()}, child: Text('KES 1100/year'),color: Colors.cyanAccent)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: width *0.99,
                  height:height*0.3,
                  child: Card(
                    color: Colors.white54,
                    elevation: 10.0,
                    shadowColor: Colors.cyan,
                    child: Column(
                      children: [
                        Text('Premium'),
                        Text('Meet people on Premium  platform'),
                        Row(
                          children: [
                            FlatButton(onPressed: null, child: Text('KES 500/month'),color: Colors.cyanAccent,),
                            FlatButton(onPressed: null, child: Text('KES 5600/year'),color: Colors.cyanAccent)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: width *0.99,
                  height:height*0.3,
                  child: Card(
                    color: Colors.white54,
                    elevation: 10.0,
                    shadowColor: Colors.cyan,
                    child: Column(
                      children: [
                        Text('VIP package'),
                        Text('Meet people on V.I.P package  platform'),
                        Row(
                          children: [
                            FlatButton(onPressed: null, child: Text('KES 999/month'),),
                            FlatButton(onPressed: null, child: Text('KES 11000/year'),)
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
}

  Future<dynamic> processPayment() async{
    dynamic transactionInitialisation;


    // final Uri uri = Uri.parse("https://hookie-twitter.herokuapp.com/api/v1/mpesa/callback");
    // final Uri baseUri = Uri.parse("https://hookie-twitter.herokuapp.com/api/v1/mpesa/");


    //Wrap it with a try-catch
    try {
      //Run it
      transactionInitialisation =
      await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: '174379',
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: '254 113055305',
          partyB: '174379',
          callBackURL:Uri(
            scheme: 'https',
            host: 'hookie-twitter.herokuapp.com',
            path: 'api/v1/mpesa/callback'
          ) ,
          accountReference: 'she',
          phoneNumber: phone,
          baseUri: Uri(
            scheme: 'https',
            host: 'sandbox.safaricom.co.ke',
            path: 'mpesa/stkpush/v1/processrequest'
          ),
          transactionDesc: 'purc',
          passKey: 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');


      var result = transactionInitialisation as Map<String, dynamic>;
      if(result.keys.contains("ResponseCode")){
        String _reponseCode = result["ResponseCode"];
        debugPrint(_reponseCode);
        if(_reponseCode == "0"){
          subscription.resultDescription  = result["ResponseDescription"];
        }
      }
      
      debugPrint('TRANSCACTION INITIALIZATIONNNNNNNNNNNNNNNNNNNNNNNN' +transactionInitialisation.toString()    );

    } catch (e) {
      debugPrint('TRANSCACTION ERRORRRRRR $transactionInitialisation');
      //you can implement your exception handling here.
      //Network unreachability is a sure exception.
      print(e.getMessage());
    }
  }
}
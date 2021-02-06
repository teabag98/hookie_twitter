import 'dart:convert';

import 'package:hookie_twitter/src/models/subscription.dart';
import 'package:hookie_twitter/src/models/user.dart';
import 'package:hookie_twitter/src/service_locator.dart';
import 'package:hookie_twitter/src/utils/sharedprefsutil.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiService {

  final String api = 'https://hookie-twitter.herokuapp.com/api/v1';
  final Logger log = sl.get<Logger>();

  final SharedPrefsUtil db = sl.get<SharedPrefsUtil>();


  User user = User();
  Subscription subscription = Subscription();

  Future<dynamic> login({String username, String password}) async {
    final response = await http.post(
      '$api/login',
      body: {"username": username, "password": password},
    );

    log.d(response.statusCode);

    var apiResponse = jsonDecode(response.body);

    log.d(apiResponse);

    if (response.statusCode == 200) {
      if (apiResponse['result'] == 'success') {
        user.id = apiResponse['data']['id'];
        user.username = apiResponse['data']['username'];
        user.email = apiResponse['data']['email'];
        user.referralCode = apiResponse['data']['referal_code'];
        user.phone = apiResponse['data']['phone'].toString();
        user.profileComplete =
            apiResponse['data']['is_profile_complete'].toString();
        user.createdAt = apiResponse['data']['date_joined'];
        user.profilePic = apiResponse['data']['profile_pic'];

        await db.setUser(user);

        return true;
      } else {
        return apiResponse['message'];
      }
    } else {
      return 'An error occured';
    }
  }

  Future<dynamic> register(
      {String username, String password, String phone, String email,String gender}) async {
    final response = await http.post('$api/register', body: {
      'username': username,
      'password': password,
      'phone': phone,
      'email': email,
      'gender':gender
    });

    log.d(response.statusCode);

    var apiResponse = jsonDecode(response.body);

    log.d(apiResponse);

    if (response.statusCode == 200) {
      if (apiResponse['result'] == 'success') {
        user.id = apiResponse['data']['id'];
        user.username = apiResponse['data']['username'];
        user.email = apiResponse['data']['email'];
        user.referralCode = apiResponse['data']['referal_code'];
        user.phone = apiResponse['data']['phone'].toString();
        user.profileComplete =
            apiResponse['data']['is_profile_complete'].toString();
        user.createdAt = apiResponse['data']['date_joined'];
        user.profilePic = apiResponse['data']['profile_pic'];
        user.latitude = apiResponse['data']['latitude'].toString();
        user.longitude = apiResponse['data']['longitude'].toString();

        await db.setUser(user);

        return true;
      } else {
        return apiResponse['message'];
      }
    } else {
      return 'An error occured';
    }
  }
  Future<dynamic> updateLocation(
      {bool state, String latitude, String longitude}) async {
    int uid;

    if (user.id != null) {
      uid = user.id;
    } else {
      await db.getUser().then((userDetails) {
        user = userDetails;
        uid = userDetails.id;
      });
    }

    final response = await http.post('$api/location/update/$uid', body: {
      'longitude': longitude,
      'latitude': latitude,
      'is_online': state.toString(),
    });

    log.d(response.statusCode);

    var apiResponse = jsonDecode(response.body);

    log.d(apiResponse);

    if (response.statusCode == 200) {
      if(apiResponse['result'] == 'success'){
        user.latitude = apiResponse['data']['latitude'].toString();
        user.longitude = apiResponse['data']['longitude'].toString();
        log.d('success','location updates');
        return true;

              if(apiResponse['result'] == 'success'){
        user.latitude = apiResponse['data']['latitude'];
        user.longitude = apiResponse['data']['longitude'];
        return true;

      }
      }
      else{
        return apiResponse['message'];
      }
     }else {
      return 'An error occurred';
    }
  }
}


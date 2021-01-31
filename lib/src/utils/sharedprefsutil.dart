import 'package:hookie_twitter/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtil {
  static const String first_launch_key = 'first_launch';
  static const String user_account = 'user_account';

  // For plain-text data
  Future<void> set(String key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    } else if (value is List<String>) {
      sharedPreferences.setStringList(key, value);
    }
  }

  Future<dynamic> get(String key, {dynamic defaultValue}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.get(key) ?? defaultValue;
  }

  Future<void> setFirstLaunch() async {
    return await set(first_launch_key, false);
  }

  Future<bool> getFirstLaunch() async {
    return await get(first_launch_key, defaultValue: true);
  }

  Future<void> setUser(User user) async {
    List<String> userList = List<String>();
    userList.add(user.id.toString());
    userList.add(user.username.toString());
    userList.add(user.email.toString());
    userList.add(user.phone.toString());
    userList.add(user.profilePic.toString());
    userList.add(user.createdAt.toString());
    userList.add(user.profileComplete.toString());
    userList.add(user.referralCode.toString());

    return await set(user_account, userList);
  }

  Future<User> getUser() async {
    List<dynamic> userList = await get(user_account, defaultValue: null);

    User user = User();

    if (userList != null) {
      user.id = int.parse(userList.elementAt(0));
      user.username = userList.elementAt(1);
      user.email = userList.elementAt(2);
      user.phone = userList.elementAt(3);
      user.profilePic = userList.elementAt(4);
      user.createdAt = userList.elementAt(5);
      user.profileComplete = userList.elementAt(6);
      user.referralCode = userList.elementAt(7);
    }

    return user;
  }

  // For logging out
  Future<void> deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(user_account);

    // await prefs.remove(first_launch_key);
  }
}

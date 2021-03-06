/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/23/20, 11:30 PM
 */

import 'package:flutter_base_app/core/const/keys.dart';
import 'package:flutter_base_app/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

  void setActiveMember(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(Keys.KEY_USER_ID, user.id);
    prefs.setBool(Keys.KEY_USER_LOGIN_STATUS, true);
  }

  Future<int> getActiveMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Keys.KEY_USER_ID) ?? 0;
  }

  Future<bool> getLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Keys.KEY_USER_LOGIN_STATUS) ?? false;
  }

  Future<bool> signOutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(Keys.KEY_USER_ID);
    prefs.remove(Keys.KEY_USER_LOGIN_STATUS);
    bool result = false;
    if (prefs.containsKey(Keys.KEY_USER_ID) && prefs.containsKey(Keys.KEY_USER_LOGIN_STATUS)) {
      result = false;
    } else {
      return true;
    }
    return result;
  }

}
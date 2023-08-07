import 'package:flutter/material.dart';
import 'package:foyer/base/base.dart';
import 'package:foyer/base/base_vm.dart';
import 'package:foyer/res/prefs.dart';
import 'package:foyer/utils/logs.dart';

import '../../data/models/user_model.dart';

class HomeVM extends BaseVM {
  HomeVM(){
    getUsers();
  }
  AppState loginState = AppState.nothing;
  final latController = TextEditingController();
  final longController = TextEditingController();
  double? lat;
  double? long;
  UserModel? user;
  List<UserModel> userList = [];

  getUsers() {
    try{
      userList.clear();
      List<String>? users = Prefs.getUsers();
      if(users == null) {
        return;
      }
      for(String i in users) {
        UserModel? user = Prefs.getUser(i);
        if(user!=null) {
          userList.add(user);
        }
      }
    }catch(e) {
      logE(e);
    }

  }

  Future<bool?> login(context) async {
    loginState = AppState.loading;
    notifyListeners();
    await delay();
    lat = double.tryParse(latController.text);
    long = double.tryParse(longController.text);
    try {
      if (Prefs.getUser('$lat-$long') == null) {
        loginState = AppState.success;
        notifyListeners();
        await delay();
        return false;
      }
    } catch (e, stacktrace) {
      logError(e, stacktrace);
      toast(context, 'Unable to fetch profile');
      loginState = AppState.error;
      notifyListeners();
      clear();
      return null;
    }
    loginState = AppState.success;
    notifyListeners();
    await delay();
    return true;
  }

  createUser(context) async {
    if (lat == null || long == null) {
      toast(context, 'Please enter the latitude');
      return;
    }
    user = UserModel(
        lat: lat!,
        long: long!,
        theme: ThemeType.light.name,
        color: Colors.black.value,
        textSize: 14);
    if (!await Prefs.setUser(user!)) {
      clear();
      toast(context, 'Unable to Create Profile');
    }
    getUsers();
    notifyListeners();
  }

  switchToUser(context) async {
    try {
      user = Prefs.getUser('$lat-$long');
    } catch (e) {
      toast(context,
          'Profile Data corrupted, creating a new profile with default settings');
      createUser(context);
    }
    notifyListeners();
  }

  saveUser(context) async {
    try {
      if(!await Prefs.setUser(user!)){
        throw '';
      }
    } catch (e) {
      toast(context, 'Unable to update');
    }
    getUsers();
  }

  setTheme(context, String theme) {
    user!.theme = theme;
    notifyListeners();
    saveUser(context);
  }

  setColor(context, int val) {
    user!.color = val;
    notifyListeners();
    saveUser(context);
  }

  setTextSize(context, int val) {
    user!.textSize = val;
    notifyListeners();
    saveUser(context);
  }

  @override
  clear() {
    lat = null;
    long = null;
    user = null;
    notifyListeners();
  }
}

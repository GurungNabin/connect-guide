import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'preferences.dart';

class SharedPreferenceHelper {
  final Preference _sharedPreference;

  const SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<void> saveAuthToken(String authToken) async {
    await _sharedPreference.setString(PrefKeys.authToken, authToken);
  }

  String? get authToken {
    return _sharedPreference.getString(PrefKeys.authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(PrefKeys.authToken);
  }

  Future<bool> removeUserToken() async {
    return _sharedPreference.remove(PrefKeys.userToken);
  }

  Future<void> saveIsLoggedIn(bool value) async {
    await _sharedPreference.setBool(PrefKeys.isLoggedIn, value);
  }

  bool get isLoggedIn {
    return _sharedPreference.getBool(PrefKeys.isLoggedIn) ?? false;
  }

  Future<void> saveSustainabilityData(
      int numberOfFamilyMembers, int zipCode) async {
    print("saving");
    print("shared $_sharedPreference");
    print(numberOfFamilyMembers);
    await _sharedPreference.setInt(
        PrefKeys.sustainabilityFamilySize, numberOfFamilyMembers);
    await _sharedPreference.setInt(PrefKeys.sustainabilityZipCode, zipCode);
    print("saved");
  }

  get getSustainabilityDataFamilySizeAndZipCode async {
    // final prefs = await SharedPreferences.getInstance();
    final prefs = await SharedPreferences.getInstance();

    print("shared $_sharedPreference");
    print(
        "data ${_sharedPreference.getInt(PrefKeys.sustainabilityFamilySize)} ");
    return [
      prefs.getInt(PrefKeys.sustainabilityFamilySize) ?? 0,
      prefs.getInt(PrefKeys.sustainabilityZipCode) ?? 0
    ];
  }

  Future<void> clear() async {
    await _sharedPreference.clear();
  }

  Future<void> saveUserTrackingData(
      String start_date, String end_date, String page_name) async {
    _sharedPreference.setString('startDate', start_date);
    _sharedPreference.setString('endTo', end_date);
    _sharedPreference.setString('pageName', page_name);
  }
}

mixin PrefKeys {
  static const String isLoggedIn = "isLoggedIn";
  static const String authToken = 'authToken';
  static const String userToken = 'user_token';
  static const String defaultDataHint = 'defaultDataHint';
  static const String sustainabilityFamilySize = 'sustainabilityFamilySize';
  static const String sustainabilityZipCode = 'sustainabilityZipCode';
}

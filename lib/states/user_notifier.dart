import 'package:carrotexample/constants/shared_pref_keys.dart';
import 'package:carrotexample/data/user_model.dart';
import 'package:carrotexample/repo/user_service.dart';
import 'package:carrotexample/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends ChangeNotifier {
  UserNotifier() {
    initUser();
  }

  User? _user;
  UserModel? _userModel;

  void initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      await _setNewUser(user);
      notifyListeners();
    });
  }

  Future _setNewUser(User? user) async {
    _user = user;
    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String address = prefs.getString(SHARED_ADDRESS) ?? "";
      double lat = prefs.getDouble(SHARED_LAT) ?? 0;
      double lng = prefs.getDouble(SHARED_LNG) ?? 0;
      String phoneNumber = user.phoneNumber!;
      String userKey = user.uid;

      UserModel userModel = UserModel(
          userKey: "",
          PhoneNumber: phoneNumber,
          address: address,
          geoFirePoint: GeoFirePoint(lat, lng),
          createDate: DateTime.now());

      await UserService().createNewUser(userModel.toJson(), userKey);
      _userModel = await UserService().getUserModel(userKey);
      logger.d(_userModel!.toJson().toString());
    }
  }

  User? get user => _user;
  UserModel? get userModel => _userModel;
}

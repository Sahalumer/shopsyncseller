import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopsyncseller/utils/constants/store_user.dart';

class SharedPrefService {
  Future<void> saveUid(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    globalUid = uid;
    await prefs.setString('uid', uid);
  }

  Future<String?> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

import 'package:flutter/foundation.dart';
import 'package:userlist/models/user_model.dart';
import 'package:userlist/services/api_services.dart';

class UserProvider extends ChangeNotifier{
  final _service = ApiService();
  bool isLoading = false;
  List<Users> _userDatas = [];
  List<Users> get userDatas => _userDatas;

  Future<void> getAllUsers() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getUserdetails();

    _userDatas = response;
    isLoading = false;
    notifyListeners();
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:userlist/models/user_model.dart';

class ApiService {
  Future<List<Users>> getUserdetails() async{
    final urls = 'https://jsonplaceholder.typicode.com/users';
    var response = await http.get(Uri.parse(urls));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      List<Users> data =  body.map<Users>((e) => Users.fromJson(e)).toList();
      return data;
    } else {
      List<Users> data = [];
      return data;
    }
  }
}
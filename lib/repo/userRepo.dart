import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:astegni/repo/model/user.dart';

class AuthRepository {
  bool demoCondition = false;

  Future<User> getRequest() async {
    print('sending requeest');
    final response =
        await http.get(Uri.parse('http://192.168.43.194:8000/api/posts'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<User> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        // Uri.parse('http://192.168.42.115:8000/api/login'),
        Uri.parse('http://192.168.43.194:8000/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        return User.fromJson2(jsonDecode(response.body));
      } else {
        throw Exception('User does not exist.');
      }
    } catch (e) {
      throw Exception('Connection error.');
    }
  }

  Future<User> registerUser(List<String> statevalue) async {
    try {
      final response = await http.post(
        //Uri.parse('http://192.168.42.115:8000/api/register'),
        Uri.parse('http://192.168.43.194:8000/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': statevalue[0],
          'email': statevalue[1],
          'password': statevalue[2]
        }),
      );
      if (response.statusCode == 200) {
        return User.fromJson2(jsonDecode(response.body));
      } else {
        throw Exception('User does not exist.');
      }
    } catch (e) {
      throw Exception('Connection error.');
    }
  }
}

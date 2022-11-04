import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/random_data_model.dart';

class UserAPI {
  UserAPI._();

  static final UserAPI userAPI = UserAPI._();

  Future<RandomData?> fetchUserAPI() async {
    String url = "https://randomuser.me/api/";

    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(res.body);

      RandomData randomData = RandomData.fromJSON(json: decodedData);
      return randomData;
    }
    return null;
  }
}
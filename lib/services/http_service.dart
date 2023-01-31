import 'dart:convert';

import 'package:http/http.dart';
import 'package:user_data_app/model/user_data_list.dart';

import '../utils/api_string.dart';

class HttpService {
  Future<List<Result>> getUserDataResponse() async {
    Response res = await get(Uri.parse(ApiUtils.BASE_URL + ApiUtils.people));
    if(res.statusCode == 200) {
      UserDataList userDataList = UserDataList.fromJson(jsonDecode(res.body));
      List<Result> user = [];
      user.addAll(userDataList.results!);
      print(user);
      return user;
    } else {
      throw "No Data Found";
    }
  }
}
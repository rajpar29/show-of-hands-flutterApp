import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:show_of_hands/models/pollsBrowse/pollModel.dart';
import 'package:show_of_hands/models/userlogin/UserLoginSignupModel.dart';

class Service {
  Map<String, String> headers = {};

  Future<List<PollModel>> getAllPolls() async {
    final response = await http.get('http://192.168.43.95:8091/polls/allPolls',
        headers: headers);
    List polls = jsonDecode(response.body);
    List<PollModel> pollList = [];
    for (var poll in polls) {
      pollList.add(PollModel.fromJson(poll));
    }
    print(pollList);
    return pollList;
  }

  Future<PollModel> upvote(String postId) async {
    String cookieString;
    cookieString = await getSessionCookie();
    // print("upvote request " + cookieString);
    final response = await http.get(
        'http://192.168.43.95:8091/polls/upvote/' + postId,
        headers: {"cookie": cookieString});
    print(response.body);
    return PollModel.fromJson(jsonDecode(response.body));
  }

  Future<PollModel> downvote(String postId) async {
    String cookieString;
    cookieString = await getSessionCookie();
    // print("upvote request " + cookieString);
    final response = await http.get(
        'http://192.168.43.95:8091/polls/downvote/' + postId,
        headers: {"cookie": cookieString});
    print(response.body);
    return PollModel.fromJson(jsonDecode(response.body));
  }

  Future<http.Response> createComment(String comment, String postId) async {
    String cookieString;
    cookieString = await getSessionCookie();
    print('http://192.168.43.95:8091/polls/makeComment/' + postId);
    final response = await http.post(
        'http://192.168.43.95:8091/polls/makeComment/' + postId,
        body: {"comment": comment},
        headers: {"cookie": cookieString});
    print(response.statusCode);
    return response;
  }

  Future<int> userLogin(String username, String password) async {
    UserLoginSignupModel user =
        UserLoginSignupModel(username: username, password: password);
    final response = await http
        .post('http://192.168.43.95:8091/users/userLogin', body: user.toJson());
    // print(response.statusCode);
    updateCookie(response);

    return response.statusCode;
  }

  Future<int> userCreation(String username, String password) async {
    UserLoginSignupModel user =
        UserLoginSignupModel(username: username, password: password);
    final response = await http.post(
        'http://192.168.43.95:8091/users/createUser',
        body: user.toJson());
    // print(response.statusCode);
    return response.statusCode;
  }

  Future updateCookie(http.Response response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
    // print("--------"+headers['cookie']);
    await prefs.setString('login-cookie', headers['cookie']);
    // print("Stored in Shared prefs "+ prefs.getString('login-cookie'));
  }

  Future<String> getSessionCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cookie = prefs.getString('login-cookie');
    return cookie;
  }

  Future<dynamic> getCurrentUser() async {
    String cookieString;
    cookieString = await getSessionCookie();
    final response = await http.get(
        'http://192.168.43.95:8091/users/getUserDetail',
        headers: {"cookie": cookieString});
    return jsonDecode(response.body);
  }
}

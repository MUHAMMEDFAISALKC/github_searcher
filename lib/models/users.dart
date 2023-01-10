import 'package:github_searcher/models/repos.dart';
import 'package:http/http.dart';

class User {
  String? userName;
  String? imageUrl;
  String? profileUrl;
  RepoCount? repoCount;

  User({this.userName, this.imageUrl, this.profileUrl, this.repoCount});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['login'],
      imageUrl: json['avatar_url'],
      profileUrl: json['url'],
    );
  }
}

class AllUsers {
  List<User>? allUsers;

  AllUsers({this.allUsers});

  factory AllUsers.fromJson(Map<String, dynamic> json) {
    List<User> users;
    List<dynamic> rawUsers = json['items'];
    users = rawUsers.map((u) => User.fromJson(u)).toList();
    return AllUsers(allUsers: users);
  }
}

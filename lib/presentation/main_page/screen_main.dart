import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:github_searcher/core/constants.dart';
import 'package:github_searcher/models/repos.dart';
import 'package:github_searcher/models/users.dart';
import 'package:github_searcher/presentation/main_page/widgets/search_idle.dart';
import 'package:http/http.dart' as http;

final searchTextController = TextEditingController();
User a = User();
// User a = User(
//     userName: 'a',
//     imageUrl: 'https://avatars.githubusercontent.com/u/1410106?v=4');
AllUsers all_Users = AllUsers();
ValueNotifier<AllUsers> newUserList = ValueNotifier(all_Users);

class ScreenMain extends StatelessWidget {
  ScreenMain({super.key});

  ValueNotifier<String> searchTextNotifier =
      ValueNotifier(searchTextController.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'GitHub Searcher',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: searchTextNotifier,
          builder: (context, newValue, _) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    heightBox10,
                    CupertinoSearchTextField(
                      controller: searchTextController,
                      placeholder: 'Search for Users',
                      onChanged: (value) {
                        searchTextNotifier.value = value;
                        searchTextNotifier.notifyListeners();
                        if (value.isNotEmpty) {
                          fetchUsers(value);
                        }
                      },
                    ),
                    heightBox10,
                    Expanded(child: SearchIdle())
                  ],
                ),
              ),
            );
          }),
    );
  }
}

Future<void> fetchUsers(String user) async {
  final url = Uri.parse('https://api.github.com/search/users?q=$user');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    //print(response.body);
    newUserList.value = await AllUsers.fromJson(json.decode(response.body));
    newUserList.notifyListeners;
    print(newUserList.value.allUsers);
    // Repo count
    await newUserList.value.allUsers!.map((e) async {
      final repoUrl = Uri.parse('https://api.github.com/users/${e.userName}');
      print(repoUrl);
      final responseRe = await http.get(repoUrl);
      if (responseRe.statusCode == 200) {
        final repoCount =
            await RepoCount.fromJson(json.decode(responseRe.body));
        e.repoCount = repoCount;
      } else {
        print('repocount failed');
        throw Exception('failed to fetch repo');
      }
    });
  } else {
    throw Exception('failed to fetch users');
  }
}

/*
Future<void> fetchRepoCount(String urlLink) async {
  final url = Uri.parse('https://api.github.com/users/$urlLink');

  if (response.statusCode == 200) {
    final repoCount = await RepoCount.fromJson(json.decode(response.body));
    repoCountNotifier.value.add(repoCount);
    repoCountNotifier.notifyListeners;
    print(repoCountNotifier.value);
  } else {
    throw Exception('failed to fetch users');
  }
}
*/

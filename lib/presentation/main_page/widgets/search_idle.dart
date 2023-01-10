import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:github_searcher/models/repos.dart';
import 'package:github_searcher/models/user_profile.dart';
import 'package:github_searcher/presentation/main_page/screen_main.dart';
import 'package:github_searcher/presentation/profile_page/screen_profile.dart';
import 'package:github_searcher/presentation/profile_page/widgets/repo_idle.dart';
import 'package:http/http.dart' as http;

ValueNotifier<List<RepoCount>> repoCountNotifier = ValueNotifier([RepoCount()]);

class SearchIdle extends StatelessWidget {
  const SearchIdle({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: newUserList,
        builder: (context, newList, child) {
          return (newList != null)
              ? (newUserList.value.allUsers != null)
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return SearchResultTile(
                          index: index,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: newList.allUsers!.length ?? 10)
                  : SizedBox()
              : SizedBox();
        });
  }
}

class SearchResultTile extends StatelessWidget {
  final int index;

  const SearchResultTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    //fetchRepoCount(newUserList.value.allUsers![index].profileUrl!);
    return ListTile(
        onTap: () async {
          print(newUserList.value.allUsers![index].profileUrl!);
          await fetchProfile(newUserList.value.allUsers![index].profileUrl!);
          await fetchRepo(newUserList.value.allUsers![index].userName!);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ScreenProfile(
                name: newUserList.value.allUsers![index].userName!);
          }));
        },
        leading: CircleAvatar(
          backgroundColor: Colors.amber,
          backgroundImage:
              NetworkImage(newUserList.value.allUsers![index].imageUrl!),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            newUserList.value.allUsers![index].userName!,
            style: TextStyle(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: //Text('Repo: $index')
            Text('Repo: ${newUserList.value.allUsers![index].repoCount}'));
  }
}

Future<void> fetchProfile(String urlLink) async {
  final url = Uri.parse(urlLink);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    //print(response.body);
    userProfileListNotifier.value =
        await UserProfile.fromJson(json.decode(response.body));
    userProfileListNotifier.notifyListeners;
    print(userProfileListNotifier.value);
  } else {
    throw Exception('failed to fetch users');
  }
}

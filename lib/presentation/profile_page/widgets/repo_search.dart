import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_searcher/models/repos.dart';
import 'package:github_searcher/presentation/profile_page/screen_profile.dart';
import 'package:github_searcher/presentation/profile_page/widgets/repo_idle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

ValueNotifier<AllRepos> allRepoSearchNotifier = ValueNotifier(AllRepos());

class RepoListSearch extends StatelessWidget {
  const RepoListSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: allRepoSearchNotifier,
        builder: (context, newValue, child) {
          return (newValue.allRepos != null)
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    return RepoTile(index: index);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: newValue.allRepos!.length)
              : Text('No Match found');
        });
  }
}

class RepoTile extends StatelessWidget {
  final int index;

  const RepoTile({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _launchUrl(allRepoSearchNotifier.value.allRepos![index].htmlUrl!);
        //Navigator.of(context).push();
      },
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${allRepoSearchNotifier.value.allRepos![index].fork!} Fork',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '${allRepoSearchNotifier.value.allRepos![index].stargazersCount!} Star',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      leading: Text(
        '${allRepoSearchNotifier.value.allRepos![index].name!}',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

Future<void> _launchUrl(String pageUrl) async {
  final Uri url = Uri.parse(pageUrl);
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

Future<void> fetchRepoSearch(String text) async {
  final url = Uri.parse('https://api.github.com/search/repositories?q=$text');
  print(url);
  final response = await http.get(url);
  print(allRepoSearchNotifier.value);
  if (response.statusCode == 200) {
    //print(response.body);
    allRepoSearchNotifier.value =
        await AllRepos.fromJson(json.decode(response.body));
    allRepoSearchNotifier.notifyListeners;
    print(allRepoSearchNotifier.value);
  } else {
    throw Exception('failed to fetch users');
  }
}

/*
matchedSorting() async {
  if (allRepoSearchNotifier.value.allRepos != null) {
    allRepoSearchNotifier.value.allRepos!.clear();
  }
  final newRepo = await searchSorting();
  if (allRepoNotifier.value.allRepos != null) {
    for (var r in newRepo) {
      allRepoSearchNotifier.value.allRepos!
          .addAll(allRepoNotifier.value.allRepos!.where((e) => e.name == r));
    }
  }
}

Future<List<String>> searchSorting() async {
  List<String> reposit = [];
  for (var i = 0; i < allRepoNotifier.value.allRepos!.length; i++) {
    reposit.add(allRepoNotifier.value.allRepos![i].name!);
  }
  String input = repoSearchController.text;
  final revisedRepo = await spellCheck(reposit, input);
  print(reposit);
  print(repoSearchController.text);
  // for (var r in revisedRepo) {
  //   print(r);
  // }
  return revisedRepo;
}

Future<List<String>> spellCheck(repos, input) async {
  List<String> matched = [];
  for (var i = 0; i < repos.length; i++) {
    for (var j = 0; j < repos[i].length; j++) {
      if (j < input.length) {
        if (repos[i][j] == input[j]) {
          for (var h = j; h < input.length; h++) {
            if (repos[i][h] == input[h]) {
              continue;
            } else {
              break;
            }
          }
          print(repos[i]);
          matched.add(repos[i]);
        }
      }
    }
  }

  print(matched);
  return matched;
}
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_searcher/models/repos.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

ValueNotifier<AllRepos> allRepoNotifier = ValueNotifier(AllRepos());

class RepoList extends StatelessWidget {
  const RepoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: allRepoNotifier,
        builder: (context, newValue, child) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return RepoTile(index: index);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: newValue.allRepos!.length);
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
        _launchUrl(allRepoNotifier.value.allRepos![index].htmlUrl!);
        //Navigator.of(context).push();
      },
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${allRepoNotifier.value.allRepos![index].fork!} Fork',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '${allRepoNotifier.value.allRepos![index].stargazersCount!} Star',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      leading: Text(
        '${allRepoNotifier.value.allRepos![index].name!}',
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

Future<void> fetchRepo(String name) async {
  final url = Uri.parse('https://api.github.com/users/$name/repos');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    //print(response.body);
    allRepoNotifier.value = await AllRepos.fromJson(json.decode(response.body));
    allRepoNotifier.notifyListeners;
    print(allRepoNotifier.value);
  } else {
    throw Exception('failed to fetch users');
  }
}

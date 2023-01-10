import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:github_searcher/core/constants.dart';
import 'package:github_searcher/models/user_profile.dart';
import 'package:github_searcher/models/users.dart';
import 'package:github_searcher/presentation/main_page/screen_main.dart';
import 'package:github_searcher/presentation/profile_page/widgets/repo_idle.dart';
import 'package:github_searcher/presentation/profile_page/widgets/repo_search.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

final repoSearchController = TextEditingController();
ValueNotifier<UserProfile> userProfileListNotifier =
    ValueNotifier(UserProfile());

class ScreenProfile extends StatelessWidget {
  final String name;

  ScreenProfile({super.key, required this.name});

  final repoPage = [
    RepoList(),
    RepoListSearch(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
            valueListenable: userProfileListNotifier,
            builder: (context, profileValue, _) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 15),
                            height: 190,
                            width: screenSize.width / 3,
                            child: CircleAvatar(
                              backgroundColor: Colors.amber,
                              child: Image(
                                  image: NetworkImage(
                                profileValue.imageUrl!,
                              )),
                            ),
                          ),
                          Container(
                            //height: 190,
                            width: screenSize.width / 2 + 25,
                            //color: Colors.amberAccent,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'UserName: ${profileValue.name}',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Email: ${profileValue.email ?? ''}",
                                    style: TextStyle(fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Location: ${profileValue.location ?? ''}",
                                    style: TextStyle(fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Join Date: ${profileValue.joinDate ?? ''}",
                                    style: TextStyle(fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Followers: ${profileValue.followers ?? ''}",
                                    style: TextStyle(fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Following: ${profileValue.following ?? ''}",
                                    style: TextStyle(fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      heightBox20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        textDirection: TextDirection.ltr,
                        verticalDirection: VerticalDirection.down,
                        children: [
                          Container(
                            width: screenSize.width - 50,
                            child: Text(
                              "${profileValue.biography ?? ''}",
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      heightBox20,
                      CupertinoSearchTextField(
                        onChanged: (value) {
                          //repoSearchController.text = value;
                          if (value.isNotEmpty) {
                            fetchRepoSearch('${profileValue.name!}/$value');
                            //searchSorting();
                          } else {
                            fetchRepo(profileValue.name!);
                          }
                        },
                        controller: repoSearchController,
                        placeholder: "Search for User's Repositories",
                      ),
                      heightBox20,
                      (repoSearchController.text.isEmpty)
                          ? Expanded(child: repoPage[0])
                          : Expanded(child: repoPage[1])
                    ],
                  ),
                ),
              );
            }));
  }
}

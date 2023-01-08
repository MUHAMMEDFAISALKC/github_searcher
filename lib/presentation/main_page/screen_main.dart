import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:github_searcher/core/constants.dart';
import 'package:github_searcher/presentation/main_page/widgets/search_idle.dart';

class ScreenMain extends StatelessWidget {
  ScreenMain({super.key});

  final searchTextController = TextEditingController();

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              heightBox10,
              CupertinoSearchTextField(
                controller: searchTextController,
                placeholder: 'Search for Users',
              ),
              heightBox10,
              Expanded(child: SearchIdle())
            ],
          ),
        ),
      ),
    );
  }
}

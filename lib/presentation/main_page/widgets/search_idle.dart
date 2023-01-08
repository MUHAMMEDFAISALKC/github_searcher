import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:github_searcher/presentation/profile_page/screen_profile.dart';

class SearchIdle extends StatelessWidget {
  const SearchIdle({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return SearchResultTile(
            index: index,
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: 50);
  }
}

class SearchResultTile extends StatelessWidget {
  final int index;

  const SearchResultTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ScreenProfile(id: index);
        }));
      },
      leading: CircleAvatar(
        backgroundColor: Colors.amber,
        backgroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/8729670$index?v=4'),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          'UserName $index',
          style: TextStyle(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: Text('Repo: n$index'),
    );
  }
}

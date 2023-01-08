import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScreenProfile extends StatelessWidget {
  final int id;

  const ScreenProfile({super.key, required this.id});

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
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 200,
                  width: screenSize.width / 3 + 10,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Image(
                          image: NetworkImage(
                        'https://avatars.githubusercontent.com/u/8729670$id?v=4',
                      )),
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  width: screenSize.width / 2 + 50,
                  color: Colors.amberAccent,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'UserName: user$id',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Email: user$id',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Location: user$id',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Join Date: user$id',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Followers: user$id',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Following: user$id',
                          style: TextStyle(fontSize: 17),
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
          ],
        ),
      ),
    );
  }
}

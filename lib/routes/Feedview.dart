import 'package:flutter/material.dart';
import 'package:projedeneme/model/post.dart';
import 'package:projedeneme/services/auth.dart';
import 'package:projedeneme/services/db.dart';
import 'package:projedeneme/utils/colors.dart';
import 'package:projedeneme/utils/styles.dart';
import 'package:projedeneme/widget/post_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class FeedView extends StatefulWidget {

  @override
  _FeedViewState createState() => _FeedViewState();
}


class _FeedViewState extends State<FeedView>  {
  List<Post> myPosts = [
    Post(text: 'Sabanci to Kadiköy \nCreated by Arda', date: '5.01.2022', likeCount: 10, commentCount: 5),
    Post(text: 'CaddeBostan to Sabanci\nCreated by Ufuk', date: '26.12.2021', likeCount: 20, commentCount: 10),
    Post(text: 'sabanci to halkalı\nCreated by Irmak', date: '30.12.2021', likeCount: 30, commentCount: 15),
    Post(text: 'Sabanci to Izmir\nCreated by Sergen', date: '5.01.2022', likeCount: 10, commentCount: 5),
    Post(text: 'Kocaeli to Sabanci\nCreated by Ahmet', date: '26.12.2021', likeCount: 20, commentCount: 10),
    Post(text: 'sabanci to Adana\nCreated by Mehmet', date: '30.12.2021', likeCount: 30, commentCount: 15),
    Post(text: 'Sabanci to Ankara\nCreated by Ezgi', date: '5.01.2022', likeCount: 10, commentCount: 5),
    Post(text: 'Maltepe to Sabanci\nCreated by Ayşe', date: '26.12.2021', likeCount: 20, commentCount: 10),
    Post(text: 'Ardahan to Sabanci\nCreated by Fatma', date: '30.12.2021', likeCount: 30, commentCount: 15),


  ];
  int count = 0;
  AuthService auth = AuthService();
  DBService db = DBService();
  void buttonClicked() {
    setState(() {
      count++;
    });
    print('Button Clicked');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('initState');
  }


  @override
  Widget build(BuildContext context) {
    db.addUser('name', 'surname', 'mail', 'token');
    db.addUserAutoID('nameAuto', 'surnameAuto', 'mail@auto', 'token');


    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            auth.signOutFromGoogle();
          },
          icon: Icon(Icons.logout),
        ),
        title: Text("SEARCH BAR", style: kDefaultLabel,),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.yellow,
        centerTitle: true,
        elevation: 0.0,
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.white),
              textTheme: TextTheme().apply(bodyColor: Colors.white),
            ),
            child: PopupMenuButton<int>(
              color: Colors.indigo,
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text('Profile-Page'),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text('Notification Page'),
                ),
              ],
            ),
          ),
        ],
      ),
      body:PageView(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(hintText: "Search"),

                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/explore_page');
                            print("Button pressed");
                          },
                          icon: Icon(
                            Icons.search,
                            size: 40,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 3,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: myPosts.map(
                              (post) =>
                              PostTile(
                                post: post,
                                delete: () {
                                  setState(() {
                                    myPosts.remove(post);
                                  });
                                },)
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );

  }
}
void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Navigator.pushNamed(context, '/profile_page');
      break;
    case 1:
      Navigator.pushNamed(context, '/notification_page');
      break;


  }
}
import 'package:crud_users/src/screens/dashboard.dart';
import 'package:crud_users/src/screens/user_update.dart';
import 'package:crud_users/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modal_delete.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

enum CardAction { delete }

class _UserListState extends State<UserList> {
  late Set<String> userList;

  @override
  void initState() {
    super.initState();
    initUserList();
  }

  initUserList() async {
    userList = SharedPreferencesGlobal.prefs.getKeys();
    for(String user in userList) {
      print(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCardList(userList)
      ],
    );
  }

  Widget _buildCardList(Set<String> userList) {
    List<Widget> cards = [];
    for (var user in userList) {
      if(user != 'admin') {
        cards.add(_buildCard(user));
        cards.add(SizedBox(height: 10,));
      }
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          ...cards
        ],
      ),
    );
  }

  Widget _buildCard(String user) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green
        ),
        onPressed: () {
          Get.to(() => UserUpdate(
            user: user,
          ));
        },
        child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: PopupMenuButton<CardAction>(
                  icon: Icon(Icons.more_horiz, color: Colors.black,),
                  onSelected: (CardAction result) async {
                    switch(result) {
                      case CardAction.delete:
                        await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                ConfirmDeleteModal(
                                    user: user
                                )
                        ).then((value) {
                          Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      Dashboard()
                              )
                          );
                        }).catchError((error) {
                          print(error);
                        });
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<CardAction>>[
                    const PopupMenuItem<CardAction>(
                      value: CardAction.delete,
                      child: Text('Eliminar'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: double.infinity,
                                  child: Text(
                                    user,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ]
        )
    );
  }
}
import 'package:crud_users/src/screens/user_update.dart';
import 'package:crud_users/src/utils/globals.dart';
import 'package:crud_users/src/widgets/logout_button.dart';
import 'package:crud_users/src/widgets/users_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late bool isAdmin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Globals.isAdmin ? _buildAdminBody() : _buildBody(),

      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: LogOutButton(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * .4,
            decoration: BoxDecoration(
                color: Colors.black
            ),
            child: Center(
              child: Text(
                "Hola\n" + Globals.user,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        )
      ],
    );
  }

  Widget _buildAdminBody() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .4,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black
          ),
          child: Center(
            child: Text(
              "Hola, " + Globals.user,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.topRight,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black
                    ),
                    onPressed: () {
                      Get.to(() => UserUpdate(
                      ));
                    },
                    child: Text("Add user")
                ),
              ),
              UserList()
            ],
          ),
        )
      ],
    );
  }
}

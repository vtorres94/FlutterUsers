import 'package:crud_users/src/screens/login.dart';
import 'package:flutter/material.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
          ),
          child: Text(
            'LogOut',
            style: TextStyle(
                fontFamily: 'Mulish, sans-serif',
                fontWeight: FontWeight.bold,
                fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.of(context)
                .push(
                new MaterialPageRoute(
                    builder: (context) =>
                        LoginPage()
                )
            );
          },
        )
    );
  }
}

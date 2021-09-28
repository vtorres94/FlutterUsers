import 'package:crud_users/src/screens/dashboard.dart';
import 'package:crud_users/src/utils/globals.dart';
import 'package:crud_users/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _user = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initAdmin();
  }

  Future<bool> _logIn(String user, String pass) {
    bool logged = false;
    String prefPass = SharedPreferencesGlobal.prefs.getString(user) ?? '';
    print(prefPass);
    print(pass);
    if(pass == prefPass) {
      logged = true;
      Globals.user = user;
      Globals.isAdmin = (user == "admin");
    }
    return Future.value(logged);
  }

  _initAdmin() async {
    SharedPreferencesGlobal.prefs = await SharedPreferences.getInstance();
    await SharedPreferencesGlobal.prefs.setString('admin', 'admin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }


  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF565656),
                Color(0xFF565656),
                Color(0xFF555555),
                Color(0xFF555555),
                Color(0xFF545455),
              ],
            ),
          ),
        ),
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 120.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            image: AssetImage('assets/manali_logo.png'),
                            width: MediaQuery.of(context).size.width * 0.33
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Text(
                          "LogIn",
                          style: TextStyle(
                              fontFamily: 'Mulish, sans-serif',
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        SizedBox(
                            width: 300,
                            // height: 50,
                            child: TextFormField(
                              controller: _user,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Este campo no debe ser vacío';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  labelText: 'User',
                                  labelStyle: TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                      ),
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                      ),
                                      borderRadius: BorderRadius.circular(30)
                                  )
                              ),
                            )
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: _pass,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo no debe ser vacío';
                              }
                              return null;
                            },
                            obscureText: _obscureText,

                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: _obscureText ? Colors.grey : Colors.green,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),

                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontFamily: 'Mulish, sans-serif',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _logIn(_user.text, _pass.text).then((result) {
                                    if(result) {
                                      Navigator.of(context)
                                          .push(
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  Dashboard()
                                          )
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Credenciales incorrectas"
                                            ),
                                            backgroundColor: Colors.red,
                                          )
                                      );
                                    }
                                  }).catchError((error) {
                                    print(error);
                                  });
                                }
                              },
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

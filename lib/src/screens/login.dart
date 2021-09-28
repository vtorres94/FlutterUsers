import 'package:flutter/material.dart';

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
              stops: [0.1, 0.4, 0.7, 0.9],
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
                                  labelText: 'Usuario',
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0XFFA3854F),
                                      ),
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0XFFA3854F),
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
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0XFFA3854F),
                                  ),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0XFFA3854F),
                                  ),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: _obscureText ? Colors.grey : Color(0XFFA3854F),
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
                              onPressed: () => {
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                },
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

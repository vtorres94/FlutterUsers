import 'package:crud_users/src/screens/dashboard.dart';
import 'package:crud_users/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class UserUpdate extends StatefulWidget {
  late String? user;
  UserUpdate({
    Key? key,
    this.user
  }) : super(key: key);

  @override
  UserUpdateState createState() => UserUpdateState();
}

class UserUpdateState extends State<UserUpdate> {
  late bool isNew;
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _user = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _formSignIn = GlobalKey<FormState>();
  bool hidePass = true;
  bool hideConfirmPass = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isNew = widget.user == null;
    _initUser();
  }

  bool getIsNew() {
    return this.isNew;
  }

  Future<bool> saveUser(String user, String pass) async {
    bool save = false;
    String prefPass = SharedPreferencesGlobal.prefs.getString(user) ?? '';
    if(isNew) {
      if(prefPass.length == 0) {
        SharedPreferencesGlobal.prefs.setString(user, pass);
        save = true;
      }
    } else {
      SharedPreferencesGlobal.prefs.setString(user, pass);
      save = true;
    }
    return Future.value(save);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 5),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context)
                .push(
                new MaterialPageRoute(
                    builder: (context) =>
                        Dashboard()
                )
            );
          },
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .4,
          decoration: BoxDecoration(
              color: Colors.black
          ),
          child: Center(
            child: Text(
              isNew ? "Crear" : "Editar",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Form(
                key: _formSignIn,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _user,
                          enabled: isNew,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo no debe ser vacío';
                            }
                            if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                              return 'No es un formato de correo valido!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black),
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
                          if (value.length <= 7){
                            return 'Contraseña debe contener al menos 8 caracteres';
                          }
                          if(!value.contains(RegExp(r'\W')) && RegExp(r'\d+\w*\d+').hasMatch(value)){
                            return 'Contraseña debe contener al menos una mayúscula, una minúscula,\nun número, y 1 caracter especial';
                          }
                          return null;
                        },
                        obscureText: hidePass,
                        decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                hidePass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: hidePass ? Colors.grey : Colors.green,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  hidePass = !hidePass;
                                });
                              },
                            ),
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
                            errorMaxLines: 5
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: _confirmPass,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo no debe ser vacío';
                          }
                          if (value != _pass.text) {
                            return 'Contraseñas deben ser iguales';
                          }
                          return null;
                        },
                        obscureText: hideConfirmPass,
                        decoration: InputDecoration(
                            labelText: 'Confirmar',
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                hideConfirmPass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: hideConfirmPass ? Colors.grey : Colors.green,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  hideConfirmPass = !hideConfirmPass;
                                });
                              },
                            ),
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
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
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
                            isNew ? 'Registrar' : 'Editar',
                            style: TextStyle(
                                fontFamily: 'Mulish, sans-serif',
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ),
                          onPressed: () {
                            if (_formSignIn.currentState!.validate()) {
                              saveUser(_user.text, _pass.text).then((value) {
                                if(value) {
                                  Navigator.of(context)
                                      .push(
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              Dashboard()
                                      )
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                        isNew ? "Usuario ya existe" : "No se ha podido registrar",
                                      ), backgroundColor: Colors.red,)
                                  );
                                }
                              }).catchError((error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(
                                        "error"
                                    ), backgroundColor: Colors.red,)
                                );
                              });
                            }
                          },
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void _initUser() {
    if(!isNew) {
      String user = widget.user!;
      String prefPass = SharedPreferencesGlobal.prefs.getString(user) ?? '';
      setState(() {
        _user.text = user;
        _pass.text = prefPass;
        _confirmPass.text = prefPass;
      });
    }
  }
}

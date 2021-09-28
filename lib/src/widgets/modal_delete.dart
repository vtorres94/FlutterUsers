import 'package:crud_users/src/screens/dashboard.dart';
import 'package:crud_users/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmDeleteModal extends StatefulWidget{
  late final String user;
  ConfirmDeleteModal({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ConfirmDeleteModal createState() => _ConfirmDeleteModal();
}

class _ConfirmDeleteModal extends State<ConfirmDeleteModal>{
  bool showErrorMessage = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: 20,
                top:65,
                right: 20,
                bottom: 20
            ),
            margin: EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topRight,
                end: Alignment(0.3, 2),
                tileMode: TileMode.repeated, // repeats the gradient over the canvas
                colors: [
                  Colors.black,
                  Colors.black,
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Confirmación",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight:
                      FontWeight.bold,
                      letterSpacing: 1
                  ),
                ),
                SizedBox(height: 15,),
                Text(
                  "Desea eliminar al usuario "+ widget.user + "?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold,
                      letterSpacing: 1
                  ),
                  textAlign: TextAlign.center,
                ),
                Visibility(
                  visible: showErrorMessage,
                  child: Text(
                    "Usuario no se ha podido eliminar",
                    style: TextStyle(
                        color: Colors.red
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green
                            ),
                            onPressed: () {
                              SharedPreferencesGlobal.prefs.remove(widget.user)
                                  .then((value) {
                                        if(value) {
                                          Navigator.of(context).pop();
                                        }
                                  })
                                  .catchError((error) {

                                  });

                            },
                            child: Text('borrar'),
                          )
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40,),
              ],
            ),
          ),// bottom part
          Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: Image.asset("assets/manali_logo.png")
              ),
            ),
          )
        ],
      ),

    );
  }

}
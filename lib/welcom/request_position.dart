import 'package:chat_app/welcom/welcom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/firebase/firebase_api.dart';

class RequestPosition extends StatefulWidget {
  const RequestPosition({Key? key}) : super(key: key);

  @override
  State<RequestPosition> createState() => _RequestPositionState();
}

class _RequestPositionState extends State<RequestPosition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Oh no!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "You need to grant location access in order to use Binder.\nPlease try again and tap OK.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19, color: Colors.grey[600]),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                String? result = await FirebaseApi().checkPermissionLocation();
                print(result);
                if (result != 'isDenied' &&
                    result != 'isDeniedForever' &&
                    result != null &&
                    result != 'isNotEnable') {
                  context.pushReplacement('/login-home-screen');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                fixedSize: Size(350, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color.fromRGBO(238, 128, 95, 100),
                      Color.fromRGBO(234, 64, 128, 100),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    "TRY AGAIN",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginWithPhoneNumber extends StatelessWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.west,
            color: Colors.black,
            size: 42,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const Align(
                alignment: Alignment.topLeft,
                child: Text("Can we get\nyour number?",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))),
            const SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Enter your phone numbers ',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'We\'ll text you a code to verify you\'re really you. Message and data rates may apply',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.go('/login/verify_otp');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

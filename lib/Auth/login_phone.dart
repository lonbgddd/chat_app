import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class LoginWithPhoneNumber extends StatefulWidget{
  const LoginWithPhoneNumber({Key? key}) : super(key: key);
  static String verify = '';

  @override
  State<StatefulWidget> createState() {
    return LoginWithPhoneNumberState();
  }

}
class LoginWithPhoneNumberState extends State<LoginWithPhoneNumber>{
  TextEditingController controller = TextEditingController();
  List<Map<String, dynamic>> countryCodes = [
    {'display': 'VN', 'value': '+84'},
    {'display': 'US', 'value': '+1'},
    {'display': 'UK', 'value': '+44'},
    // Thêm các quốc gia khác vào đây
  ];
  String selectedCountry = '+84';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
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
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: const Text('My number is',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26
                    ),),
                ),
                const SizedBox(
                  height: 50,
                ),
                Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            value: selectedCountry.isNotEmpty ? selectedCountry : null,
                            onChanged: (newValue) {
                              setState(() {
                                selectedCountry = newValue!;
                              });
                            },
                            items: countryCodes.map((Map<String, dynamic> item) {
                              return DropdownMenuItem<String>(
                                value: item['value'],
                                child: Text('${item['display']} ${item['value']}'),
                              );
                            }).toList(),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: controller,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10) ,
                                hintText: 'Number phone',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    )
                ),
                Spacer(),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+84384745334',
                            verificationCompleted: (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {
                              print('${e.message} lonme mey');
                            },
                            codeSent: (String verificationId, int? resendToken) {
                              LoginWithPhoneNumber.verify = verificationId;
                              context.go('/login/verify_otp');
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {},
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.deepPurpleAccent,
                        ),
                        child: const Text('SEND THE CODE')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

}

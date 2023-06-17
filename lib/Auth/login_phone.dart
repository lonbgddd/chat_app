import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// class LoginWithPhoneNumber2 extends StatelessWidget {
//
//   LoginWithPhoneNumber2({Key? key}) : super(key: key);
//   var edt_phone = TextEditingController();
//   static String verify ='';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.west,
//             color: Colors.black,
//             size: 42,
//           ),
//           onPressed: () {
//             context.pop();
//           },
//         ),
//       ),
//       body: Container(
//         color: Colors.white,
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//           children: [
//             const Align(
//                 alignment: Alignment.topLeft,
//                 child: Text("Can we get\nyour number?",
//                     style: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black))),
//             const SizedBox(
//               height: 20,
//             ),
//             TextField(
//               controller: edt_phone,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.phone),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 hintText: 'Enter your phone numbers ',
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               'We\'ll text you a code to verify you\'re really you. Message and data rates may apply',
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.black, fontSize: 14),
//             ),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: () async {
//
//                 await FirebaseAuth.instance.verifyPhoneNumber(
//                   phoneNumber: '+84 ${edt_phone.text}',
//                   verificationCompleted: (PhoneAuthCredential credential) {},
//                   verificationFailed: (FirebaseAuthException e) {
//                     print(e.message);
//                   },
//                   codeSent: (String verificationId, int? resendToken) {
//
//                   },
//                   codeAutoRetrievalTimeout: (String verificationId) {},
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.purple,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25))),
//               child: const Padding(
//                 padding: EdgeInsets.all(15.0),
//                 child: Text(
//                   "Continue",
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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

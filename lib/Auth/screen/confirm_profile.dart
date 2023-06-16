import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../../config/changedNotify/resposome.dart';
import '../../config/helpers/enum_cal.dart';
class ConfirmProfile extends StatefulWidget {
  const ConfirmProfile({Key? key}) : super(key: key);

  @override
  State<ConfirmProfile> createState() => _ConfirmProfileState();
}

class _ConfirmProfileState extends State<ConfirmProfile> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final conformPasswordController = TextEditingController();
  final yearController = TextEditingController();
  DateTime time = DateTime.now();

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    conformPasswordController.clear();
    nameController.clear();
    yearController.clear();
    super.dispose();
  }

  SingingCharacter? character = SingingCharacter.man;
  bool isEmailCorrect = false;

  @override
  Widget build(BuildContext context) {
    final formSignUpKey = GlobalKey<FormState>();
    final signUp = context.read<CallDataProvider>();

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
          onPressed: () async{
            await GoogleSignIn().signOut();
            context.pop();
          },
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please sign up to continue using our app',
                    style: GoogleFonts.indieFlower(
                      textStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w300,
                          // height: 1.5,
                          fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: isEmailCorrect ? 640 : 560,
                    // _formKey!.currentState!.validate() ? 200 : 600,
                    // height: isEmailCorrect ? 260 : 182,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Man'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.man,
                            groupValue: character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Women'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.women,
                            groupValue: character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                character = value;
                              });
                            },
                          ),
                        ),
                        getDatePicker(),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Form(
                              key: formSignUpKey,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  TextFormField(
                                    controller: passwordController,
                                    obscuringCharacter: '*',
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      prefixIcon: Icon(
                                        Icons.key,
                                        color: Colors.purple,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "Password",
                                      hintText: '*********',
                                      labelStyle:
                                      TextStyle(color: Colors.purple),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty && value!.length < 5) {
                                        return 'Enter a valid password';
                                      }
                                      {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      prefixIcon: Icon(
                                        Icons.nest_cam_wired_stand_rounded,
                                        color: Colors.purple,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "Name",
                                      labelStyle:
                                      TextStyle(color: Colors.purple),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty && value!.length < 5) {
                                        return 'Enter a valid name';
                                      }
                                      {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: conformPasswordController,
                                    obscuringCharacter: '*',
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      prefixIcon: Icon(
                                        Icons.key,
                                        color: Colors.purple,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "Repass-word",
                                      hintText: '*********',
                                      labelStyle:
                                      TextStyle(color: Colors.purple),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty && value!.length < 5) {
                                        return 'Enter a valid password';
                                      }
                                      {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        isEmailCorrect
                            ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                backgroundColor: isEmailCorrect == false
                                    ? Colors.red
                                    : Colors.purple,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 131, vertical: 20)),
                            onPressed: () async {
                              if (formSignUpKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );

                                if (passwordController.text !=
                                    conformPasswordController.text) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Mật khẩu nhập lại không đúng!')),
                                  );
                                  return;
                                } else {
                                  String? key = await signUp
                                      .signUpWithEmailAndPassword(
                                      emailController.text,
                                      passwordController.text,
                                      nameController.text,
                                      character == SingingCharacter.man
                                          ? 'man'
                                          : 'women',
                                      time.toString());
                                  if (key == 'success') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Đăng ký tài khoản thành công')),
                                    );
                                    context.pop();
                                  }
                                }
                              }
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 17),
                            ))
                            : Container(),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getDatePicker() => SizedBox(
    height: 60,
    child: CupertinoDatePicker(
      minimumYear: 1980,
      maximumYear: DateTime.now().year,
      onDateTimeChanged: (value) => setState(() => time = value),
      initialDateTime: time,
      mode: CupertinoDatePickerMode.date,
    ),
  );
}

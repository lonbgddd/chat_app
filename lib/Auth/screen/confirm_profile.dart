import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../config/changedNotify/resposome.dart';
import '../../config/helpers/enum_cal.dart';

class ConfirmProfile extends StatefulWidget {
  const ConfirmProfile({Key? key}) : super(key: key);

  @override
  State<ConfirmProfile> createState() => _ConfirmProfileState();
}

class _ConfirmProfileState extends State<ConfirmProfile> {
  final bioController = TextEditingController();
  final conformPasswordController = TextEditingController();
  DateTime time = DateTime.now();
  static const List<String> interests = [
    'Gym',
    'Self-care',
    'Reading',
    'Rave',
    'Shopping'
  ];
  List<String> newInterests = [];

  @override
  void dispose() {
    conformPasswordController.clear();
    bioController.clear();
    super.dispose();
  }

  SingingCharacter? character = SingingCharacter.man;

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
          onPressed: () async {
            await GoogleSignIn().signOut();
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Confirm your\ninformation",
                style: TextStyle(
                    fontSize: 28,
                    letterSpacing: 1,
                    wordSpacing: 3,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    'Gender',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListTile(
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
                  ),
                  Expanded(
                    child: ListTile(
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
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Birthday',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              getDatePicker(),
              Form(
                  key: formSignUpKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: bioController,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          filled: true,
                          fillColor: Color(0xFFF3E5F5),
                          labelText: "Biography",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              const Text(
                'Interests',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: interests.length,
                itemBuilder: (BuildContext context, int index) {
                  final interest = interests[index];
                  final isSelected = newInterests.contains(interest);

                  return ListTile(
                    title: Text(interest),
                    trailing: isSelected ? Icon(Icons.check) : null,
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          newInterests.remove(interest);
                        } else {
                          newInterests.add(interest);
                        }
                      });
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(vertical: 13)),
                  onPressed: () async {
                    await signUp.confirmProfile(
                        character == SingingCharacter.man ? 'man' : 'women',
                        time.toString(),
                        newInterests,
                        bioController.text);
                    context.go('/home');
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 17),
                  ))
            ],
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

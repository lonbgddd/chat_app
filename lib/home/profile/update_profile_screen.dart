import 'package:chat_app/config/data.dart';
import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/helpers/enum_cal.dart';
import 'package:chat_app/home/profile/components/gender_radio_button.dart';
import 'package:chat_app/home/profile/components/input_field.dart';
import 'package:chat_app/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.uid});
  final String? uid;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  User? currentUser;
  SingingCharacter? character = SingingCharacter.man;
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  DateTime? birthday;
  static const List<String> interests = [
    'Gym',
    'Self-care',
    'Reading',
    'Rave',
    'Shopping'
  ];
  List<String> newInterests = [];
  void getUserInfo() async {
    await DatabaseServices(widget.uid).getUserInfors().then((user) {
      setState(() {
        currentUser = user;
        character = currentUser!.gender == "man"
            ? SingingCharacter.man
            : SingingCharacter.women;
        nameController.text = currentUser!.fullName;
        bioController.text = currentUser!.biography;
        birthday = DateTime.parse(currentUser!.birthday);
        newInterests.addAll(currentUser!.interests);
      });
    });
  }

  void update() async {
    currentUser!.fullName = nameController.text;
    currentUser!.biography = bioController.text;
    currentUser!.birthday = birthday.toString();
    currentUser!.gender = character == SingingCharacter.man ? 'man' : 'women';
    currentUser!.interests = newInterests;

    await DatabaseMethods().updateUser(currentUser!).then((value) => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Update success'),
              content: Text('Your information has been updated'),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ));
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: currentUser == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your name',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      InputField(
                        hint: "Name",
                        controller: nameController,
                      ),
                      const Text(
                        'Biography',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      InputField(
                        hint: "Biography",
                        controller: bioController,
                      ),
                      const Text(
                        'Birthday',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      getDatePicker(),
                      const Text(
                        'Gender',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: GenderRadioButton(
                                title: "Man",
                                value: SingingCharacter.man,
                                selectedValue: character!,
                                onChanged: (value) {
                                  setState(() {
                                    character = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Expanded(
                              child: GenderRadioButton(
                                title: "Woman",
                                value: SingingCharacter.women,
                                selectedValue: character!,
                                onChanged: (value) {
                                  setState(() {
                                    character = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Interests',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: interests.length,
                        itemBuilder: (BuildContext context, int index) {
                          final interest = interests[index];
                          final isSelected = newInterests.contains(interest);

                          return ListTile(
                            title: Text(
                              interest,
                              style: const TextStyle(fontSize: 14),
                            ),
                            trailing: isSelected
                                ? Icon(
                                    Icons.check,
                                    color: const Color(0XFFAA3FEC)
                                        .withOpacity(0.8),
                                  )
                                : null,
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
                        width: 16,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                backgroundColor:
                                    const Color(0XFFAA3FEC).withOpacity(0.8),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 16)),
                            onPressed: update,
                            child: const Text(
                              'Save',
                              style: TextStyle(fontSize: 17),
                            )),
                      )
                    ]),
              ),
            ),
    );
  }

  Widget getDatePicker() => Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        height: 60,
        child: CupertinoDatePicker(
          minimumYear: 1980,
          maximumYear: DateTime.now().year,
          onDateTimeChanged: (value) => setState(() => birthday = value),
          initialDateTime: birthday!,
          mode: CupertinoDatePickerMode.date,
        ),
      );
}

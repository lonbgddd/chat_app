import 'package:chat_app/config/helpers/enum_cal.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.uid});
  final String? uid;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  SingingCharacter? character = SingingCharacter.man;
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Account Settings',
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 16.0),
              // padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(width: 1.0, color: const Color(0XFFC6C6C6))),
              child: const TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Name",
                ),
              )),
          Container(
              margin: const EdgeInsets.only(top: 16.0),
              // padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(width: 1.0, color: const Color(0XFFC6C6C6))),
              child: const TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Name",
                ),
              )),
          Container(
              margin: const EdgeInsets.only(top: 16.0),
              // padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(width: 1.0, color: const Color(0XFFC6C6C6))),
              child: const TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Name",
                ),
              )),
          Container(
              margin: const EdgeInsets.only(top: 16.0),
              // padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(width: 1.0, color: const Color(0XFFC6C6C6))),
              child: const TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Name",
                ),
              )),
          Row(
            children: [
              const Text(
                'Gender',
                style: TextStyle(fontSize: 16),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Man', style: TextStyle(fontSize: 14)),
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
                  title: const Text(
                    'Women',
                    style: TextStyle(fontSize: 14),
                  ),
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
        ]),
      ),
    );
  }
}

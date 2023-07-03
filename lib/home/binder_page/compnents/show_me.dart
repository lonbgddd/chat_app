import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowMe extends StatefulWidget {
  const ShowMe({Key? key}) : super(key: key);

  @override
  _ShowMeState createState() => _ShowMeState();
}

class _ShowMeState extends State<ShowMe> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    final styleRichText = TextStyle(
        color: Colors.grey[600],
        fontSize: 13.5,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w400
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(
                Icons.chevron_left,
                size: 32,
                color: Colors.grey[800],
              ),
              Text(
                "Quay lại",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          "Hiển thị cho tôi",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 10),
              child: Text(
                "Hiển thị cho tôi",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            buildListTile("Nữ"),
            buildListTile("Nam"),
            buildListTile("Mọi người"),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Binder chào đón tất cả mọi người",
                style: styleRichText,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: 'Mục cài đặt Tìm Kiếm giờ đây hiển thị những người dùng có bao gồm nhiều thông tin hơn về ',
                  style: styleRichText,
                  children: <TextSpan>[

                    TextSpan(
                      text: 'xác định giới tính',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                    ),
                    TextSpan(
                      text: ' và ',
                    ),
                    TextSpan(
                      text: 'khuynh hướng tình dục',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 13.5,
                      ),
                    ),
                    TextSpan(
                      text: ' của họ. Khi người dùng thêm thông tin về bản thân, họ có thể chọn hiển thị trong những mục tìm kiếm nào phản ảnh tốt nhất về bản dạng của họ.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildListTile(String option) {
    final selectedOptionProvider = context.watch<BinderWatch>();
    return ListTile(
      title: Text(option),
      tileColor: Colors.white,
      onTap: () {
        setState(() {
         selectedOptionProvider.setSelectedOption(option);
        });
      },
      trailing: selectedOptionProvider.selectedOption == option
          ? Icon(Icons.check, color: Colors.red)
          : null,
    );
}

}

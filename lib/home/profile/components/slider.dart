import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_app/home/profile/widget/item_slider.dart';
import 'package:chat_app/model/item_slider.dart';
import 'package:flutter/material.dart';

class SliderCustom extends StatefulWidget {
  const SliderCustom({Key? key}) : super(key: key);

  @override
  State<SliderCustom> createState() => _SliderCustomState();
}

class _SliderCustomState extends State<SliderCustom> {
  final _carouseController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () {},
              child: CarouselSlider(
                carouselController: _carouseController,
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 2,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                items: sliderList
                    .map((item) => ItemSliderCustom(itemSlider: item))
                    .toList(),
              ),
            ),
            Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                top: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: sliderList.asMap().entries.map((e) {
                    return GestureDetector(
                      child: Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentIndex == e.key
                                ? Colors.black
                                : Colors.grey),
                      ),
                    );
                  }).toList(),
                )),
          ],
        ),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.grey,
                fixedSize: Size(250, 50),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            child: Text(
              sliderList[currentIndex].title,
              style: TextStyle(color: sliderList[currentIndex].color),
            )),
      ],
    );
  }
}

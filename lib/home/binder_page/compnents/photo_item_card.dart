import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoGallery extends StatefulWidget {
  final List<String> photoList;
  ScrollPhysics scrollPhysics;

  PhotoGallery({required this.photoList,required this.scrollPhysics});

  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
   PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          physics: widget.scrollPhysics,
          controller: pageController,
          itemCount: widget.photoList.length,
          onPageChanged: (int page) {
            setState(() {
              currentIndex = page;
            });
          },
          itemBuilder: (context, index) {
            return GestureDetector(
              onTapUp:  (TapUpDetails details) {
                final double tapPositionX = details.localPosition.dx;
                final double screenWidth = MediaQuery.of(context).size.width;
                final double halfScreenWidth = screenWidth / 2;

                if (tapPositionX < halfScreenWidth && currentIndex > 0) {
                  setState(() {
                    currentIndex--;
                  });
                  pageController.animateToPage(
                    currentIndex,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                } else if (tapPositionX >= halfScreenWidth &&
                    currentIndex < widget.photoList.length - 1) {
                  setState(() {
                    currentIndex++;
                  });
                  pageController.animateToPage(
                    currentIndex,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              child: Image.network(widget.photoList[index], fit: BoxFit.cover),
            );
          },
        ),
        Positioned(
          top: 5,
          left: 12,
          right: 12,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double indicatorWidth =
                  constraints.maxWidth / widget.photoList.length;
              return FractionallySizedBox(
                widthFactor: 1,
                child: CustomPaint(
                  painter: IndicatorPainter(
                    itemCount: widget.photoList.length,
                    currentIndex: currentIndex,
                    indicatorWidth: indicatorWidth,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class IndicatorPainter extends CustomPainter {
  final int itemCount;
  final int currentIndex;
  final double indicatorWidth;
  final double indicatorSpacing;
  final double indicatorHeight;
  final Color indicatorColor;
  final Color currentIndicatorColor;


  IndicatorPainter({
    required this.itemCount,
    required this.currentIndex,
    this.indicatorWidth = 10,
    this.indicatorHeight = 5,
    this.indicatorSpacing = 5,
    this.indicatorColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.currentIndicatorColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double totalWidth =
        (indicatorWidth * itemCount) + (indicatorSpacing * (itemCount - 1));
    final double startX = (size.width - totalWidth) / 2;

    for (int i = 0; i < itemCount; i++) {
      final double x = startX + (indicatorWidth + indicatorSpacing) * i;
      final Color color =
      i == currentIndex ? currentIndicatorColor : indicatorColor;
      final Rect rect = Rect.fromLTWH(x, 0, indicatorWidth, indicatorHeight);
      final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(5));
      final Paint paint = Paint()..color = color;
      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class Judul extends StatelessWidget {
  final String txt;
  Judul({
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Color(0xffF9E2AE)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: Text(
              txt,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class Cs extends StatefulWidget {
  const Cs({super.key});

  @override
  State<Cs> createState() => _CsState();
}

class _CsState extends State<Cs> {
  final List<Widget> carousel = [
    Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(10)),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
      ),
    ),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: width / 2 - 10,
              width: width,
            ),
            DotsIndicator(
              decorator: DotsDecorator(
                color: Colors.black.withOpacity(0.1),
                activeColor: Colors.black.withOpacity(0.7),
              ),
              dotsCount: carousel.length,
              position: currentIndex,
            ),
          ],
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: width / 2,
            autoPlay: true,
            aspectRatio: 2 / 1,
            autoPlayAnimationDuration: Duration(milliseconds: 700),
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          items: carousel,
        ),
      ],
    );
  }
}

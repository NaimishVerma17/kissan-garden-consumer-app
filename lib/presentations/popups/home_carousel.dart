import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kissan_garden/utils/styles.dart';

class HomeCarousel extends StatelessWidget {
  List<String> _sliderImages = [
    'assets/images/organic.jpg',
    'assets/images/on-time-delivery.png',
    'assets/images/free.png',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      height: 260.0,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      items: _sliderImages.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                image: DecorationImage(image: AssetImage(i),fit: BoxFit.contain),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

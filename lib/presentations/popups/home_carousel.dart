import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kissan_garden/utils/styles.dart';

class HomeCarousel extends StatelessWidget {
  List<String> _sliderImages = [
    'assets/images/fresh_food.jpeg',
    'assets/images/on_time_delivery.jpeg',
    'assets/images/quality_food.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      height: 220.0,
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
                color: Styles.primaryColor,
                image: DecorationImage(image: AssetImage(i),fit: BoxFit.cover),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

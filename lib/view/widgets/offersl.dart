import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:whakaaro/constants/const.dart';

class CarouselSl extends StatefulWidget {
  const CarouselSl({Key? key}) : super(key: key);

  @override
  _CarouselSlState createState() => _CarouselSlState();
}

class _CarouselSlState extends State<CarouselSl> {
  final urlImages = [
    'assets/images/hcc-1.png',
    'assets/images/hcc-1.png',
    'assets/images/hcc-1.png',
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              CarouselSlider.builder(
                  itemCount: urlImages.length,
                  options: CarouselOptions(
                    initialPage: 0,
                    viewportFraction: 0.7,
                    aspectRatio: 14 / 8,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = urlImages[index];
                    return buildImage(urlImage, index);
                  }),
              SizedBox(height: 5),
              buildIndicator(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImage(String urlImage, int index) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xffaeef98),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Image.asset(
            urlImage,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10,),
          Container(
            color: Colors.white,
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text('Steal the Deal'),
                Text('Steal the Deal'),
                Text('Steal the Deal'),
              ],
            ),




          ),
          Stack(
            children: [
              Positioned(
                bottom: 60,
                right: 50,
                height: 10,
                child: Image.asset(
                  urlImage,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: WormEffect(
          dotHeight: 12,
          dotWidth: 12,
          dotColor: Color(0xFFE2E2E2),
          activeDotColor: kThemeColor,
        ),
      );
}

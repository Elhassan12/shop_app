// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors/colors.dart';
import '../login/shop_login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

List<BoardingModel> boardingScreens = [
  BoardingModel(
      image: "images/buy goods.png",
      title: "On Board 1 Title",
      body: "On Board 1 Body"),
  BoardingModel(
      image: "images/buy goods.png",
      title: "On Board 2 Title",
      body: "On Board 2 Body"),
  BoardingModel(
      image: "images/buy goods.png",
      title: "On Board 3 Title",
      body: "On Board 3 Body"),
];
void submit(context)
{
  CacheHelper.setData(key: "onboarding", value: true).then((value){
    if (value!) {
      navigateAndFinish(context, ShopLoginScreen());
    }

  });

}
class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  var pageController = PageController();
  bool islast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          deflutTextButton(onPressed:
              () {
            submit(context);
          },
              text:"Skip" ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  onBoardingItem(boardingScreens[index]),
              itemCount: 3,
              controller: pageController,
              onPageChanged: (int index) {
                if (index == boardingScreens.length - 1) {
                  islast = true;
                } else {
                  islast = false;
                }
              },
            )),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boardingScreens.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defultcolor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      submit(context);

                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios_rounded),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget onBoardingItem(BoardingModel model) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage("${model.image}"),
          )),
          SizedBox(
            height: 30,
          ),
          Text(
            "${model.title}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${model.body}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );
}

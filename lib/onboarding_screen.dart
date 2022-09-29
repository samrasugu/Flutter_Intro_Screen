import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_intro_screen/introscreens/intro_page_three.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'home_page.dart';
import 'introscreens/intro_page_one.dart';
import 'introscreens/intro_page_two.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // controller to keep track of page we are on
  PageController _controller = PageController();

  // keep track if we on last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              IntroPageOne(),
              IntroPageTwo(),
              IntroPageThree(),
            ],
          ),

          // dot inidactors
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // skip
                GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text("Skip")),

                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                ),

                // next or done
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        },
                        child: Text("Done"))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text("Next"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

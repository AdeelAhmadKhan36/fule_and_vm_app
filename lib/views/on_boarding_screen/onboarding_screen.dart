import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/controllers/on_boarding_providers.dart';
import 'package:fule_and_vm_app/home_screen.dart';
import 'package:fule_and_vm_app/views/common/reuse_able_text.dart';
import 'package:fule_and_vm_app/views/on_boarding_screen/page_one.dart';
import 'package:fule_and_vm_app/views/on_boarding_screen/page_three.dart';
import 'package:fule_and_vm_app/views/on_boarding_screen/page_two.dart';
import 'package:provider/provider.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding_Screen extends StatefulWidget {
  const OnBoarding_Screen({Key? key}) : super(key: key);

  @override
  State<OnBoarding_Screen> createState() => _OnBoarding_ScreenState();
}

class _OnBoarding_ScreenState extends State<OnBoarding_Screen> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<onBoard_Notifier>(
        builder: (context, onBoardNotifier, child) {
          return Stack(
            children: [
              PageView(
                physics: onBoardNotifier.isLastPage
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (page) {
                  onBoardNotifier.isLastPage = page == 2;
                },
                children: const [
                  Page_One(),
                  Page_Two(),
                  Page_Three(),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 50,
                child: onBoardNotifier.isLastPage
                    ? const SizedBox.shrink()
                    : Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      spacing: 10,
                      dotColor:
                      Color(kDarkGrey.value).withOpacity(0.5),
                      activeDotColor: Color(kLight.value),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to Home_Screen when Skip is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home_Screen(selectedLocationName:""),
                          ),
                        );
                      },
                      child: ReusableText(
                        text: 'Skip',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Move to the next page when Next is tapped
                        if (onBoardNotifier.isLastPage) {
                          // Navigate to Home_Screen when on the last page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home_Screen(selectedLocationName:"",
                            ),
                          )
                          );
                        } else {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      },
                      child: ReusableText(
                        text: onBoardNotifier.isLastPage ? 'Start' : 'Next',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

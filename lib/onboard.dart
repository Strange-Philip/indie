import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:indie/home.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingHome extends StatefulWidget {
  @override
  _OnboardingHomeState createState() => _OnboardingHomeState();
}

class _OnboardingHomeState extends State<OnboardingHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntroductionScreen(
      showNextButton: true,
      pages: [
        PageViewModel(
            title: "Hello, I'm Indie",
            image: SvgPicture.asset(
              "images/Voice control-pana.svg",
            ),
            body:
                "Indie is a simple speech to text app which also accepts some custom commands. I dont have a voice to speak yet. ",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600),
                bodyTextStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Quicksand',
                ))),
        PageViewModel(
            title: "Copy text",
            image: SvgPicture.asset(
              "images/undraw_No_data_re_kwbl.svg",
            ),
            body:
                "Copy your generated text easily to your clipboard with a tap of a button",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600),
                bodyTextStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Quicksand',
                ))),
        PageViewModel(
            title: "Call commands",
            image: SvgPicture.asset(
              "images/Calling-pana.svg",
            ),
            body:
                "Say Call and add the number you want to call to it and Indie takes you straight to your default phone app to continue the call. ",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600),
                bodyTextStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Quicksand',
                ))),
        PageViewModel(
            title: "Browse the web",
            image: SvgPicture.asset(
              "images/Mobile browsers-pana.svg",
            ),
            body:
                "Say Go to or Open and add the website link to easily open a website or search a word.",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600),
                bodyTextStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Quicksand',
                ))),
        PageViewModel(
            title: "Email and Sms",
            image: SvgPicture.asset(
              "images/Speech to text-pana.svg",
            ),
            body:
                "Say Email and add the email address of the reciever and we take you to directly email the person. Say Text and add the number to send an sms message to the person.",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600),
                bodyTextStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Quicksand',
                ))),
        PageViewModel(
            title: "Dark and Light Modes",
            image: SvgPicture.asset(
              "images/darkmode.svg",
            ),
            body:
                "Try our exciting dark mode theme. Remember to share with your friends too. Send me your feedback and who knows, maybe i will get the voice to speak one day",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600),
                bodyTextStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Quicksand',
                ))),
      ],
      onDone: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePage()));
      },
      done: Text(
        "Done",
        style: TextStyle(
          color: Color(0xff9316ee),
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Quicksand',
        ),
      ),
      showSkipButton: true,
      skip: Text(
        "Skip",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          fontFamily: 'Quicksand',
        ),
      ),
      dotsDecorator: DotsDecorator(
        activeColor: Color(0xff9316ee),
      ),
    ));
  }
}

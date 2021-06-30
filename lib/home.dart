import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:indie/speechapi.dart';
import 'package:indie/substring.dart';
import 'package:indie/utils.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

void customLaunch(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    print('could not launch $command');
  }
}

String greetingMessage() {
  var timeNow = DateTime.now().hour;

  if (timeNow <= 12) {
    return 'Good Morning, please tap on the button and start speaking';
  } else if ((timeNow > 12) && (timeNow <= 16)) {
    return 'Good Afternoon, please tap on the button and start speaking';
  } else if ((timeNow > 16) && (timeNow < 20)) {
    return 'Good Evening, please tap on the button and start speaking';
  } else {
    return 'Sweet dreams, any last requests?';
  }
}

class _HomePageState extends State<HomePage> {
  bool isListening = false;

  String greetingMes = greetingMessage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: Color(0xff9316ee),
          elevation: 0,
          title: Text(
            "Indie",
            maxLines: 5,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                // color: Colors.black,
                fontFamily: 'Quicksand'),
          ),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(LineIcons.copy),
                onPressed: () async {
                  await FlutterClipboard.copy(greetingMes);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    elevation: 0,
                    content: const Text('Copied to Clipboard'),
                    duration: const Duration(seconds: 2),
                    backgroundColor: Color(0xff9316ee),
                    behavior: SnackBarBehavior.floating,
                  ));
                },
              ),
            ),
          ],
        ),
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xff3cdaac),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('images/logo.jpg'),
                      ),
                      Spacer(),
                      EasyDynamicThemeBtn()
                    ],
                  ),
                ),
                ListTile(
                  selectedTileColor: Color(0xff9316ee).withOpacity(0.5),
                  title: Text(
                    'Contact Developer',
                    style: TextStyle(
                        // color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Quicksand'),
                  ),
                  leading: Icon(
                    LineIcons.envelope,
                    // color: Colors.black,
                  ),
                  onTap: () {
                    customLaunch(
                        'mailto:philipabakahmensah@gmail.com?subject=Indie&body=');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  selectedTileColor: Color(0xff9316ee).withOpacity(0.5),
                  title: Text(
                    'Help & feedback',
                    style: TextStyle(
                        // color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Quicksand'),
                  ),
                  leading: Icon(
                    LineIcons.questionCircle,
                    // color: Colors.black,
                  ),
                  onTap: () {
                    customLaunch(
                        'mailto:philipabakahmensah@gmail.com?subject=Indie&body=');
                    Navigator.pop(context);
                  },
                ),
                Center(
                    child: Text('Developed by • Philip',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 14,
                        ))),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(20).copyWith(bottom: 150),
          child: SubstringHighlight(
            text: greetingMes,
            terms: Command.all,
            textStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w400,
            ),
            textStyleHighlight: TextStyle(
              fontSize: 28.0,
              color: Color(0xff3cdaac),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: isListening,
          endRadius: 65,
          glowColor: Color(0xff3cdaac),
          child: FloatingActionButton(
            child: Icon(
                isListening ? LineIcons.microphoneSlash : LineIcons.microphone,
                size: 36),
            onPressed: toggleRecording,
          ),
        ),
      ),
    );
  }

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() => this.greetingMes = text),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(Duration(seconds: 1), () {
              Utils.scanText(greetingMes);
            });
          }
        },
      );
}

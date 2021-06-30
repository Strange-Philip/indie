import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:indie/speechapi.dart';
import 'package:indie/substring.dart';
import 'package:indie/utils.dart';
import 'package:line_icons/line_icons.dart';
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

class _HomePageState extends State<HomePage> {
  String text = 'Press the button and start speaking';
  bool isListening = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                  await FlutterClipboard.copy(text);

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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff3cdaac),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('images/logo.jpg'),
                      ),
                      Spacer(),
                      EasyDynamicThemeBtn()
                    ],
                  ),
                ),
              ),
              // ListTile(
              //   selectedTileColor: Color(0xff9316ee).withOpacity(0.5),
              //   title: Text(
              //     'Theme',
              //     style: TextStyle(
              //         // color: Colors.black,
              //         fontSize: 18,
              //         fontFamily: 'Quicksand'),
              //   ),
              //   leading: Icon(
              //     EasyDynamicTheme.of(context).themeMode == ThemeMode.light
              //         ? LineIcons.moon
              //         : LineIcons.sun,
              //     // color: Colors.black,
              //   ),
              //   // trailing: ChangeThemeButton(),
              //   trailing: EasyDynamicThemeSwitch(),
              //   onTap: () {
              //     // Navigator.pop(context);
              //   },
              // ),
              ListTile(
                selectedTileColor: Color(0xff9316ee).withOpacity(0.5),
                title: Text(
                  'Contact Developer',
                  style: TextStyle(
                      // color: Colors.black,
                      fontSize: 18,
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
                      fontSize: 18,
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
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(30).copyWith(bottom: 150),
          child: SubstringHighlight(
            text: text,
            terms: Command.all,
            textStyle: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w400,
            ),
            textStyleHighlight: TextStyle(
              fontSize: 32.0,
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
                isListening ? LineIcons.microphone : LineIcons.microphoneSlash,
                size: 36),
            onPressed: toggleRecording,
          ),
        ),
      );

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() => this.text = text),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(Duration(seconds: 1), () {
              Utils.scanText(text);
            });
          }
        },
      );
}

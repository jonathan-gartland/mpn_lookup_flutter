import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  static String routeName = 'about_page';
  const AboutPage({super.key});

  final String iqtUrl = 'https://www.idexx.com/en/water/water-products-services/quanti-tray-system/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'Why is this a Thing?',
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     decoration: TextDecoration.underline,
            //     fontFamily: 'Cochin',
            //   ),
            //   textAlign: TextAlign.center,
            //
            // ),
            const Padding(
              padding: EdgeInsets.only(left: 80.0),
              child: Text(
                'Why is this a Thing?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  fontFamily: 'Cochin',
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              'Many water testing facilities utilize the Idexx Labs. Quanti-Tray® System for analyzing possible coliform contamination in water samples.',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Cochin',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'For a quick overhead view for those unfamiliar, the water sample under test is prepared and incubated. Next the positive indicating sample portion is counted. The user will then need to reference a PDF they have previously downloaded for their test to get the MPN value.',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Cochin',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'For all the detail you\'ll ever need about this please visit:',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Cochin',
              ),
            ),
            GestureDetector(
              onTap: () => launchUrl(Uri.parse(iqtUrl)),
              child: Text(
                iqtUrl,
                style: const TextStyle(
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cochin',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The app you are looking at exists because I wanted some practice creating Flutter apps through to publishing and this was the simplest task I could think of to automate as my first attempt.',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Cochin',
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'Disclaimer: This app is not affiliated in any way with IDEXX Laboratories. This app and the related code are free and open to use by anyone and will never cost money to use. There is no information involved that can not be found freely available on the web.',
                style: TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Cochin',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

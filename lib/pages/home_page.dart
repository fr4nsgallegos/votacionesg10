import 'package:appvotacionesg10/pages/map2_custom_marker_page.dart';
import 'package:appvotacionesg10/pages/map_page.dart';
import 'package:appvotacionesg10/utils/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  Future<void> _lauchUrl() async {
    String _url = "https://pub.dev/packages/url_launcher";

    Uri url = Uri.parse(_url);
    await launchUrl(url);

    // if (await canLaunchUrl(url)) {

    //   await launchUrl(url);
    // } else {
    //   throw "no se puede abrir $url";
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VOTACIONES"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPage(),
                  ),
                );
              },
              child: Text("GO TO MAP"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Map2CustomMarkerPage(),
                  ),
                );
              },
              child: Text("GO TO MAP WITH CUSTOM MARKER"),
            ),
            ElevatedButton(
              onPressed: () {
                _lauchUrl();
              },
              child: Text("URL LAUNCHER"),
            ),
          ],
        ),
      ),
    );
  }
}

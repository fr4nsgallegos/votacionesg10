import 'package:appvotacionesg10/pages/map_page.dart';
import 'package:appvotacionesg10/utils/notification_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
          ],
        ),
      ),
    );
  }
}

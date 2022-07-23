import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

void main() => runApp(LinkifyExample());

class LinkifyExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter_linkify example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('flutter_linkify example'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Linkify(
                onOpen: _onOpen,
                textScaleFactor: 2,
                text: "Made by https://cretezy.com\n\nMail: example@gmail.com",
              ),
            ),
            Center(
              child: SelectableLinkify(
                onOpen: _onOpen,
                textScaleFactor: 4,
                text: "Made by https://cretezy.com\n\nMail: example@gmail.com",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    final uri = Uri.parse(link.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $link';
    }
  }
}

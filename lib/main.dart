import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:quick_action/gallery_view.dart';
import 'package:quick_action/search_view.dart';
import 'package:quick_actions/quick_actions.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: Colors.blue,
      debugShowCheckedModeBanner: false,
      home: MyHomeView(),
    );
  }
}

class MyHomeView extends StatefulWidget {
  const MyHomeView({super.key});

  @override
  _MyHomeViewState createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  String shortcut = 'no action set';

  @override
  void initState() {
    super.initState();
    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      shortcut = shortcutType;
      if (shortcutType == "gallery") {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const GalleryView()));
      }
      if (shortcutType == "search") {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const SearchView()));
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'gallery', localizedTitle: 'Gallery', icon: 'gallery'),
      const ShortcutItem(type: 'search', localizedTitle: 'Search', icon: 'search'),
    ]).then((void _) {
      setState(() {
        if (shortcut == 'no action set') {
          shortcut = 'actions ready';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(shortcut),
      ),
    );
  }
}

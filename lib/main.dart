import 'package:flutter/material.dart';
import 'config.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const LinkTree(title: 'Flutter Demo Home Page'),
    );
  }
}

class LinkTree extends StatefulWidget {
  const LinkTree({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LinkTree> createState() => _LinkTreeState();
}

class _LinkTreeState extends State<LinkTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child:
                  Image(image: NetworkImage(user['profile_image'].toString())),
            ),
            Container(
              width: 150,
              height: 50,
              color: Colors.pink[50],
              child: const Center(
                child: Text('Looking for a job'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(user['name']),
            const SizedBox(
              height: 10,
            ),
            Text(user['title']),
            const SizedBox(
              height: 10,
            ),
            Text(user['location']),
            const Divider(
              color: Colors.black,
            ),
            Text(user['bio']),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: ListView(children: generateLiks(user['links'])),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: generateContacts(user['contacts']),
              ),
            ))
          ],
        ),
      ),
    );
  }

  List<Widget> generateLiks(List<Map<String, String>> links) {
    List<Widget> linkss = [];
    for (var i = 0; i < links.length; i++) {
      linkss.add(ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.grey[500]),
          onPressed: () async {
            await launch(links[i]['link'].toString());
          },
          child: Text(links[i]['title'].toString())));
    }
    setState(() {});
    print(linkss.length);

    return linkss;
  }

  List<Widget> generateContacts(contacts) {
    List<Widget> contactss = [];
    for (var i = 0; i < contacts.length; i++) {
      var title = contacts[i]['title'];

      contactss.add(IconButton(
        onPressed: () async {
          await launch(title + '://send?phone=' + contacts[i]['value']);
        },
        icon: Image.asset('assets/$title.png'),
      ));
    }
    setState(() {});
    return contactss;
  }
}

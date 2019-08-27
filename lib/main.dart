import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//import 'screens/home.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      debugShowCheckedModeBanner: false,
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class HomePage extends StatefulWidget {

  final String title;
  //State class
  HomePage({Key key, this.title}) :super(key: key);
  int _page = 0;

  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data;
  List listData;

  Future getData() async {
    http.Response response = await http.get("https://lowcarbon-malang.id/system/api/admin/tps");
    data = json.decode(response.body);
    setState(() {
      listData = data['data'];
    });
//    print(listData[0]['id_tpa']);
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child:  new Scaffold(
        appBar: topAppBar,
        body: new ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: listData == null ? 0 : listData.length,
          itemBuilder: (BuildContext context, int index) {
//            return Card(
//              child: new Row(
//                children: <Widget>[
//                  CircleAvatar(
//                    backgroundColor: Colors.red,
//                  ),
//                  Text("${listData[index]["nama_tps"]}")
//                ],
//              ),
//            );
          return makeCard(title: "${listData[index]["nama_tps"]}",);
          },
        ),
      )
    );
  }
}

class makeListTile extends StatelessWidget {
  makeListTile({this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.all(12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.home, color: Colors.white),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
      subtitle: Row(
        children: <Widget>[
          Icon(Icons.linear_scale, color: Colors.greenAccent),
          Text(" Aman", style: TextStyle(color: Colors.white))
        ],
      ),
      trailing: new IconButton(
        icon: new Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
        onPressed: () {
          return AlertDialog(
            title: new Text("Apakah anda yakin ?"),
            content: new Text("Anda melihat detail tpa"),
            actions: <Widget>[
              new FlatButton(onPressed: null, child: new Text("close"))
            ],
          );
        }
      )
    );
  }
}

class makeCard extends StatelessWidget {
  makeCard({this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(title: title),
      ),
    );
  }
}

final topAppBar = AppBar(
  elevation: 0.1,
  backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
  title: Text("DAFTAR TPS"),
  actions: <Widget>[
    IconButton(
      icon: Icon(Icons.list),
      onPressed: () {},
    )
  ],
);
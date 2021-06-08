import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart';

void main() => runApp(Homepage());

class widgetelements {
  final String name;

  const widgetelements(this.name);
}

const urlPrefix = "http://10.96.16.65:5000";

/// Cette class comprend tous les éléments sur la page principale de l'app
class Homepage extends StatelessWidget {
  final widgetmain = <widgetelements>[
    // On creer une ref pour les noms des widgets
    new widgetelements("Photo"), //[0]
    new widgetelements("Vidéo"), //[1]
    new widgetelements("Message"), //[2]
    new widgetelements("Sondage"), //[3]
    new widgetelements("Jeux"), //[4]
  ];
//on donne le nom de la appbar
  static const String _title = 'ParadiseCity';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primaryColor: Colors.deepOrange[100], // Couleur
      ),
      home: Scaffold(
        floatingActionButton: SpeedDial(
          backgroundColor: Colors.red,
          children: [
            SpeedDialChild(
              child: Icon(Icons.accessibility),
              backgroundColor: Colors.red,
              label: 'First',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('FIRST CHILD'),
              onLongPress: () => print('FIRST CHILD LONG PRESS'),
            ),
            SpeedDialChild(
              child: Icon(Icons.brush),
              backgroundColor: Colors.blue,
              label: 'Second',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('SECOND CHILD'),
              onLongPress: () => print('SECOND CHILD LONG PRESS'),
            ),
            SpeedDialChild(
              child: Icon(Icons.keyboard_voice),
              backgroundColor: Colors.green,
              label: 'Third',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('THIRD CHILD'),
              onLongPress: () => print('THIRD CHILD LONG PRESS'),
            ),
          ],
        ),
        backgroundColor: Colors.white60,
        appBar: AppBar(title: Text(_title)),
        body: ListView(children: [
          /// On créé une liste infini
          MyWidget(widgetmain[0]),

          ///On appel un "MyWidget" et on lui donne en titre le premier nom
          ligneblanche(),

          /// On appel un widget qui est sous forme de ligne blanche
          MyWidget(widgetmain[1]),

          ///ainsi de suite
          ligneblanche(),
          MyWidget(widgetmain[2]),
          ligneblanche(),
          MyWidget(widgetmain[3]),
          ligneblanche(),
          MyWidget(widgetmain[4]),
        ]),
      ),
    );
  }
}

/// ------- Photopage -------
class Photopage extends StatelessWidget {
  final widgetphoto = <widgetelements>[
    new widgetelements("photo"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photo"),),
      body: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          makePostRequest();
        },
        child: const Text('Get'),
      ),
    );
  }

  Future<void> makePostRequest() async {
    final url = Uri.parse('$urlPrefix/screenSwitch/Live&Onq');
    final headers = {"Content-type": "application/json"};
    final response = await post(url, headers: headers);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
  }
  Future<void> makeGetRequest() async {
    final url = Uri.parse('$urlPrefix/screenSwitch/test');
    Response response = await get(url);
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Headers: ${response.headers}');
    debugPrint('Body: ${response.body}');
  }
}

/// ------- Videopage -------
class Videopage extends StatelessWidget {
  final widgetphoto = <widgetelements>[
    new widgetelements("Vidéo"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vidéo"),
      ),
    );
  }
}

/// ------- Messagespage -------
class Msgpage extends StatelessWidget {
  final widgetphoto = <widgetelements>[
    new widgetelements("Messages"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
      ),
    );
  }
}

/// ------- Sondagespage -------
class Sondagespage extends StatelessWidget {
  final widgetphoto = <widgetelements>[
    new widgetelements("Sondage"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sondage"),
      ),
    );
  }
}

/// ------- Jeuxpage -------
class Jeuxpage extends StatelessWidget {
  final widgetphoto = <widgetelements>[
    new widgetelements("Jeux"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Gamewidget(),
        ],
      ),
      appBar: AppBar(
        title: Text("Jeux"),
      ),
    );
  }
}

/// Widget flèche de déplacement
class Gamewidget extends StatelessWidget {
  const Gamewidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50.0),
      padding: EdgeInsets.all(5.0),
      height: 250,
      width: 300,
      child: Card(
        color: Colors.blueGrey,
        child: Stack(children: [
          Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                  width: 70,
                  height: 50,
                  child: Image.network(
                      "https://img.icons8.com/fluent-systems-filled/50/000000/circled-chevron-left--v2.png"))),
          Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                  width: 70,
                  height: 50,
                  child: Image.network(
                      "https://img.icons8.com/material-sharp/50/000000/circled-chevron-right.png"))),
          Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                  width: 70,
                  height: 50,
                  child: Image.network(
                      "https://img.icons8.com/material-sharp/50/000000/circled-chevron-up.png"))),
          Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width: 70,
                  height: 50,
                  child: Image.network(
                      "https://img.icons8.com/material-sharp/50/000000/circled-chevron-down.png"))),
        ]),
      ),
    );
  }
}

/// Class qui permet que de changer de page lorsqu'on click sur les widgets
class MyWidget extends StatelessWidget {
  final widgetelements element;
  const MyWidget(this.element, {Key key}) : super(key: key);

  void ChangePage(context) {
    switch (element.name) {
      case "Photo":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Photopage()),
        );
        break;
      case "Vidéo":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Videopage()),
        );
        break;
      case "Message":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Msgpage()),
        );
        break;
      case "Sondage":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Sondagespage()),
        );
        break;
      case "Jeux":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Jeuxpage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: new Container(
            width: 350,
            height: 180,
            decoration: new BoxDecoration(
                color: Colors.deepOrange[50],
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0),
                  bottomLeft: const Radius.circular(20.0),
                  bottomRight: const Radius.circular(20.0),
                )),
            child: InkWell(
              onTap: () {
                ChangePage(context);
              },
              child: Column(children: [
                Text(
                  element.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, height: 1.5, fontSize: 20),
                ),
              ]),
            )),
      ),
    );
  }
}

class ligneblanche extends StatelessWidget {
  const ligneblanche({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 10,
        decoration: new BoxDecoration(
            color: Colors.brown,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0),
              bottomLeft: const Radius.circular(20.0),
              bottomRight: const Radius.circular(20.0),
            )),
      ),
    );
  }
}

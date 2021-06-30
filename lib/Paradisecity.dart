import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';

void main() => runApp(Homepage());

class widgetelements {
  final String name;

  const widgetelements(this.name);
}

const urlPrefix = "https://10.96.16.65:5001/api";

/// Cette class comprend tous les éléments sur la page principale de l'app
class Homepage extends StatelessWidget {
  final widgetmain = <widgetelements>[
    // On creer une ref pour les noms des widgets
    new widgetelements("Live"), //[0]
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
        backgroundColor: Colors.white60,
        appBar: AppBar(
          title: Text(_title),
        ),
        drawer: Builder(
          builder: (context) => Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Envoyer un message'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Sendmsg()));
                    print('Ouverture page pour envoyer un message');
                  },
                ),
                ListTile(
                  title: Text('Enregistrer une video'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Enregistrer un vocal'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
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

/// ------- Livepage -------
class Livepage extends StatelessWidget {
  final widgetphoto = <widgetelements>[
    new widgetelements("Live"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live"),
      ),
      body: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          makePostRequest();
        },
        child: const Text('Lancer le live'),
      ),
    );
  }

  Future<void> makePostRequest() async {
    final url = Uri.parse('$urlPrefix/screenSwitch/Live&On');
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
      body: Center(
        child: Card(
          child: Container(
            height: 300,
            width: 300,
            margin: EdgeInsets.all(50.0),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Column(children: [
              Text(
                  'Pensez vous que Lyon doit continuer de mettre en place des pistes cyclabe partout '),
              Row(
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20.0)),
                  ElevatedButton(
                    child: Text('Oui'),
                    onPressed: () {
                      print('Envoie 1');
                    },
                  ),
                  ElevatedButton(
                    child: Text('Non'),
                    onPressed: () {
                      print('Envoie 2');
                    },
                  ),
                ],
              ),
            ]),
          ),
        ),
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
      case "Live":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Livepage()),
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
      case "Ecrire un message":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Sendmsg()),
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

//-------------------------------------------------------------------------------//
class Sendmsg extends StatefulWidget {
  const Sendmsg({Key key}) : super(key: key);

  @override
  _SendmsgState createState() => _SendmsgState();
}

class _SendmsgState extends State<Sendmsg> {

  var dropdownValues = <String>[
    'les probl\u00e8mes',
    'besoin d\'aide',
    'remonté d\'id\u00e9es',
    '\u00e9venements',
    'une simple pens\u00e9e',
  ];
  TextEditingController messageController = TextEditingController();
  @override
  String _chosenValue;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Envoyer un message"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: messageController,
              maxLength: 400,
              decoration: const InputDecoration(
                  labelText: 'Votre Message',
                  hintText: 'Ecrivez ici',
                  border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ecrivez ici';
                }
                return null;
              },
            ),
            DropdownButton<String>(
              focusColor: Colors.white,
              value: _chosenValue,
              //elevation: 5,
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              items: dropdownValues.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              hint: Text(
                "Choisir sa catégorie",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (String value) {
                setState(() {
                  _chosenValue = value;
                });
              },
            ),
            SizedBox(
              width: 100,
              height: 30.0,
              child: ElevatedButton(
                child: Text('Envoyer'),
                onPressed: () {
                  //print(messageController.text);
                  final message = messageController.text.toString();
                  sendMessagePost(message);
                  print(_chosenValue,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendMessagePost(message) async {
    final content = {"filtre": [dropdownValues.indexOf(_chosenValue)], "content": message};
    final url = Uri.parse('$urlPrefix/messages/newMessageText');
    final headers = {"Content-type": "application/json"};
    final json = jsonEncode(content);
    final response = await post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
  }

  Future<void> messageGet() async {
    final url = Uri.parse('$urlPrefix/screenSwitch/GetData');
    final headers = {"Access-Control-Allow-Origin": "*"};
    final response = await get(
      url,
      headers: headers,
    );
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Body: ${response.body}');
  }
}

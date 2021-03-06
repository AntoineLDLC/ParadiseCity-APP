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
    new widgetelements("Messages"), //[2]
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
        primaryColor: Color.fromRGBO(52, 73, 94, 1), // Couleur
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => sendvideopage()));
                  },
                ),
                ListTile(
                  title: Text('Enregistrer un vocal'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => voicepage()));
                  },
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
        ]),
      ),
    );
  }
}

/// ------- Livepage -------
class LivePage extends StatefulWidget {
  const LivePage({Key? key}) : super(key: key);

  @override
  _LivePageState createState() => _LivePageState();
}


class _LivePageState extends State<LivePage> {
  final widgetphoto = <widgetelements>[
    new widgetelements("Live"),
  ];
  var liveIsOn = true;

  @override
  void initState() {
    super.initState();
    makeGetRequest();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live"),
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.teal,
                  onSurface: Colors.grey,
                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  if (liveIsOn == true) {
                    Postliveon();
                    setState(() {
                      liveIsOn = !liveIsOn;
                    });
                  } else {
                    Postliveoff();
                    setState(() {
                      liveIsOn = !liveIsOn;
                    });
                  }
                },
                child: liveIsOn
                    ? const Text('Faire une demande de live')
                    : const Text('Terminer le live'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> Postliveon() async {
    final url = Uri.parse('$urlPrefix/screen/Live/On');
    final headers = {"Content-type": "application/json"};
    final response = await post(url, headers: headers);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
  }

  Future<void> Postliveoff() async {
    final url = Uri.parse('$urlPrefix/screen/Live/Off');
    final headers = {"Content-type": "application/json"};
    final response = await post(url, headers: headers);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
  }

  Future<void> makeGetRequest() async {
    final url = Uri.parse('$urlPrefix/getData');
    Response response = await get(url);
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Headers: ${response.headers}');
    debugPrint('Body: ${response.body}');
    var getData = jsonDecode(response.body);
    print(getData['screensCommands']['screen1']);
  }
}

/// ------- Messagespage -------

class Msgpage extends StatefulWidget {
  @override
  _MsgpageState createState() => _MsgpageState();
}

class _MsgpageState extends State<Msgpage> {
  Future<void> getMessage() async {
    final url = Uri.parse('$urlPrefix/messages/getData');
    final headers = {"Content-type": "application/json"};
    Response response = await get(url, headers: headers);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    List<MessageData> list = [];
    var deco = jsonDecode(response.body)["Messages"];
    for (var m in deco) {
      list.add(new MessageData(m["content"], int.parse(m["filtre"][0])));
    }
    setState(() => getData = list);
  }

  List<MessageData> getData = [];

  final widgetphoto = <widgetelements>[
    new widgetelements("Messages"),
  ];

  @override
  void initState() {
    getMessage();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
      ),
      body: MessagesList(getData),
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
                "Si ce dispositif se trouvait dans votre ville, seriez-vous un des ses utilisateurs ?",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,), textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, //Center Row contents horizontally,
              crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
            children: [
              ElevatedButton(
                  child: Text('Oui'),
                  onPressed: () {
                    sendvote('oui');
                  }),
              ElevatedButton(
                child: Text('Non'),
                onPressed: () {
                  sendvote('non');
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Future<void> sendvote(vote) async {
    final content = {
      "data": vote,
    };
    final url = Uri.parse('$urlPrefix/sondage');
    final headers = {"Content-type": "application/json"};
    final json = jsonEncode(content);
    final response = await post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
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
  const Gamewidget({Key? key}) : super(key: key);

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
  const MyWidget(this.element, {Key? key}) : super(key: key);

  void ChangePage(context) {
    switch (element.name) {
      case "Live":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LivePage()),
        );
        break;
      case "Messages":
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
                color: Color.fromRGBO(149, 165, 166, 1),
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
  const ligneblanche({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 10,
        decoration: new BoxDecoration(
            color: Color.fromRGBO(52, 73, 94, 1),
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
  const Sendmsg({Key? key}) : super(key: key);

  @override
  _SendmsgState createState() => _SendmsgState();
}

class _SendmsgState extends State<Sendmsg> {
  TextEditingController messageController = TextEditingController();
  @override
  String? _chosenValue;
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
              items:
                  dropdownValues.map<DropdownMenuItem<String>>((String value) {
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
              onChanged: (String? value) {
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
                  print(
                    _chosenValue,
                  );
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Homepage() ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendMessagePost(message) async {
    final content = {
      "filtre": [dropdownValues.indexOf(_chosenValue!).toString()],
      "content": message
    };
    final url = Uri.parse('$urlPrefix/messages/newMessageText');
    final headers = {"Content-type": "application/json"};
    final json = jsonEncode(content);
    final response = await post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
  }
}

class MessagesList extends StatefulWidget {
  var getData;
  MessagesList(this.getData, {Key? key}) : super(key: key);

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  var colorFont = {
    "0": ["220, 38, 38, 1", "254, 202, 202, 1"],
    "1": ["217, 119, 6, 1", "253, 230, 138, 1"],
    "2": ["5, 150, 105, 1", "167, 243, 208, 1"],
    "3": ["37, 99, 235, 1", "191, 219, 254, 1"],
    "4": ["79, 70, 229, 1", "199, 210, 254, 1"],
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: [for (var d in this.widget.getData) Prb(d)],
      ),
    );
  }
}

class MessageData {
  String content;
  int category;

  MessageData(this.content, this.category);
}

class Prb extends StatelessWidget {
  final MessageData data;
  Prb(this.data, {Key? key}) : super(key: key);

  var colorFont = {
    0: [Color.fromRGBO(220, 38, 38, 1), Color.fromRGBO(254, 202, 202, 1)],
    1: [Color.fromRGBO(217, 119, 6, 1), Color.fromRGBO(253, 230, 138, 1)],
    2: [Color.fromRGBO(5, 150, 105, 1), Color.fromRGBO(167, 243, 208, 1)],
    3: [Color.fromRGBO(37, 99, 235, 1), Color.fromRGBO(191, 219, 254, 1)],
    4: [Color.fromRGBO(79, 70, 229, 1), Color.fromRGBO(199, 210, 254, 1)],
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(data.content),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(dropdownValues[data.category],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorFont[data.category]![0],
                      background: Paint()
                        ..strokeWidth = 17.0
                        ..color = colorFont[data.category]![1]
                        ..style = PaintingStyle.stroke
                        ..strokeJoin = StrokeJoin.round,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var dropdownValues = <String>[
  'les probl\u00e8mes',
  'besoin d\'aide',
  'remonté d\'id\u00e9es',
  '\u00e9venements',
  'une simple pens\u00e9e',
];

class voicepage extends StatefulWidget {
  const voicepage({Key ?key}) : super(key: key);

  @override
  _voicepageState createState() => _voicepageState();
}

class _voicepageState extends State<voicepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enregistrer une video"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                  "https://static.thenounproject.com/png/745489-200.png"),
            ),
            Center(
              child: Text(
                'Page en développement',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class sendvideopage extends StatefulWidget {
  const sendvideopage({Key ?key}) : super(key: key);

  @override
  _sendvideopageState createState() => _sendvideopageState();
}

class _sendvideopageState extends State<sendvideopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enregistrer un message vocal"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                  "https://static.thenounproject.com/png/745489-200.png"),
            ),
            Center(
              child: Text(
                'Page en développement',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

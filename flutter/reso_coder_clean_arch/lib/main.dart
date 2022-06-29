import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'KbdListener with TextField'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<FocusNode> ListFocusNode = [FocusNode(), FocusNode()];
  DateTime whenlastchar = DateTime.now();
  List<String> scanned4 = [];
  String _receivedtext = "Scanned text here..";
  final TextEditingController _myTextControler =
      TextEditingController(text: "");
  @override
  void initState() {
    ListFocusNode.first.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            KeyboardListener(
              key: const Key('KeyboardListener-files'),
              focusNode: ListFocusNode.first,
              autofocus: true,
              onKeyEvent: (event) async {
                var difference = DateTime.now().difference(whenlastchar);
                whenlastchar = DateTime.now();
                if (event.character != null) {
                  if (difference.inMilliseconds > 1000) {
                    scanned4.clear();
                  }
                  scanned4.add(event.character.toString());
                  if ((event.character == "\n") ||
                      (event.character == " ") ||
                      (event.character == 0x09)) {
                    String tempo =
                        scanned4.reduce((first, second) => first + second);
                    scanned4.clear();
                    tempo = tempo.trim();
                    // update
                    setState(() {
                      _receivedtext = tempo;
                    });
                  }
                }
              },
              child: Column(
                children: <Widget>[
                  Text(
                    _receivedtext,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: _myTextControler,
                    autofocus: false,
                    focusNode: ListFocusNode.last,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      print("textfield value: '$value'");
                      setState(() {
                        _receivedtext = value;
                      });
                      _myTextControler.clear();
                      FocusScope.of(context).requestFocus(ListFocusNode.first);
                    },
                  ),
                  Row(children: [
                    TextButton(
                      child: const Text("KeyboardListener Focus"),
                      onPressed: () {
                        setState(() {
                          FocusScope.of(context)
                              .requestFocus(ListFocusNode.first);
                        });
                      },
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

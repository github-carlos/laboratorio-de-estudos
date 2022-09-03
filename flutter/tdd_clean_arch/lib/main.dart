import 'package:flutter/material.dart';
import 'package:tdd_clean_arch/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.greenAccent,
          primary: Colors.green,
        ),
      ),
      title: 'Number Trivia',
      home: NumberTriviaPage(),
    );
  }
}

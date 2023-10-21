import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'real word checker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'swift word checker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController wordController = TextEditingController();
  final MethodChannel platform = const MethodChannel('word_check');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            SizedBox(
              width: size.width * 0.8,
              child: TextFormField(
                controller: wordController,
                onFieldSubmitted: (newValue) async {
                  final bool result = await platform
                      .invokeMethod('up', {"m": wordController.text});
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(result ? 'real word' : 'dummy'),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              width: size.width * 0.7,
              child: const Text(
                'write the word you want to check here and press done',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

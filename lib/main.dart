import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  var ctrl = TextEditingController();
  var SP_DATA = "No Data Saved";

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      var spData = sp.getString("spData");
      SP_DATA = spData ?? "No Data Saved";
      // spData!=null ? spData : "No Data Saved"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: ctrl,
            ),
            ElevatedButton(onPressed: () async {
              var ctrl_data  = ctrl.text.toString();

              var sp = await SharedPreferences.getInstance();
              sp.setString("spData", ctrl_data);


            }, child: Text("Save")),
            Text(SP_DATA),
          ],
        ),
      )
    );
  }


}

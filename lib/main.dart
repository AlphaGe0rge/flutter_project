import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/details.dart';
import 'package:http/http.dart' as http;

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
        primarySwatch: Colors.red
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

  List? _dataList;

  void _incrementCounter() async {
    final data = await http.get(Uri.parse('https://api.npoint.io/5ecaa20ebea4d86084e5'));

    setState(() {
      _dataList = jsonDecode(data.body);
      _dataList!.removeAt(2);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: Center(child: Text("hello"),),
      ),
      body: Center(
          child: _dataList != null ? PageView.builder(
            itemCount: _dataList?.length,
            itemBuilder: (context, index) {
              final item = _dataList?[index];
              final image = item['image'];
              final title = item['name'];
              final description = item['description'];
              final city = City(
                  image: image, title: title, description: description);

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(city: city))
                  );
                },
                child: HomeItem(city: city),
              );
            }, //ListView.builder
          ) : Center(child: Text('Presionar el boton de +'),)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
   }
}

class HomeItem extends StatelessWidget {
  const HomeItem({super.key, required this.city});

  final City city;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 20,
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 120,
              height: 190,
              child: Image.network(
                city.image,
                fit:BoxFit.cover
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                city.title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
              ),
            ),
            Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(
               city.description,
               overflow: TextOverflow.ellipsis,
               maxLines: 8,
               style: TextStyle(
                 fontSize: 20
               ),
             ),
            )
          ],
        ),
      ),
    );
  }
}

class City{

  City({
  required this.image,
  required this.title,
  required this.description
});

final String image;
final String title;
final String description;
}


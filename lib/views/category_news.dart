import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newsapp/views/home.dart';

class CategoryNews extends StatefulWidget {
  const CategoryNews({ Key? key, required this.category }) : super(key: key);

final String category;

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

@override
  void initState() {
    super.initState();
    getCategorynews(widget.category);
  }

 getCategorynews(String category) async{
    var newss =[];
    var response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=8bdc3d4c907f4872bb69f8371d15bcd2'));
    var jsonData = jsonDecode(response.body);   

      for (var i in jsonData['articles']){
        NewsModel news = NewsModel(i['title'], i['description'], i['urlToImage'],i['url']);
        newss.add(news);
      }
      return newss;
      
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Flutter",style: TextStyle(color: Colors.black26),),
                Text("News",style: TextStyle(color: Colors.blue),)
              ],
            ),
            actions: [
              Opacity(
                opacity: 0,
                child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16,),
                child: const Icon(Icons.save)),
              )
            ],
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                flex: 25,
                child: FutureBuilder(
                future: getCategorynews(widget.category),
                builder: (context,AsyncSnapshot snapshot){
                  if (snapshot.data == null) {
                    // ignore: prefer_const_constructors
                    return const Padding(
                    padding: EdgeInsets.only(bottom: 10,),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(color: Colors.blue,),
                    ),
                  );
                  }
                  // ignore: curly_braces_in_flow_control_structures
                  else return Scrollbar(
                    isAlwaysShown: true,
                    child: 
                      Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                      return NewsTile(
                      imageUrl: snapshot.data[index].imageUrl,
                      title: snapshot.data[index].title,
                      desc: snapshot.data[index].desc,
                      url: snapshot.data[index].url,
                    );
                  }),
                  )
                  );
                }),
              ),
              ],
            ),
          ),
    );
  }
}
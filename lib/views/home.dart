import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/models/categorie_model.dart';

import 'package:http/http.dart' as http;
import 'package:newsapp/views/article_view.dart';
import 'package:newsapp/views/category_news.dart';
import 'package:newsapp/views/userprofile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  List<CategoryModel> categories = <CategoryModel>[];
  
  @override
  void initState() {
    super.initState();
    categories = getCategories();
  }

  getnews() async{
    var newss =[];
    var response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=in&apiKey=8bdc3d4c907f4872bb69f8371d15bcd2'));
    var jsonData = jsonDecode(response.body);   

      for (var i in jsonData['articles']){
        if(i['urlToImage'] != null && i['description'] != null){
        NewsModel news = NewsModel(i['title'], i['description'], i['urlToImage'],i['url']);
        newss.add(news);
        }
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
              children:  [
                 const Text("Flutter",style: TextStyle(color: Colors.black26),),
                 const Text("News",style: TextStyle(color: Colors.blue),),
                const SizedBox(width: 55,),
                IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                             builder: (context) => Profile(), 
                ));
                }, icon:  const Icon(Icons.account_circle_rounded),color: Colors.grey,)
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                      );
                    }),
                          ),
              ),
              Expanded(
                flex: 25,
                child: FutureBuilder(
                future: getnews(),
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
          )



          //Blogs
    );
  }
}

class NewsModel{
  String? title;
  String? desc;
  String? imageUrl;
  String? url;

  NewsModel(this.title,this.desc,this.imageUrl,this.url);
}

class CategoryTile extends StatelessWidget {
  
final String imageUrl,categoryName;
const CategoryTile({Key? key, required this.imageUrl,required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
        builder: (context) => CategoryNews(
        category: categoryName.toString().toLowerCase(),
        )
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
            imageUrl,width: 120,height: 60,fit: BoxFit.cover,)
            ),
            Container(
              alignment: Alignment.center,
              width: 120,height: 60,
              decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(6),
              ),
              child: Text(categoryName,style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500
              ),),
            )
          ],
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc,url;

   // ignore: use_key_in_widget_constructors
   const NewsTile({required this.imageUrl,required this.desc,required this.title,required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
        builder: (context) => ArticleView(
        blogUrl: url)
        ));
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      imageUrl,
                      height: 180,
                      width: 500,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(height: 12,),
                Text(
                  title,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  desc,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                )
              ],
            ),
          )),
    );
  }
}

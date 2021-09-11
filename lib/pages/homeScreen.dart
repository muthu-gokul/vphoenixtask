import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:vphoenixtask/model/newsModel.dart';
import 'package:vphoenixtask/pages/detailView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double height,width;
 late NewsModel data;
  getData() async {
    final response = await http.get(Uri.parse("https://saurav.tech/NewsAPI/top-headlines/category/health/in.json"),
        headers: {"Content-Type": "application/json"},
    );
    if(response.statusCode==200){
      var parsed=json.decode(response.body);
      setState(() {
        data=NewsModel.fromJson(parsed);
      });

      log("${data.articles.length}");
    }
  }
  allowAccess() async{
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

  }
  @override
  void initState() {
    allowAccess();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          child: Column(
            children: [
              Container(
                height: 50,
                width: width,
                color: Colors.black,
                alignment: Alignment.center,
                child: Text("NEWS",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,letterSpacing: 0.2),

                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.articles.length,
                  itemBuilder: (ctx,i){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>DetailView(
                            title: data.articles[i].title, description: data.articles[i].description,
                            url: data.articles[i].urlToImage,
                            content: data.articles[i].content,
                        )));
                      },
                      child: Container(
                        height: 100,
                        width: width,
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              child:data.articles[i].urlToImage==null?Container():
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: data.articles[i].urlToImage!,
                              ),
                            ),
                            Container(
                              width: width-127,
                              margin: EdgeInsets.only(left: 7),
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  SingleChildScrollView(
                                      scrollDirection:Axis.horizontal,
                                      child: Text("${data.articles[i].title}",
                                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),
                                      ),
                                  ),
                                  SizedBox(height: 10,),
                                  Expanded(child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Text("${data.articles[i].description}"))),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

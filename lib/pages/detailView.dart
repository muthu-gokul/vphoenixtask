import 'package:flutter/material.dart';
class DetailView extends StatefulWidget {
  String title;
  String? content;
  String description;
  String? url;

  DetailView({required this.title,this.content,required this.description,this.url});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {

  late double height,width;

  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: width,
                child: Text("${widget.title}",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16)
                ),
              ),
              Container(
                height: 200,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: width,
                child:widget.url==null?Container():
                Image.network(widget.url!,fit: BoxFit.cover,),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: width*0.9,
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  child: Text("${widget.description}",textAlign: TextAlign.center,),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20,bottom: 10,left: 10,right: 10),
                child: Text("${widget.content}",textAlign: TextAlign.left,),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

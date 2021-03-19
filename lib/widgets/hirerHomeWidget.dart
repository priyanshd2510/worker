import 'package:flutter/material.dart';
import '../model/dummy_catg.dart';
import './workercatgitem.dart';
import 'package:provider/provider.dart';
import '../model/hirer.dart';

class HireHomeWidget extends StatefulWidget {
  @override
  _HireHomeWidgetState createState() => _HireHomeWidgetState();
}

class _HireHomeWidgetState extends State<HireHomeWidget> {
  String city;
  @override
  Widget build(BuildContext context) {
    final hirer=Provider.of<Hirer>(context);

    return hirer==null?Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    ):Column(
      children: [
        Expanded(
          child: Container(
            child:GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding:const EdgeInsets.all(0),
                children:DUMMY_CATEGORIES.map((catData) =>WorkersCategoeryItem(
                    catData.id,
                    catData.title,
                    catData.image,
                    hirer,
                )).toList()
            ) ,
          ),
        )
      ],
    );
  }
}

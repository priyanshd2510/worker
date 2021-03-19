import 'package:flutter/material.dart';
import '../model/hirer.dart';
import '../model/workers.dart';
import 'package:provider/provider.dart';
import '../widgets/workerlistWidget.dart';

class getList extends StatefulWidget {
  String catg;
  String city;
  Hirer hirer;

  getList({this.catg, this.city,this.hirer});

  @override
  _getListState createState() => _getListState();
}

class _getListState extends State<getList> {
  List<Workers> availWorker = [];

  @override
  Widget build(BuildContext context) {
    final Allworkers = Provider.of<List<Workers>>(context);
    // final currentHirer=DatabaseService(isWorker: false,uid: FirebaseAuth.instance.currentUser.uid).CurrentHirer;
    if (Allworkers != null) {
      // print(widget.city);
      // print('hello ${widget.catg}');
      Allworkers.forEach((element) {
        if (element.catg.compareTo(widget.catg) == 0 &&
            element.city.compareTo(widget.city) == 0) {
          // print(element.city);
          // print(element.catg);
          availWorker.add(element);
        }
      });
    }
    return Allworkers == null
        ? Container(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
            itemCount: availWorker.length,
            itemBuilder: (context, index) {
              return ListWidget(availWorker[index],widget.hirer);
            },
          );
  }

}

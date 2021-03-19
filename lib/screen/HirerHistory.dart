import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/hirer.dart';
import '../model/reqModal.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/databaseServices.dart';
import '../model/workers.dart';

class HirerHistory extends StatefulWidget {
  @override
  _HirerHistoryState createState() => _HirerHistoryState();
}

class _HirerHistoryState extends State<HirerHistory> {
  @override
  Widget build(BuildContext context) {
    final hirer = Provider.of<Hirer>(context);
    List<Request> reqs = [];
    hirer.reqs.forEach((element) {
      // print(element['workername']);
      Request curReq = Request(
        workerName: element['workername'],
        workerPhone: element['workerphone'],
        workerImg: element['workerimg'],
        workerCity: element['workercity'],
        date: element['date'],
        isAccept: element['isAccept'],
        workerUid: element['workerUid'],
        hirerUid: element['hirerUid'],
      );
      reqs.add(curReq);
    });

    void _onPressed(int index) {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          context: context,
          builder: (context) {
            return Container(
              height: 100,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Colors.red[900],
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    onPressed: () async {
                      print(reqs[index].workerUid);
                      Workers wr = await DatabaseService(
                              uid: reqs[index].workerUid, isWorker: true)
                          .currWorker;
                      int indexofwr=wr.reqs.indexWhere((element){
                        if(element['date']==reqs[index].date && element['hirername'].toString().compareTo(reqs[index].hirerName)==0){
                          // print("yess");
                          return true;
                        }else{
                          return false;
                        }
                      });
                      wr.reqs.removeAt(indexofwr);
                      await DatabaseService(uid: wr.uid, isWorker: true)
                          .removeField(wr.reqs[indexofwr]);

                      hirer.reqs.removeAt(index);
                      await DatabaseService(uid: hirer.uid, isWorker: false)
                          .removeField(hirer.reqs[index]);
                      print(hirer.reqs.length);

                      Navigator.of(context).popUntil(ModalRoute.withName('/profile'));

                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Cancel Appointment',
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    }

    return Container(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        itemCount: reqs.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => _onPressed(index),
            // splashColor: Colors.indigoAccent,
            child: Container(
              // color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 2),
              child: ShapeOfView(
                shape: CutCornerShape(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 20,
                child: Container(
                  // color: Colors.white,
                  width: 500,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 6),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ShapeOfView(
                            shape: RoundRectShape(
                              borderRadius: BorderRadius.circular(30),
                              borderColor: Colors.white,
                              //optional
                              borderWidth: 2, //optional
                            ),
                            // elevation: 10,
                            child: Container(
                              height: 80,
                              width: 80,
                              child: Image(
                                image: NetworkImage(reqs[index].workerImg),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reqs[index].workerName,
                                  style: GoogleFonts.roboto(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_city,
                                      color: Colors.indigo[900],
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      reqs[index].workerCity,
                                      style: GoogleFonts.roboto(
                                          color: Colors.indigo[900],
                                          fontSize: 18),
                                    ),
                                    Text(
                                      ' | ',
                                      style: GoogleFonts.roboto(
                                          color: Colors.grey[400]),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      child: reqs[index].isAccept
                                          ? Text('Accepted',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  color: Colors.green))
                                          : Text('Not Accepted',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  color: Colors.red)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

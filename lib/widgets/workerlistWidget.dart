import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/workers.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/reqModal.dart';
import '../model/hirer.dart';
import '../model/databaseServices.dart';

class ListWidget extends StatefulWidget {
  Workers curworker;
  Hirer hirer;

  ListWidget(this.curworker,this.hirer);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  DateTime pickedDate;

  void customUrl(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch ${command}');
    }
  }

  void datePicker() async {
    DateTime curDate = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: pickedDate,
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (curDate != null) {
      setState(() {
        // print(curDate);
        // pickedDate = curDate;
        String date='${curDate.day}-${curDate.month}-${curDate.year}';
        Request req=Request(
          hirerCity: widget.hirer.city,
          hirerName: widget.hirer.name,
          hirerImg: widget.hirer.profileimg,
          hirerPhone: widget.hirer.phnnumber,
          workerPhone: widget.curworker.phnnumber,
          workerCity: widget.curworker.city,
          workerImg: widget.curworker.profileimg,
          workerName: widget.curworker.name,
          date: date,
          isAccept: false,
          workerUid: widget.curworker.uid,
          hirerUid: widget.hirer.uid,
        );
        widget.curworker.reqs.add(req);
        widget.hirer.reqs.add(req);
        // print(widget.curworker.reqs[0]);
        widget.curworker.reqs.forEach((element) async{
          await DatabaseService(uid: widget.curworker.uid,isWorker: true).updateWorker(element);
        });
        widget.hirer.reqs.forEach((element) async{
          await DatabaseService(uid: widget.hirer.uid,isWorker: false).updateWorker(element);
        });
        Navigator.of(context).popUntil(ModalRoute.withName('/profile'));
      });
    }
  }

  void _onPressed() {
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 15,
                  onPressed: () {
                    customUrl('tel:${widget.curworker.phnnumber}');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: Colors.indigo,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Call',
                        style: GoogleFonts.roboto(
                            color: Colors.indigo,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: Colors.indigo,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 15,
                  onPressed: datePicker,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Hire',
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onPressed,
      splashColor: Colors.indigoAccent,
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
                        borderColor: Colors.white, //optional
                        borderWidth: 2, //optional
                      ),
                      child: Container(
                        height: 80,
                        width: 80,
                        child: Image(
                          image: NetworkImage(widget.curworker.profileimg),
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
                            widget.curworker.name,
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
                                widget.curworker.city,
                                style: GoogleFonts.roboto(
                                    color: Colors.indigo[900], fontSize: 18),
                              ),
                              Text(
                                ' | ',
                                style:
                                    GoogleFonts.roboto(color: Colors.grey[400]),
                              ),
                              Icon(
                                Icons.star_outline,
                                color: Colors.yellow,
                                size: 24,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '4.5',
                                style: GoogleFonts.roboto(
                                    fontSize: 18, color: Colors.grey),
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickedDate = DateTime.now();
  }
}

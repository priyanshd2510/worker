import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/databaseServices.dart';
import '../HirerHome.dart';
import '../WorkerHome.dart';

class getAddress extends StatefulWidget {

  static final getaddroute='/getadd';

  @override
  _getAddressState createState() => _getAddressState();
}

class _getAddressState extends State<getAddress> {

  String address;
  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var arg=ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var obj=arg['obj'];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        actions: [
          FlatButton(
            onPressed: () async {
              if(address.isNotEmpty && (!obj.isworker)){
                obj.address=address;
                obj.reqs=[];
                print("inside");
                DatabaseService(uid: auth.currentUser.uid,isWorker: obj.isworker).updateUserData(obj);
                Navigator.of(context).popAndPushNamed(Profile.profileRoute,arguments: {'obj':obj});
              }else if(address.isNotEmpty && obj.isworker){
                obj.address=address;
                obj.reqs=[];
                print("inside");
                DatabaseService(uid: auth.currentUser.uid,isWorker: obj.isworker).updateUserData(obj);
                Navigator.of(context).popAndPushNamed(WorkerHome.workerhomerout,arguments: {'obj':obj});
              }
            },
            child: Text(
              'Next',
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        color: Colors.indigo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your address' ,
                  style: GoogleFonts.roboto(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              child: TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Address',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.white60)),
                ),
                maxLength: 100,
                style: TextStyle(color: Colors.indigo[50], fontSize: 20,),
                onFieldSubmitted: (value){
                  setState(() {
                    address=value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

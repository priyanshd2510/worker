import 'package:flutter/material.dart';
import 'package:worker/screen/HirerHistory.dart';
import '../widgets/hirerHomeWidget.dart';
import '../widgets/homeDrawer.dart';
import 'package:provider/provider.dart';
import '../model/databaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/hirer.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  static final profileRoute = '/profile';

  // var imgurl=DatabaseService(isWorker: false,uid: FirebaseAuth.instance.currentUser.uid).getImg();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _currentindex = 0;
  final screen = [
    HireHomeWidget(),
    HirerHistory(),
  ];

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: StreamProvider<Hirer>.value(
        value: DatabaseService(
                isWorker: false, uid: FirebaseAuth.instance.currentUser.uid).getcurrentHirer,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Worker',style: GoogleFonts.metamorphous(fontSize: 25,fontWeight: FontWeight.bold),),
            elevation: 0,
            centerTitle: true,
          ),
          body: screen[_currentindex],
          drawer: HomeDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentindex,
            // type: BottomNavigationBarType.shifting,
            backgroundColor: Colors.indigo,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,),
                title: Text('Home',),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.schedule),
                title: Text('History'),
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentindex = index;
              });
            },
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            elevation: 0,
          ),
        ),
      ),
    );
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // DatabaseService(isWorker: false, uid: FirebaseAuth.instance.currentUser.uid)
  //   //     .getImg();
  //   super.initState();
  // }
}

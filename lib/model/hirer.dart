import './reqModal.dart';

class Hirer {
  String uid, name, city, state, phnnumber, country, profileimg, address;
  List<dynamic> reqs=[];
  List<Request> history;
  bool isworker=false;

  Hirer({this.uid, this.city, this.state, this.name, this.phnnumber, this.country, this.profileimg, this.address,this.isworker,this.reqs});
}

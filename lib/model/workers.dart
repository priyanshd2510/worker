import './reqModal.dart';

class Workers{

  final String uid;
  String name,profileimg,state,city,country,phnnumber,address,catg;
  bool isworker=true;
  List<dynamic>reqs=[];

  Workers({this.uid,this.name,this.profileimg,this.state,this.city, this.catg, this.country,this.phnnumber,this.address,this.isworker,this.reqs});


  // Map<String,dynamic> toMap() => {
  //   "name": this.name,
  //   "address": this.address,
  //   "reqs": this.reqs,
  //   "catg":this.catg,
  //   "city":this.city,
  //   "state":this.state,
  //   "country":this.country,
  //   "imgurl":this.profileimg,
  //   "phone":this.phnnumber,
  //   "isWorker":this.isworker,
  // };
}
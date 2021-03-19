import 'package:flutter/material.dart';
import '../model/workers.dart';
import 'package:shape_of_view/shape_of_view.dart';

class WorkerDetailScreen extends StatelessWidget {
  static final workerdetail = '/workerdetail';

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, Workers>;
    Workers worker = args['currobj'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
        // title: Text('Worker Detail'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            ShapeOfView(
              shape: ArcShape(
                direction: ArcDirection.Inside,
                height: 40,
                position: ArcPosition.Bottom,
              ),
              elevation: 5,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: Colors.indigoAccent,
              ),
            ),
            Container(
              child: Text('hello'),
            ),
          ],
        ),
      ),
    );
  }
}

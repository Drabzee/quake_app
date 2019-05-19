import 'package:flutter/material.dart';
import '../models/quakeModel.dart';
import 'package:intl/intl.dart';

class HomePageView extends StatelessWidget {

  void _showDialog(BuildContext context, String desc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Earthquake'),
          content: Text(desc),
          actions: <Widget>[
            FlatButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Widget getListView(AsyncSnapshot snapshot, BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('${snapshot.data[index].mag}'),
          ),
          title: Text(snapshot.data[index].place),
          subtitle: Text(DateFormat.yMMMMd("en_US").add_jm().format(snapshot.data[index].time)),
          onTap: () {
            _showDialog(context, snapshot.data[index].title);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: fetchQuakes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            return getListView(snapshot, context);
          }
          else if(snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      )
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quake App'),
        centerTitle: true,
      ),
      body: HomePageView()
    );
  }
}
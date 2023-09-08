import 'package:batrena/main.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:flutter/material.dart';


class BranchHomeScreen extends StatefulWidget {
  const BranchHomeScreen({super.key});

  @override
  State<BranchHomeScreen> createState() => _BranchHomeScreenState();
}

class _BranchHomeScreenState extends State<BranchHomeScreen> {
  List<dynamic> parentItems = [];
  Future<bool> get loadData async {
    await DioHelper.getData(url: "protected/FetchBranchData", jwt: jwt).then((value) => parentItems = value.data["parent_items"]);
    return true;
  }
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(future: loadData, builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Scaffold(
          body: ListView.builder(itemCount: parentItems.length, itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              child: Text("${parentItems[index]["name"]} ${parentItems[index]["price"]} (${parentItems[index]["items"].length})"),
            );
          },),
        );
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}

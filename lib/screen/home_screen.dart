import 'package:flutter/material.dart';
import 'package:user_data_app/model/user_data_list.dart';
import 'package:user_data_app/services/http_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HttpService httpService = HttpService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    httpService.getUserDataResponse();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: httpService.getUserDataResponse(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            List<Result> user = snapshot.data!;
            return ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("${user[index].picture!.large}"),
                  ),
                  title: Text("${user[index].name!.title} ${user[index].name!.first} ${user[index].name!.last}"),
                  subtitle: Text("${user[index].email}"),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

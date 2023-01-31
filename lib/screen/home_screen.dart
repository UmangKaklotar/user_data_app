import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_data_app/model/user_model.dart';
import 'package:user_data_app/services/http_service.dart';
import 'package:user_data_app/utils/api_string.dart';
import 'package:user_data_app/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random User Data", style: TextStyle(fontSize: 20, color: UserDataColor.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CupertinoTextField(
              keyboardType: TextInputType.number,
              placeholder: "Enter the Number of People",
              placeholderStyle: GoogleFonts.poppins(color: UserDataColor.grey),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              onChanged: (val){
                setState(() {
                  ApiUtils.people = val;
                });
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: httpService.getUserDataResponse(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    List<Result> user = snapshot.data!;
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      physics: const BouncingScrollPhysics(),
                      itemCount: user.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: UserDataColor.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ExpansionTile(
                              leading: CircleAvatar(backgroundImage: NetworkImage("${user[index].picture!.large}"),),
                              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                              title: Text("${user[index].name!.title} ${user[index].name!.first} ${user[index].name!.last}", style: GoogleFonts.poppins(color: UserDataColor.black),),
                              subtitle: Text("${user[index].email}", style: GoogleFonts.poppins(color: UserDataColor.grey),),
                              expandedAlignment: Alignment.centerLeft,
                              childrenPadding: const EdgeInsets.all(10),
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Phone No : ${user[index].phone} / ${user[index].cell}"),
                                Text("Gender : ${user[index].gender}"),
                                Text("DOB : ${user[index].dob!.date}"),
                                Text("Age : ${user[index].dob!.age}"),
                                Text("Register Date : ${user[index].registered!.date}"),
                                Text("Register Age : ${user[index].registered!.age}"),
                                Text("ID Name : ${user[index].id!.name}"),
                                Text("ID Value : ${user[index].id!.value}"),
                                Text("Nationality : ${user[index].nat}"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Location :: "),
                                    Expanded(child: Text("${user[index].location!.street!.number}, ${user[index].location!.street!.name}, "
                                                         "${user[index].location!.city}, ${user[index].location!.state}, "
                                                         "${user[index].location!.country}, ${user[index].location!.postcode}, "),),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Coordinates :: "),
                                    Expanded(child: Text("Latitude : ${user[index].location!.coordinates!.latitude}\n"
                                                         "Longitude : ${user[index].location!.coordinates!.longitude}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Timezon :: "),
                                    Expanded(child: Text("OffSet : ${user[index].location!.timezone!.offset}\n"
                                                         "Description : ${user[index].location!.timezone!.description}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Login :: "),
                                    Expanded(child: Text("Username : ${user[index].login!.username}\n"
                                                         "Password : ${user[index].login!.password}"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: UserDataColor.bgColor,
    );
  }
}

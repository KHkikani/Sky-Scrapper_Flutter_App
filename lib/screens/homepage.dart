import 'package:flutter/material.dart';

import '../helper/random_people_data_api_helper.dart';
import '../models/random_data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random People's Data"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: UserAPI.userAPI.fetchUserAPI(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            RandomData? data = snapshot.data;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                data!.image,
                              ),
                              backgroundColor: Colors.grey,
                              radius: 45,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name"),
                                    Text(
                                      "${data.title} ${data.firstName} ${data.lastName}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        customRow("Username", data.username),
                        customRow("Email", data.email),
                        customRow("Phone", data.phone),
                        customRow("Gender", data.gender),
                        customRow("Age", data.age),
                        customRow("Address", data.address),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  customRow(fldName, data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        children: [
          Text(
            "$fldName",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          // const Spacer(),
          Text(
            "$data",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}

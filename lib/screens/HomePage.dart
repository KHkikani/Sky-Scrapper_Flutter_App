import 'package:flutter/material.dart';

import '../helper/CovidAPIHelper.dart';
import '../models/Covid19Model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic selectedCountry;
  List country = [];
  List flag = [];
  dynamic i=0;
  TextStyle titleStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Covid Cases Tracker"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              child: FutureBuilder(
                future: CovidAPIHelper.covidAPIHelper.covidCasesData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    List<Covid19> data = snapshot.data as List<Covid19>;
                    country = data.map((e) => e.country).toList();
                    return Container(
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: DropdownButtonFormField(
                                hint: const Text("Please Select Country."),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                value: country[i],
                                onChanged: (val) {
                                  setState(() {
                                    i = country.indexOf(val);
                                  });
                                },
                                items: country
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Image.network(
                                            data[i].flag,
                                            height: 40,
                                            width: 80,
                                            fit: BoxFit.fill,
                                          ),
                                          const Spacer(),
                                          Column(
                                            children: [
                                              Text(
                                                data[i].country,
                                                style: titleStyle,
                                              ),
                                              Text(
                                                "Population: ${data[i].population}",
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    infoCard(
                                      title: "Total Cases",
                                      totalCount: data[i].totalCases,
                                      color: Colors.blueGrey,
                                    ),
                                    infoCard(
                                        title: "Active",
                                        totalCount: data[i].activeCases,
                                        color: Colors.blue),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    infoCard(
                                        title: "Total Recovered",
                                        totalCount: data[i].totalRecovered,
                                        color: Colors.blue),
                                    infoCard(
                                        title: "Total Deaths",
                                        totalCount: data[i].totalDeaths,
                                        color: Colors.black),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

infoCard({required title, required totalCount, required color}) {
  return Card(
    elevation: 5,
    child: Container(
      height: 80,
      width: 150,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            "$totalCount",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ],
      ),
    ),
  );
}

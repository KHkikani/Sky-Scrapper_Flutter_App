import 'package:currency_converter/Global/global.dart';
import 'package:currency_converter/helper/currency_api_helper.dart';
import 'package:currency_converter/models/allcurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/currency.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: Global.globalKey);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle textStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w400);

  dynamic from = 'USD';
  dynamic to = 'INR';
  num amount = 1;

  @override
  Widget build(BuildContext context) {
    return (!Global.isIOS)
        ? Scaffold(
            backgroundColor: Colors.white.withOpacity(0.95),
            appBar: AppBar(
              leading:
              Switch(
                  value: Global.isIOS,
                  onChanged: (val) {
                    Global.globalKey.currentState!.setState(() {
                      Global.isIOS = val;
                    });
                  }),
              title: Text("Currency Converter"),
              centerTitle: true,
              elevation: 0,
              actions: [
                FutureBuilder(
                  future: CurrencyAPIHelper.currencyAPIHelper
                      .fetchAllCurrencyData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error = ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      AllCurrency? data = snapshot.data;
                      return IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Container(
                                  height: 500,
                                  width: 200,
                                  child: ListView.builder(
                                    itemBuilder: (context, i) => ListTile(
                                      title: Text(
                                          "${data.allCurrencyList[i][0]} - ${data.allCurrencyList[i][1]}"),
                                    ),
                                    itemCount: data!.allCurrencyList.length,
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.list));
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FutureBuilder(
                      future: CurrencyAPIHelper.currencyAPIHelper
                          .fetchAllCurrencyData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error = ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          AllCurrency? data = snapshot.data;
                          return DropdownButton(
                              value: from,
                              items: data!.allCurrencyList
                                  .map((e) => DropdownMenuItem(
                                        alignment: Alignment.center,
                                        value: "${e[0]}",
                                        child: Text(
                                          "${e[0]}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  from = val;
                                  print(val);
                                  print(val.runtimeType);
                                });
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    Icon(Icons.currency_exchange),
                    FutureBuilder(
                      future: CurrencyAPIHelper.currencyAPIHelper
                          .fetchAllCurrencyData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error = ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          AllCurrency? data = snapshot.data;
                          return DropdownButton(
                              value: to,
                              items: data!.allCurrencyList
                                  .map((e) => DropdownMenuItem(
                                        alignment: Alignment.center,
                                        value: "${e[0]}",
                                        child: Text(
                                          "${e[0]}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  to = val;
                                  print(val);
                                  print(val.runtimeType);
                                });
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: TextEditingController(text: amount.toString()),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter $from",
                    ),
                    onChanged: (val) {
                      setState(() {
                        amount = num.parse(val);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                FutureBuilder(
                  future: CurrencyAPIHelper.currencyAPIHelper.fetchCurrencyData(
                      from: '$from', to: '$to', amount: amount),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error = ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      Currency? data = snapshot.data;

                      return Card(
                        elevation: 3,
                        child: Container(
                          // height: 175,
                          width: 250,
                          padding: EdgeInsets.all(25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$amount $from = ${data!.result} $to",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Text(
                                "From : ${data.from}",
                                style: textStyle,
                              ),
                              Text(
                                "To : ${data.to}",
                                style: textStyle,
                              ),
                              Text(
                                "Amount : ${data.amount}",
                                style: textStyle,
                              ),
                              Text(
                                "Result : ${data.result}",
                                style: textStyle,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ))
        : CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: CupertinoPageScaffold(
              child: Column(
                children: [
                  CupertinoNavigationBar(
                    // leading: FutureBuilder(
                    //   future: CurrencyAPIHelper.currencyAPIHelper
                    //       .fetchAllCurrencyData(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasError) {
                    //       return Text("Error = ${snapshot.error}");
                    //     } else if (snapshot.hasData) {
                    //       AllCurrency? data = snapshot.data;
                    //       return GestureDetector(
                    //           onTap: () {
                    //             showDialog(
                    //               context: context,
                    //               builder: (context) => Dialog(
                    //                 child: Container(
                    //                   padding: EdgeInsets.all(10),
                    //                   height: 500,
                    //                   width: 200,
                    //                   child: SingleChildScrollView(
                    //                     physics: BouncingScrollPhysics(),
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: data!.allCurrencyList
                    //                           .map(
                    //                             (e) => Text(
                    //                               "${e[0]} - ${e[1]}",
                    //                               style: TextStyle(
                    //                                   fontSize: 16,
                    //                                   fontWeight:
                    //                                       FontWeight.w500,
                    //                                   height: 2),
                    //                             ),
                    //                           )
                    //                           .toList(),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //           child: Icon(CupertinoIcons.list_bullet));
                    //     } else {
                    //       return const CupertinoActivityIndicator();
                    //     }
                    //   },
                    // ),
                    middle: Text("Currency Converter"),
                    trailing: CupertinoSwitch(
                      value: Global.isIOS,
                      onChanged: (val) {
                        Global.globalKey.currentState!.setState(
                          () {
                            Global.isIOS = val;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FutureBuilder(
                        future: CurrencyAPIHelper.currencyAPIHelper
                            .fetchAllCurrencyData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error = ${snapshot.error}");
                          } else if (snapshot.hasData) {
                            AllCurrency? data = snapshot.data;
                            return CupertinoButton(
                              child: Text(
                                '$from',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ),
                              onPressed: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (_) => SizedBox(
                                    width: 300,
                                    height: 250,
                                    child: CupertinoPicker(
                                      backgroundColor: Colors.white,
                                      itemExtent: 30,
                                      scrollController:
                                          FixedExtentScrollController(
                                        initialItem:
                                            data!.allCurrencyList.length,
                                      ),
                                      children: data.allCurrencyList
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                          value: value[0],
                                          child: Center(
                                            child: Text("${value[0]}"),
                                          ),
                                        );
                                      }).toList(),
                                      onSelectedItemChanged: (val) {
                                        setState(() {
                                          from = data.allCurrencyList[val][0];
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return CupertinoActivityIndicator();
                          }
                        },
                      ),
                      Icon(Icons.currency_exchange),
                      FutureBuilder(
                        future: CurrencyAPIHelper.currencyAPIHelper
                            .fetchAllCurrencyData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error = ${snapshot.error}");
                          } else if (snapshot.hasData) {
                            AllCurrency? data = snapshot.data;
                            return CupertinoButton(
                              child: Text(
                                '$to',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ),
                              onPressed: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (_) => SizedBox(
                                    width: 300,
                                    height: 250,
                                    child: CupertinoPicker(
                                      backgroundColor: Colors.white,
                                      itemExtent: 30,
                                      scrollController:
                                          FixedExtentScrollController(
                                        initialItem:
                                            data!.allCurrencyList.length,
                                      ),
                                      children: data.allCurrencyList
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                          value: value[0],
                                          child: Center(
                                            child: Text("${value[0]}"),
                                          ),
                                        );
                                      }).toList(),
                                      onSelectedItemChanged: (val) {
                                        setState(() {
                                          to = data.allCurrencyList[val][0];
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return CupertinoActivityIndicator();
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: CupertinoTextField(
                      controller:
                          TextEditingController(text: amount.toString()),
                      keyboardType: TextInputType.number,
                      // decoration: InputDecoration(
                      //   border: OutlineInputBorder(),
                      //   hintText: "Enter $from",
                      // ),
                      placeholder: "Enter $from",
                      onChanged: (val) {
                        setState(() {
                          amount = num.parse(val);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  FutureBuilder(
                    future: CurrencyAPIHelper.currencyAPIHelper
                        .fetchCurrencyData(
                            from: '$from', to: '$to', amount: amount),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Error = ${snapshot.error}");
                      } else if (snapshot.hasData) {
                        Currency? data = snapshot.data;

                        return Container(
                          color: Colors.white,
                          // height: 175,
                          width: 250,
                          padding: EdgeInsets.all(25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$amount $from = ${data!.result} $to",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Text(
                                "From : ${data.from}",
                                style: textStyle,
                              ),
                              Text(
                                "To : ${data.to}",
                                style: textStyle,
                              ),
                              Text(
                                "Amount : ${data.amount}",
                                style: textStyle,
                              ),
                              Text(
                                "Result : ${data.result}",
                                style: textStyle,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return CupertinoActivityIndicator();
                      }
                    },
                  )
                ],
              ),
            ),
          );
  }
}

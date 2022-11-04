import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/Covid19Model.dart';

class CovidAPIHelper {
  CovidAPIHelper._();

  static final CovidAPIHelper covidAPIHelper = CovidAPIHelper._();

  String url = "https://disease.sh/v3/covid-19/countries";

  Future<List<Covid19>?> covidCasesData() async {
    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      List decodedData = jsonDecode(res.body);

      List<Covid19> covidData =
      decodedData.map((e) => Covid19.fromJSON(json: e)).toList();

      return covidData;
    }
    return null;
  }
}
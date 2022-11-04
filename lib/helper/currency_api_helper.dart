import 'dart:convert';

import 'package:currency_converter/models/currency.dart';
import 'package:http/http.dart' as http;

import '../models/allcurrency.dart';

class CurrencyAPIHelper {
  CurrencyAPIHelper._();

  static final CurrencyAPIHelper currencyAPIHelper = CurrencyAPIHelper._();

  final String url = "currency-converter-pro1.p.rapidapi.com";
  final String path = "/convert";
  final Map<String, String> headers = {
    'X-RapidAPI-Key': '26ca92fbe1msh956e55281d41df7p18d960jsnd961d630d2f2',
    'X-RapidAPI-Host': 'currency-converter-pro1.p.rapidapi.com'
  };

  Future<Currency?> fetchCurrencyData(
      {required String from, required String to, required num amount}) async {
    Uri uri = Uri.parse(
        "https://currency-converter-pro1.p.rapidapi.com/convert?from=$from&to=$to&amount=$amount");

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      Map decodedData = jsonDecode(res.body);

      Currency currency = Currency.fromJson(data: decodedData);

      return currency;
    }
    return null;
  }

  Future<AllCurrency?> fetchAllCurrencyData() async {
    Uri uri =
        Uri.parse("https://currency-converter-pro1.p.rapidapi.com/currencies");

    http.Response res = await http.get(uri, headers: headers);

    if (res.statusCode == 200) {
      Map decodedData = jsonDecode(res.body);

      AllCurrency allCurrency = AllCurrency.fromJson(data: decodedData['result']);

      return allCurrency;
    }
    return null;
  }
}

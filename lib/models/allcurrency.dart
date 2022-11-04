class AllCurrency {
  List<List<String>> allCurrencyList;

  AllCurrency({required this.allCurrencyList});

  factory AllCurrency.fromJson({required Map data}) {

    List<List<String>> allCurrency = [];

    data.forEach((key, value) {
      allCurrency.add(["$key","$value"]);
    });

    // AllCurrency allCurrency = AllCurrency(allCurrencyMap: data);

    return AllCurrency(allCurrencyList: allCurrency);
  }
}

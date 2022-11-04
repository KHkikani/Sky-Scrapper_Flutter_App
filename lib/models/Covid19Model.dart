class Covid19 {
  final String country;
  final String flag;
  final int? population;
  final int? totalCases;
  final int? activeCases;
  final int? totalRecovered;
  final int? totalDeaths;

  Covid19({
    required this.country,
    required this.flag,
    required this.population,
    required this.totalCases,
    required this.activeCases,
    required this.totalRecovered,
    required this.totalDeaths,
  });

  factory Covid19.fromJSON({required Map<String, dynamic> json}) {
    return Covid19(
      country: json['country'],
      flag: json['countryInfo']['flag'],
      population: json['population'],
      totalCases: json['cases'],
      activeCases: json['active'],
      totalRecovered: json['recovered'],
      totalDeaths: json['deaths'],
    );
  }
}
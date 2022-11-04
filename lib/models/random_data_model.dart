class RandomData {
  final String image;
  final String title;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phone;
  final String gender;
  final int age;
  final String address;

  RandomData({
    required this.image,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
    required this.gender,
    required this.age,
    required this.address,
  });

  factory RandomData.fromJSON({required Map<String, dynamic> json}) {
    return RandomData(
      image: json['results'][0]['picture']['large'],
      title: json['results'][0]['name']['title'],
      firstName: json['results'][0]['name']['first'],
      lastName: json['results'][0]['name']['last'],
      username: json['results'][0]['login']['username'],
      email: json['results'][0]['email'],
      phone: json['results'][0]['phone'],
      gender: json['results'][0]['gender'],
      age: json['results'][0]['registered']['age'],
      address:
      "${json["results"][0]["location"]["street"]["number"]}, ${json["results"][0]["location"]["street"]["name"]}, ${json["results"][0]["location"]["city"]}, ${json["results"][0]["location"]["state"]}, ${json["results"][0]["location"]["country"]} - ${json["results"][0]["location"]["postcode"]}",
    );
  }
}
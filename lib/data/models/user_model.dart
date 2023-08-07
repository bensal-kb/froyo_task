class UserModel {
  double lat;
  double long;
  String theme;
  int color;
  int textSize;

  UserModel(
      {required this.lat,
      required this.long,
      required this.theme,
      required this.color,
      required this.textSize});

  String getId() => '$lat-$long';

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
      'theme': theme,
      'color': color,
      'textSize': textSize,
    };
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : lat = json['lat'],
        long = json['long'],
        theme = json['theme'],
        color = json['color'],
        textSize = json['textSize'];
}

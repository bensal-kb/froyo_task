class Validators {
  static String? validateLat(String? str) {
    if(str == null || str.isEmpty) {
      return 'Latitude cannot be empty';
    }
    double? lat = double.tryParse(str);
    if(lat == null) {
      return 'Latitude entered is invalid';
    }
    if(lat<-90.0 || lat>90.0) {
      return 'Latitude entered is out of range';
    }
    return null;
  }

  static String? validateLong(String? str) {
    if(str == null || str.isEmpty) {
      return 'Longitude cannot be empty';
    }
    double? long = double.tryParse(str);
    if(long == null) {
      return 'Longitude entered is invalid';
    }
    if(long<-180.0 || long>180.0) {
      return 'Longitude entered is out of range';
    }
    return null;
  }
}
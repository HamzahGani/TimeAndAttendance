class OutsideGeofence {
  List<Outsidegeo> outsidegeo;

  OutsideGeofence({this.outsidegeo});

  OutsideGeofence.fromJson(Map<String, dynamic> json) {
    if (json['outsidegeo'] != null) {
      outsidegeo = new List<Outsidegeo>();
      json['outsidegeo'].forEach((v) {
        outsidegeo.add(new Outsidegeo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.outsidegeo != null) {
      data['outsidegeo'] = this.outsidegeo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Outsidegeo {
  String name;
  String date;
  String coordinates;
  String timeIn;
  String timeOut;

  Outsidegeo(
      {this.name, this.date, this.coordinates, this.timeIn, this.timeOut});

  Outsidegeo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    coordinates = json['coordinates'];
    timeIn = json['timeIn'];
    timeOut = json['timeOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    data['coordinates'] = this.coordinates;
    data['timeIn'] = this.timeIn;
    data['timeOut'] = this.timeOut;
    return data;
  }
}

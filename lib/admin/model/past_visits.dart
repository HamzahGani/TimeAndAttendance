class PunchedVisits {
  List<Visits> visits;

  PunchedVisits({this.visits});

  PunchedVisits.fromJson(Map<String, dynamic> json) {
    if (json['visits'] != null) {
      visits = new List<Visits>();
      json['visits'].forEach((v) {
        visits.add(new Visits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.visits != null) {
      data['visits'] = this.visits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Visits {
  String name;
  String timeInImage;
  String timeIn;
  String timeOutImage;
  String timeOut;
  String client;

  Visits(
      {this.name,
        this.timeInImage,
        this.timeIn,
        this.timeOutImage,
        this.timeOut,
        this.client});

  Visits.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    timeInImage = json['timeInImage'];
    timeIn = json['timeIn'];
    timeOutImage = json['timeOutImage'];
    timeOut = json['timeOut'];
    client = json['client'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['timeInImage'] = this.timeInImage;
    data['timeIn'] = this.timeIn;
    data['timeOutImage'] = this.timeOutImage;
    data['timeOut'] = this.timeOut;
    data['client'] = this.client;
    return data;
  }
}

class PeriodicAttendance {
  List<Periodic> periodic;

  PeriodicAttendance({this.periodic});

  PeriodicAttendance.fromJson(Map<String, dynamic> json) {
    if (json['periodic'] != null) {
      periodic = new List<Periodic>();
      json['periodic'].forEach((v) {
        periodic.add(new Periodic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.periodic != null) {
      data['periodic'] = this.periodic.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Periodic {
  String name;
  String date;
  String timeIn;
  String timeOut;

  Periodic({this.name, this.date, this.timeIn, this.timeOut});

  Periodic.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    timeIn = json['timeIn'];
    timeOut = json['timeOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    data['timeIn'] = this.timeIn;
    data['timeOut'] = this.timeOut;
    return data;
  }
}

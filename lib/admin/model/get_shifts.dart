class GetShifts {
  List<Shifts> shifts;

  GetShifts({this.shifts});

  GetShifts.fromJson(Map<String, dynamic> json) {
    if (json['shifts'] != null) {
      shifts = new List<Shifts>();
      json['shifts'].forEach((v) {
        shifts.add(new Shifts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shifts != null) {
      data['shifts'] = this.shifts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shifts {
  String name;
  String type;
  String timeIn;
  String timeOut;
  String status;

  Shifts({this.name, this.type, this.timeIn, this.timeOut, this.status});

  Shifts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    timeIn = json['timeIn'];
    timeOut = json['timeOut'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['timeIn'] = this.timeIn;
    data['timeOut'] = this.timeOut;
    data['status'] = this.status;
    return data;
  }
}

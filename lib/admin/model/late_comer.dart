class LateComers {
  List<Latecomers> latecomers;

  LateComers({this.latecomers});

  LateComers.fromJson(Map<String, dynamic> json) {
    if (json['latecomers'] != null) {
      latecomers = new List<Latecomers>();
      json['latecomers'].forEach((v) {
        latecomers.add(new Latecomers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.latecomers != null) {
      data['latecomers'] = this.latecomers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Latecomers {
  String name;
  String shift;
  String timeIn;
  String lateBy;

  Latecomers({this.name, this.shift, this.timeIn, this.lateBy});

  Latecomers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shift = json['shift'];
    timeIn = json['timeIn'];
    lateBy = json['lateBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['shift'] = this.shift;
    data['timeIn'] = this.timeIn;
    data['lateBy'] = this.lateBy;
    return data;
  }
}

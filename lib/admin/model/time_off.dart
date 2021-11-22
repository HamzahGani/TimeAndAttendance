class TimeOff {
  List<Timeoff> timeoff;

  TimeOff({this.timeoff});

  TimeOff.fromJson(Map<String, dynamic> json) {
    if (json['timeoff'] != null) {
      timeoff = new List<Timeoff>();
      json['timeoff'].forEach((v) {
        timeoff.add(new Timeoff.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timeoff != null) {
      data['timeoff'] = this.timeoff.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timeoff {
  String name;
  String from;
  String to;
  String duration;

  Timeoff({this.name, this.from, this.to, this.duration});

  Timeoff.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    from = json['from'];
    to = json['to'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['from'] = this.from;
    data['to'] = this.to;
    data['duration'] = this.duration;
    return data;
  }
}

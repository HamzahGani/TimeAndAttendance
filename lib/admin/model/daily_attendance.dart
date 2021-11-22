class DailyAttendance {
  List<Daily> daily;

  DailyAttendance({this.daily});

  DailyAttendance.fromJson(Map<String, dynamic> json) {
    if (json['daily'] != null) {
      daily = new List<Daily>();
      json['daily'].forEach((v) {
        daily.add(Daily.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (daily != null) {
      data['daily'] = daily.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Daily {
  String name;
  String timeInImage;
  String timeIn;
  String timeOutImage;
  String timeOut;

  Daily(
      {this.name,
        this.timeInImage,
        this.timeIn,
        this.timeOutImage,
        this.timeOut});

  Daily.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    timeInImage = json['timeInImage'];
    timeIn = json['timeIn'];
    timeOutImage = json['timeOutImage'];
    timeOut = json['timeOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['timeInImage'] = timeInImage;
    data['timeIn'] = timeIn;
    data['timeOutImage'] = timeOutImage;
    data['timeOut'] = timeOut;
    return data;
  }
}

class GetHolidays {
  List<Holidays> holidays;

  GetHolidays({this.holidays});

  GetHolidays.fromJson(Map<String, dynamic> json) {
    if (json['holidays'] != null) {
      holidays = new List<Holidays>();
      json['holidays'].forEach((v) {
        holidays.add(new Holidays.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.holidays != null) {
      data['holidays'] = this.holidays.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Holidays {
  String name;
  String fromDate;
  String toDate;
  String totalDays;

  Holidays({this.name, this.fromDate, this.toDate, this.totalDays});

  Holidays.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    totalDays = json['totalDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['totalDays'] = this.totalDays;
    return data;
  }
}

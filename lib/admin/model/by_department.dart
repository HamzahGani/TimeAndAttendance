class ByDepartment {
  List<Departments> departments;

  ByDepartment({this.departments});

  ByDepartment.fromJson(Map<String, dynamic> json) {
    if (json['departments'] != null) {
      departments = new List<Departments>();
      json['departments'].forEach((v) {
        departments.add(new Departments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.departments != null) {
      data['departments'] = this.departments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Departments {
  String name;
  String total;
  String present;
  String absent;

  Departments({this.name, this.total, this.present, this.absent});

  Departments.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    total = json['total'];
    present = json['present'];
    absent = json['absent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total'] = this.total;
    data['present'] = this.present;
    data['absent'] = this.absent;
    return data;
  }
}

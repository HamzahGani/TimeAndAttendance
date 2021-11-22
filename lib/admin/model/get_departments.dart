class GetDepartments {
  List<Departments> departments;

  GetDepartments({this.departments});

  GetDepartments.fromJson(Map<String, dynamic> json) {
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
  String status;

  Departments({this.name, this.status});

  Departments.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}

class ByDesignation {
  List<Designations> designations;

  ByDesignation({this.designations});

  ByDesignation.fromJson(Map<String, dynamic> json) {
    if (json['designations'] != null) {
      designations = new List<Designations>();
      json['designations'].forEach((v) {
        designations.add(new Designations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.designations != null) {
      data['designations'] = this.designations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Designations {
  String name;
  String total;
  String present;
  String absent;

  Designations({this.name, this.total, this.present, this.absent});

  Designations.fromJson(Map<String, dynamic> json) {
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

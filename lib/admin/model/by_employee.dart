class ByEmployee {
  List<Employee> employee;

  ByEmployee({this.employee});

  ByEmployee.fromJson(Map<String, dynamic> json) {
    if (json['employee'] != null) {
      employee = new List<Employee>();
      json['employee'].forEach((v) {
        employee.add(new Employee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employee != null) {
      data['employee'] = this.employee.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Employee {
  String date;
  String timeInImage;
  String timeIn;
  String timeOutImage;
  String timeOut;
  String status;

  Employee(
      {this.date,
        this.timeInImage,
        this.timeIn,
        this.timeOutImage,
        this.timeOut,
        this.status});

  Employee.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timeInImage = json['timeInImage'];
    timeIn = json['timeIn'];
    timeOutImage = json['timeOutImage'];
    timeOut = json['timeOut'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timeInImage'] = this.timeInImage;
    data['timeIn'] = this.timeIn;
    data['timeOutImage'] = this.timeOutImage;
    data['timeOut'] = this.timeOut;
    data['status'] = this.status;
    return data;
  }
}

class Parent {
  late String parentName;

  Parent(this.parentName);

  Parent.fromJson(Map<String, dynamic> json) {
    parentName = json['parentName'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parentName'] = this.parentName;
    return data;
  }
}
class ProgressModel {
  late String email;
  late String courseName;
  late int progress;

  ProgressModel(this.email, this.courseName, this.progress);

  ProgressModel.withoutProgress(this.email, this.courseName);

  ProgressModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    courseName = json['courseName'];
    progress = json['progress'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['courseName'] = this.courseName;
    data['progress'] = this.progress;
    return data;
  }
}
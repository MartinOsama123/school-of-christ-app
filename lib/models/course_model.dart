class CourseInfo {
  late String courseName;
  late String courseCategory;
  late String courseDescription;
  late String courseLink;


  CourseInfo(this.courseName, this.courseCategory, this.courseDescription,
      this.courseLink);
  CourseInfo.fromJson(Map<String, dynamic> json) {
    courseName = json['courseName'];
    courseCategory = json['courseCategory'];
    courseDescription = json['courseDescription'];
    courseLink = json['courseLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseName'] = this.courseName;
    data['courseCategory'] = this.courseCategory;
    data['courseDescription'] = this.courseCategory;
    data['courseLink'] = this.courseLink;
    return data;
  }
}
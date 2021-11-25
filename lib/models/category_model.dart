class Category {
  late String categoryName;
  late String categoryDescription;
  late String categoryImgPath;
  late String categoryParent;

  Category(this.categoryName, this.categoryImgPath, this.categoryParent,this.categoryDescription);
  Category.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryDescription = json['categoryDescription'];
    categoryImgPath = json['categoryImgPath'];
    categoryParent = json['categoryParent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['categoryDescription'] = this.categoryDescription;
    data['categoryImgPath'] = this.categoryImgPath;
    data['categoryParent'] = this.categoryParent;
    return data;
  }
}
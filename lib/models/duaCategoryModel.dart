class DuaCategoryModel {
  List<DuaCategories> duaCategories;

  DuaCategoryModel({this.duaCategories});

  DuaCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['dua_categories'] != null) {
      duaCategories = <DuaCategories>[];
      json['dua_categories'].forEach((v) {
        duaCategories.add(new DuaCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.duaCategories != null) {
      data['dua_categories'] =
          this.duaCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DuaCategories {
  int iId = 0;
  Null arTitle;
  String enTitle = '';
  Null frTitle;

  DuaCategories({
    this.iId,
    this.arTitle,
    this.enTitle,
    this.frTitle,
  });

  DuaCategories.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    arTitle = json['ar_title'];
    enTitle = json['en_title'];
    frTitle = json['fr_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['ar_title'] = this.arTitle;
    data['en_title'] = this.enTitle;
    data['fr_title'] = this.frTitle;
    return data;
  }
}

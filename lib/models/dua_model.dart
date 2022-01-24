class DuaModel {
  List<DuaList> duaList;

  DuaModel({this.duaList});

  DuaModel.fromJson(Map<String, dynamic> json) {
    if (json['dua_list'] != null) {
      duaList = <DuaList>[];
      json['dua_list'].forEach((v) {
        duaList.add(new DuaList.fromJson(v));
      });
    }
  }
}

class DuaList {
  int iId;
  int groupId;
  int fav;
  String arDua;
  Null arReference;
  String enTranslation;
  String enReference;

  DuaList(
      {this.iId,
      this.groupId,
      this.fav,
      this.arDua,
      this.arReference,
      this.enTranslation,
      this.enReference});

  DuaList.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    groupId = json['group_id'];
    fav = json['fav'];
    arDua = json['ar_dua'];
    arReference = json['ar_reference'];
    enTranslation = json['en_translation'];
    enReference = json['en_reference'];
  }

}







class JuzzDetailsModel {
  int number;
  String audio;
  String text;
  int numberInSurah;
  int juz;
  int manzil;
  int page;
  int ruku;
  int hizbQuarter;
  
  JuzzDetailsModel(
      {this.number,
        this.audio,
        this.text,
        this.numberInSurah,
        this.juz,
        this.manzil,
        this.page,
        this.ruku,
        this.hizbQuarter,});

  JuzzDetailsModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    audio = json['audio'];
    text = json['text'];
    numberInSurah = json['numberInSurah'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
  }
}




// To parse this JSON data, do
//
//     final suraAudio = suraAudioFromJson(jsonString);

import 'dart:convert';
List<SuraAudio> suraAudioFromJson(String str) => List<SuraAudio>.from(json.decode(str).map((x) => SuraAudio.fromJson(x)));
String suraAudioToJson(List<SuraAudio> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SuraAudio {
    SuraAudio({
        this.id,
        this.name,
        this.date,
        this.file,
    });

    String id;
    String name;
    DateTime date;
    String file;

    factory SuraAudio.fromJson(Map<String, dynamic> json) => SuraAudio(
        id: json["id"],
        name: json["name"],
        date: DateTime.parse(json["date"]),
        file: json["file"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "file": file,
    };
}

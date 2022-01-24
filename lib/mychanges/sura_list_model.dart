// To parse this JSON data, do
//
//     final suralist = suralistFromJson(jsonString);

import 'dart:convert';

List<Suralist> suralistFromJson(String str) => List<Suralist>.from(json.decode(str).map((x) => Suralist.fromJson(x)));

String suralistToJson(List<Suralist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Suralist {
    Suralist({
        // required this.place,
        // required this.type,
         this.count,
         this.title,
         this.titleAr,
         this.index,
         this.pages,
         this.juz,
    });

    // Place place;
    // Type type;
    int count;
    String title;
    String titleAr;
    String index;
    String pages;
    List<Juz> juz;

    factory Suralist.fromJson(Map<String, dynamic> json) => Suralist(
        // place: json["place"],
        // type: json["type"],
        count: json["count"],
        title: json["title"],
        titleAr: json["titleAr"],
        index: json["index"],
        pages: json["pages"],
        juz: List<Juz>.from(json["juz"].map((x) => Juz.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        // "place": placeValues.reverse[place],
        // "type": typeValues.reverse[type],
        "count": count,
        "title": title,
        "titleAr": titleAr,
        "index": index,
        "pages": pages,
        "juz": List<dynamic>.from(juz.map((x) => x.toJson())),
    };
}

class Juz {
    Juz({
         this.index,
         this.verse,
    });

    String index;
    Verse verse;

    factory Juz.fromJson(Map<String, dynamic> json) => Juz(
        index: json["index"],
        verse: Verse.fromJson(json["verse"]),
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "verse": verse.toJson(),
    };
}

class Verse {
    Verse({
         this.start,
        this.end,
    });

    String start;
    String end;

    factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        start: json["start"],
        end: json["end"],
    );

    Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
    };
}

enum Place { MECCA, MEDINA }

final placeValues = EnumValues({
    "Mecca": Place.MECCA,
    "Medina": Place.MEDINA
});

enum Type { MAKKIYAH, MADANIYAH }

final typeValues = EnumValues({
    "Madaniyah": Type.MADANIYAH,
    "Makkiyah": Type.MAKKIYAH
});

class EnumValues<T> {
     Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}

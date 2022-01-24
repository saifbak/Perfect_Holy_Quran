// To parse this JSON data, do
//
//     final sura = suraFromJson(jsonString);

import 'dart:convert';

Sura suraFromJson(String str) => Sura.fromJson(json.decode(str));

String suraToJson(Sura data) => json.encode(data.toJson());

class Sura {
    Sura({
         this.index,
         this.name,
         this.verse,
         this.count,
         this.juz,
    });

    String index;
    String name;
    Map<String, String> verse;
    int count;
    List<Juz> juz;

    factory Sura.fromJson(Map<String, dynamic> json) => Sura(
        index: json["index"],
        name: json["name"],
        verse: Map.from(json["verse"]).map((k, v) => MapEntry<String, String>(k, v)),
        count: json["count"],
        juz: List<Juz>.from(json["juz"].map((x) => Juz.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "name": name,
        "verse": Map.from(verse).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "count": count,
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

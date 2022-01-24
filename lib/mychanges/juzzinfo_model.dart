// To parse this JSON data, do
//
//     final juzzinfo = juzzinfoFromJson(jsonString);

import 'dart:convert';

List<Juzzinfo> juzzinfoFromJson(String str) => List<Juzzinfo>.from(json.decode(str).map((x) => Juzzinfo.fromJson(x)));

String juzzinfoToJson(List<Juzzinfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Juzzinfo {
    Juzzinfo({
        this.index,
        this.start,
        this.end,
    });

    String index;
    End start;
    End end;

    factory Juzzinfo.fromJson(Map<String, dynamic> json) => Juzzinfo(
        index: json["index"],
        start: End.fromJson(json["start"]),
        end: End.fromJson(json["end"]),
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "start": start.toJson(),
        "end": end.toJson(),
    };
}

class End {
    End({
        this.index,
        this.verse,
        this.name,
    });

    String index;
    String verse;
    String name;

    factory End.fromJson(Map<String, dynamic> json) => End(
        index: json["index"],
        verse: json["verse"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "verse": verse,
        "name": name,
    };
}

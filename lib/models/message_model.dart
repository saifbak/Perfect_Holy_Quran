// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

List<Message> messageFromJson(String str) => List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
    Message({
        this.id,
        this.title,
        this.day,
        this.arabic,
        this.english,
    });

    String id;
    String title;
    String day;
    String arabic;
    String english;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        title: json["title"],
        day: json["day"],
        arabic: json["arabic"],
        english: json["english"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "day": day,
        "arabic": arabic,
        "english": english,
    };
}

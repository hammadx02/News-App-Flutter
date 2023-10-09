// To parse this JSON data, do
//
//     final newsChannelsHeadlinesModel = newsChannelsHeadlinesModelFromJson(jsonString);

import 'dart:convert';

NewsChannelsHeadlinesModel newsChannelsHeadlinesModelFromJson(String str) => NewsChannelsHeadlinesModel.fromJson(json.decode(str));

String newsChannelsHeadlinesModelToJson(NewsChannelsHeadlinesModel data) => json.encode(data.toJson());

class NewsChannelsHeadlinesModel {
    String? status;
    int? totalResults;
    List<Article>? articles;

    NewsChannelsHeadlinesModel({
        this.status,
        this.totalResults,
        this.articles,
    });

    factory NewsChannelsHeadlinesModel.fromJson(Map<String, dynamic> json) => NewsChannelsHeadlinesModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: json["articles"] == null ? [] : List<Article>.from(json["articles"]!.map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles == null ? [] : List<dynamic>.from(articles!.map((x) => x.toJson())),
    };
}

class Article {
    Source? source;
    Author? author;
    String? title;
    String? description;
    String? url;
    String? urlToImage;
    DateTime? publishedAt;
    String? content;

    Article({
        this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content,
    });

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        author: authorValues.map[json["author"]]!,
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "source": source?.toJson(),
        "author": authorValues.reverse[author],
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
    };
}

enum Author {
    BBC_NEWS,
    BBC_SPORT
}

final authorValues = EnumValues({
    "BBC News": Author.BBC_NEWS,
    "BBC Sport": Author.BBC_SPORT
});

class Source {
    Id? id;
    Author? name;

    Source({
        this.id,
        this.name,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: idValues.map[json["id"]]!,
        name: authorValues.map[json["name"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "name": authorValues.reverse[name],
    };
}

enum Id {
    BBC_NEWS
}

final idValues = EnumValues({
    "bbc-news": Id.BBC_NEWS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

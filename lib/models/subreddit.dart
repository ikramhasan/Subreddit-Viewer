import 'dart:convert';

Subreddit subredditFromJson(String str) => Subreddit.fromJson(json.decode(str));

String subredditToJson(Subreddit data) => json.encode(data.toJson());

class Subreddit {
  Subreddit({
    this.data,
  });

  SubredditData data;

  factory Subreddit.fromJson(Map<String, dynamic> json) => Subreddit(
        data: SubredditData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class SubredditData {
  SubredditData({
    this.children,
  });

  List<Child> children;

  factory SubredditData.fromJson(Map<String, dynamic> json) => SubredditData(
        children:
            List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}

class Child {
  Child({
    this.data,
  });

  ChildData data;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        data: ChildData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class ChildData {
  ChildData({
    this.subreddit,
    this.authorFullname,
    this.title,
    this.subredditNamePrefixed,
    this.downs,
    this.thumbnailHeight,
    this.upvoteRatio,
    this.ups,
    this.mediaEmbed,
    this.thumbnailWidth,
    this.score,
    this.thumbnail,
    this.postHint,
    this.created,
    this.urlOverriddenByDest,
    this.over18,
    this.preview,
    this.spoiler,
    this.author,
    this.permalink,
    this.url,
    this.subredditSubscribers,
    this.media,
    this.isVideo,
  });

  SubredditEnum subreddit;
  String authorFullname;
  String title;
  SubredditNamePrefixed subredditNamePrefixed;
  int downs;
  int thumbnailHeight;
  double upvoteRatio;
  int ups;
  MediaEmbed mediaEmbed;
  int thumbnailWidth;
  int score;
  String thumbnail;
  PostHint postHint;
  double created;
  String urlOverriddenByDest;
  bool over18;
  Preview preview;
  bool spoiler;
  String author;
  String permalink;
  String url;
  int subredditSubscribers;
  dynamic media;
  bool isVideo;

  factory ChildData.fromJson(Map<String, dynamic> json) => ChildData(
        subreddit: subredditEnumValues.map[json["subreddit"]],
        authorFullname: json["author_fullname"],
        title: json["title"],
        subredditNamePrefixed:
            subredditNamePrefixedValues.map[json["subreddit_name_prefixed"]],
        downs: json["downs"],
        thumbnailHeight: json["thumbnail_height"],
        upvoteRatio: json["upvote_ratio"].toDouble(),
        ups: json["ups"],
        mediaEmbed: MediaEmbed.fromJson(json["media_embed"]),
        thumbnailWidth: json["thumbnail_width"],
        score: json["score"],
        thumbnail: json["thumbnail"],
        postHint: postHintValues.map[json["post_hint"]],
        created: json["created"],
        urlOverriddenByDest: json["url_overridden_by_dest"],
        over18: json["over_18"],
        preview: Preview.fromJson(json["preview"]),
        spoiler: json["spoiler"],
        author: json["author"],
        permalink: json["permalink"],
        url: json["url"],
        subredditSubscribers: json["subreddit_subscribers"],
        media: json["media"],
        isVideo: json["is_video"],
      );

  Map<String, dynamic> toJson() => {
        "subreddit": subredditEnumValues.reverse[subreddit],
        "author_fullname": authorFullname,
        "title": title,
        "subreddit_name_prefixed":
            subredditNamePrefixedValues.reverse[subredditNamePrefixed],
        "downs": downs,
        "thumbnail_height": thumbnailHeight,
        "upvote_ratio": upvoteRatio,
        "ups": ups,
        "media_embed": mediaEmbed.toJson(),
        "thumbnail_width": thumbnailWidth,
        "score": score,
        "thumbnail": thumbnail,
        "post_hint": postHintValues.reverse[postHint],
        "created": created,
        "url_overridden_by_dest": urlOverriddenByDest,
        "over_18": over18,
        "preview": preview.toJson(),
        "author": author,
        "permalink": permalink,
        "url": url,
        "subreddit_subscribers": subredditSubscribers,
        "media": media,
        "is_video": isVideo,
      };
}

class ResizedIcon {
  ResizedIcon({
    this.url,
    this.width,
    this.height,
  });

  String url;
  int width;
  int height;

  factory ResizedIcon.fromJson(Map<String, dynamic> json) => ResizedIcon(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}

class MediaEmbed {
  MediaEmbed();

  factory MediaEmbed.fromJson(Map<String, dynamic> json) => MediaEmbed();

  Map<String, dynamic> toJson() => {};
}

enum PostHint { IMAGE }

final postHintValues = EnumValues({"image": PostHint.IMAGE});

class Preview {
  Preview({
    this.images,
    this.enabled,
  });

  List<Image> images;
  bool enabled;

  factory Preview.fromJson(Map<String, dynamic> json) => Preview(
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "enabled": enabled,
      };
}

class Image {
  Image({
    this.source,
    this.resolutions,
    this.variants,
    this.id,
  });

  ResizedIcon source;
  List<ResizedIcon> resolutions;
  MediaEmbed variants;
  String id;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        source: ResizedIcon.fromJson(json["source"]),
        resolutions: List<ResizedIcon>.from(
            json["resolutions"].map((x) => ResizedIcon.fromJson(x))),
        variants: MediaEmbed.fromJson(json["variants"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "resolutions": List<dynamic>.from(resolutions.map((x) => x.toJson())),
        "variants": variants.toJson(),
        "id": id,
      };
}

enum SubredditEnum { EARTH_PORN }

final subredditEnumValues = EnumValues({"EarthPorn": SubredditEnum.EARTH_PORN});

enum SubredditId { T5_2_SBQ3 }

final subredditIdValues = EnumValues({"t5_2sbq3": SubredditId.T5_2_SBQ3});

enum SubredditNamePrefixed { R_EARTH_PORN }

final subredditNamePrefixedValues =
    EnumValues({"r/EarthPorn": SubredditNamePrefixed.R_EARTH_PORN});

enum SubredditType { PUBLIC }

final subredditTypeValues = EnumValues({"public": SubredditType.PUBLIC});

enum Kind { T3 }

final kindValues = EnumValues({"t3": Kind.T3});

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

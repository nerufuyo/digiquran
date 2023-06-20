// class VideoList {
//   final String? kind;
//   final String? etag;
//   final String? nextPageToken;
//   final List<Item>? items;

//   VideoList({
//     this.kind,
//     this.etag,
//     this.nextPageToken,
//     this.items,
//   });

//   factory VideoList.fromJson(Map<String, dynamic> json) => VideoList(
//         kind: json["kind"],
//         etag: json["etag"],
//         nextPageToken: json["nextPageToken"],
//         items: json["items"] == null
//             ? []
//             : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "kind": kind,
//         "etag": etag,
//         "nextPageToken": nextPageToken,
//         "items": List<dynamic>.from(items!.map((x) => x.toJson())),
//       };
// }
class VideoList {
  final String? kind;
  final String? etag;
  final String? id;
  final Snippet? snippet;

  VideoList({
    this.kind,
    this.etag,
    this.id,
    this.snippet,
  });

  factory VideoList.fromJson(Map<String, dynamic> json) => VideoList(
        kind: json["kind"],
        etag: json["etag"],
        id: json["id"],
        snippet:
            json["snippet"] == null ? null : Snippet.fromJson(json["snippet"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id,
        "snippet": snippet?.toJson(),
      };
}

class Snippet {
  final String? publishedAt;
  final String? channelId;
  final String? title;
  final String? description;
  final Thumbnails? thumbnails;
  final String? channelTitle;
  final String? playlistId;
  final int? position;
  final ResourceId? resourceId;
  final String? videoOwnerChannelTitle;
  final String? videoOwnerChannelId;

  Snippet({
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    this.playlistId,
    this.position,
    this.resourceId,
    this.videoOwnerChannelTitle,
    this.videoOwnerChannelId,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        publishedAt: json["publishedAt"],
        channelId: json["channelId"],
        title: json["title"],
        description: json["description"],
        thumbnails: json["thumbnails"] == null
            ? null
            : Thumbnails.fromJson(json["thumbnails"]),
        channelTitle: json["channelTitle"],
        playlistId: json["playlistId"],
        position: json["position"],
        resourceId: json["resourceId"] == null
            ? null
            : ResourceId.fromJson(json["resourceId"]),
        videoOwnerChannelTitle: json["videoOwnerChannelTitle"],
        videoOwnerChannelId: json["videoOwnerChannelId"],
      );

  Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt,
        "channelId": channelId,
        "title": title,
        "description": description,
        "thumbnails": thumbnails?.toJson(),
        "channelTitle": channelTitle,
        "playlistId": playlistId,
        "position": position,
        "resourceId": resourceId?.toJson(),
        "videoOwnerChannelTitle": videoOwnerChannelTitle,
        "videoOwnerChannelId": videoOwnerChannelId,
      };
}

class ResourceId {
  final String? kind;
  final String? videoId;

  ResourceId({
    this.kind,
    this.videoId,
  });

  factory ResourceId.fromJson(Map<String, dynamic> json) => ResourceId(
        kind: json["kind"],
        videoId: json["videoId"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "videoId": videoId,
      };
}

class Thumbnails {
  final Default? standard;

  Thumbnails({
    this.standard,
  });

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        standard: json["standard"] == null
            ? null
            : Default.fromJson(json["standard"]),
      );

  Map<String, dynamic> toJson() => {
        "standard": standard?.toJson(),
      };
}

class Default {
  final String? url;
  final int? width;
  final int? height;

  Default({
    this.url,
    this.width,
    this.height,
  });

  factory Default.fromJson(Map<String, dynamic> json) => Default(
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

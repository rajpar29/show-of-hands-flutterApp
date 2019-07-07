// import 'dart:convert';

// PollModel pollModelFromJson(String str) => PollModel.fromJson(json.decode(str));

// String pollModelToJson(PollModel data) => json.encode(data.toJson());

// class PollModel {
//   String id;
//   String userId;
//   String title;
//   String description;
//   int upvotes;
//   int downvotes;
//   List<Comment> comments;
//   List<Option> options;
//   String imageUrl;
//   List<String> categories;
//   String username;
//   List<UpvoteOrDownvotedBy> upvoteOrDownvotedBy;

//   PollModel({
//     this.id,
//     this.userId,
//     this.title,
//     this.description,
//     this.upvotes,
//     this.downvotes,
//     this.comments,
//     this.options,
//     this.imageUrl,
//     this.categories,
//     this.username,
//     this.upvoteOrDownvotedBy,
//   });

//   factory PollModel.fromJson(Map<String, dynamic> json) => new PollModel(
//         id: json["_id"],
//         userId: json["userId"],
//         title: json["title"],
//         description: json["description"],
//         upvotes: json["upvotes"],
//         downvotes: json["downvotes"],
//         comments: new List<Comment>.from(
//             json["comments"].map((x) => Comment.fromJson(x))),
//         options: new List<Option>.from(
//             json["options"].map((x) => Option.fromJson(x))),
//         imageUrl: json["imageUrl"],
//         categories: new List<String>.from(json["categories"].map((x) => x)),
//         username: json["username"],
//         upvoteOrDownvotedBy: new List<UpvoteOrDownvotedBy>.from(
//             json["upvoteOrDownvotedBy"]
//                 .map((x) => UpvoteOrDownvotedBy.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userId": userId,
//         "title": title,
//         "description": description,
//         "upvotes": upvotes,
//         "downvotes": downvotes,
//         "comments": new List<dynamic>.from(comments.map((x) => x.toJson())),
//         "options": new List<dynamic>.from(options.map((x) => x.toJson())),
//         "imageUrl": imageUrl,
//         "categories": new List<dynamic>.from(categories.map((x) => x)),
//         "username": username,
//         "upvoteOrDownvotedBy":
//             new List<dynamic>.from(upvoteOrDownvotedBy.map((x) => x.toJson())),
//       };
// }

// class Comment {
//   String username;
//   String comment;

//   Comment({
//     this.username,
//     this.comment,
//   });

//   factory Comment.fromJson(Map<String, dynamic> json) => new Comment(
//         username: json["username"],
//         comment: json["comment"],
//       );

//   Map<String, dynamic> toJson() => {
//         "username": username,
//         "comment": comment,
//       };
// }

// class Option {
//   String optionName;
//   int votes;
//   String optionId;

//   Option({
//     this.optionName,
//     this.optionId,
//     this.votes,
//   });

//   factory Option.fromJson(Map<String, dynamic> json) => new Option(
//         optionName: json["optionName"],
//         votes: json["votes"],
//         optionId: json["optionId"]
//       );

//   Map<String, dynamic> toJson() => {
//         "optionName": optionName,
//         "votes": votes,
//         "optionId":optionId
//       };
// }

// class UpvoteOrDownvotedBy {
//   bool upvoted;
//   bool downvoted;
//   String username;

//   UpvoteOrDownvotedBy({
//     this.upvoted,
//     this.downvoted,
//     this.username,
//   });

//   factory UpvoteOrDownvotedBy.fromJson(Map<String, dynamic> json) =>
//       new UpvoteOrDownvotedBy(
//         upvoted: json["upvoted"],
//         downvoted: json["downvoted"],
//         username: json["username"],
//       );

//   Map<String, dynamic> toJson() => {
//         "upvoted": upvoted,
//         "downvoted": downvoted,
//         "username": username,
//       };
// }




// To parse this JSON data, do
//
//     final pollModel = pollModelFromJson(jsonString);

import 'dart:convert';

PollModel pollModelFromJson(String str) => PollModel.fromJson(json.decode(str));

String pollModelToJson(PollModel data) => json.encode(data.toJson());

class PollModel {
    String id;
    String userId;
    String title;
    String description;
    int upvotes;
    int downvotes;
    List<Comment> comments;
    List<Option> options;
    List<OptionChoosen> optionChoosen;
    String imageUrl;
    List<String> categories;
    String username;
    List<UpvoteOrDownvotedBy> upvoteOrDownvotedBy;

    PollModel({
        this.id,
        this.userId,
        this.title,
        this.description,
        this.upvotes,
        this.downvotes,
        this.comments,
        this.options,
        this.optionChoosen,
        this.imageUrl,
        this.categories,
        this.username,
        this.upvoteOrDownvotedBy,
    });

    factory PollModel.fromJson(Map<String, dynamic> json) => new PollModel(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        description: json["description"],
        upvotes: json["upvotes"],
        downvotes: json["downvotes"],
        comments: new List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
        options: new List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        optionChoosen: new List<OptionChoosen>.from(json["optionChoosen"].map((x) => OptionChoosen.fromJson(x))),
        imageUrl: json["imageUrl"],
        categories: new List<String>.from(json["categories"].map((x) => x)),
        username: json["username"],
        upvoteOrDownvotedBy: new List<UpvoteOrDownvotedBy>.from(json["upvoteOrDownvotedBy"].map((x) => UpvoteOrDownvotedBy.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "title": title,
        "description": description,
        "upvotes": upvotes,
        "downvotes": downvotes,
        "comments": new List<dynamic>.from(comments.map((x) => x.toJson())),
        "options": new List<dynamic>.from(options.map((x) => x.toJson())),
        "optionChoosen": new List<dynamic>.from(optionChoosen.map((x) => x.toJson())),
        "imageUrl": imageUrl,
        "categories": new List<dynamic>.from(categories.map((x) => x)),
        "username": username,
        "upvoteOrDownvotedBy": new List<dynamic>.from(upvoteOrDownvotedBy.map((x) => x.toJson())),
    };
}

class Comment {
    String username;
    String comment;

    Comment({
        this.username,
        this.comment,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => new Comment(
        username: json["username"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "comment": comment,
    };
}

class OptionChoosen {
    String username;
    String optionName;
    String optionId;

    OptionChoosen({
        this.username,
        this.optionName,
        this.optionId,
    });

    factory OptionChoosen.fromJson(Map<String, dynamic> json) => new OptionChoosen(
        username: json["username"],
        optionName: json["optionName"],
        optionId: json["optionId"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "optionName": optionName,
        "optionId": optionId,
    };
}

class Option {
    String optionName;
    int votes;
    String optionid;

    Option({
        this.optionName,
        this.votes,
        this.optionid,
    });

    factory Option.fromJson(Map<String, dynamic> json) => new Option(
        optionName: json["optionName"],
        votes: json["votes"],
        optionid: json["optionid"],
    );

    Map<String, dynamic> toJson() => {
        "optionName": optionName,
        "votes": votes,
        "optionid": optionid,
    };
}

class UpvoteOrDownvotedBy {
    bool upvoted;
    bool downvoted;
    String username;

    UpvoteOrDownvotedBy({
        this.upvoted,
        this.downvoted,
        this.username,
    });

    factory UpvoteOrDownvotedBy.fromJson(Map<String, dynamic> json) => new UpvoteOrDownvotedBy(
        upvoted: json["upvoted"],
        downvoted: json["downvoted"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "upvoted": upvoted,
        "downvoted": downvoted,
        "username": username,
    };
}

class HashTagsCaptionModel {
  List<Hashtags>? hashtags;
  List<Captions>? captions;

  HashTagsCaptionModel({this.hashtags, this.captions});

  HashTagsCaptionModel.fromJson(Map<String, dynamic> json) {
    if (json['hashtags'] != null) {
      hashtags = <Hashtags>[];
      json['hashtags'].forEach((v) {
        hashtags!.add(Hashtags.fromJson(v));
      });
    }
    if (json['captions'] != null) {
      captions = <Captions>[];
      json['captions'].forEach((v) {
        captions!.add(Captions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hashtags != null) {
      data['hashtags'] = hashtags!.map((v) => v.toJson()).toList();
    }
    if (captions != null) {
      data['captions'] = captions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hashtags {
  String? categoryTitle;
  List<dynamic>? hashtags;
  bool? isPremium;

  Hashtags({this.categoryTitle, this.hashtags, this.isPremium});

  Hashtags.fromJson(Map<String, dynamic> json) {
    categoryTitle = json['categoryTitle'];
    hashtags = json['hashtags'];
    isPremium = json['isPremium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryTitle'] = categoryTitle;
    data['hashtags'] = hashtags;
    data['isPremium'] = isPremium;
    return data;
  }
}

class Captions {
  String? categoryTitle;
  bool? isPremium;
  String? captions;

  Captions({this.categoryTitle, this.isPremium, this.captions});

  Captions.fromJson(Map<String, dynamic> json) {
    categoryTitle = json['categoryTitle'];
    isPremium = json['isPremium'];
    captions = json['caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryTitle'] = categoryTitle;
    data['isPremium'] = isPremium;
    data['captions'] = captions;
    return data;
  }
}

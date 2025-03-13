import 'dart:convert';

import 'package:aicaptions/models/hastags_catption_model.dart';

class GeneratedCaptionModel {
  String? id;
  String? provider;
  String? model;
  String? object;
  int? created;
  List<Choices>? choices;
  Usage? usage;

  GeneratedCaptionModel({this.id, this.provider, this.model, this.object, this.created, this.choices, this.usage});

  GeneratedCaptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provider = json['provider'];
    model = json['model'];
    object = json['object'];
    created = json['created'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(Choices.fromJson(v));
      });
    }
    usage = json['usage'] != null ? Usage.fromJson(json['usage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider'] = provider;
    data['model'] = model;
    data['object'] = object;
    data['created'] = created;
    if (choices != null) {
      data['choices'] = choices!.map((v) => v.toJson()).toList();
    }
    if (usage != null) {
      data['usage'] = usage!.toJson();
    }
    return data;
  }
}

class Choices {
  Null logprobs;
  String? finishReason;
  int? index;
  Message? message;

  Choices({this.logprobs, this.finishReason, this.index, this.message});

  Choices.fromJson(Map<String, dynamic> json) {
    logprobs = json['logprobs'];
    finishReason = json['finish_reason'];
    index = json['index'];
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logprobs'] = logprobs;
    data['finish_reason'] = finishReason;
    data['index'] = index;
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  String? role;
  HashTagsCaptionModel? content;
  String? refusal;

  Message({this.role, this.content, this.refusal});

  Message.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    content =
        (json['content'] != null && json['content'] != "") ? HashTagsCaptionModel.fromJson(jsonDecode(json['content'])) : HashTagsCaptionModel();
    refusal = json['refusal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['content'] = content;
    data['refusal'] = refusal;
    return data;
  }
}

class Usage {
  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  Usage({this.promptTokens, this.completionTokens, this.totalTokens});

  Usage.fromJson(Map<String, dynamic> json) {
    promptTokens = json['prompt_tokens'];
    completionTokens = json['completion_tokens'];
    totalTokens = json['total_tokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prompt_tokens'] = promptTokens;
    data['completion_tokens'] = completionTokens;
    data['total_tokens'] = totalTokens;
    return data;
  }
}

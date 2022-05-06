/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the UserData type in your schema. */
@immutable
class UserData extends Model {
  static const classType = const _UserDataModelType();
  final String id;
  final String name;
  final String age;
  final String readingStage;
  final String lvlOneCapsScore;
  final String lvlOneScore;
  final String lvlOneVoiceScore;
  final String lvlThreeMediumScore;
  final String lvlThreeVoiceScore;
  final String lvlTwoEasyScore;
  final String lvlTwoMediumScore;
  final String lvlThreeEasyScore;
  final String lvlTwoVoiceScore;
  final PrefVoice prefVoice;
  final bool saveRecord;
  final bool manualFix;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const UserData._internal(
      {@required this.id,
      @required this.name,
      this.age,
      this.readingStage,
      this.lvlOneCapsScore,
      this.lvlOneScore,
      this.lvlOneVoiceScore,
      this.lvlThreeMediumScore,
      this.lvlThreeVoiceScore,
      this.lvlTwoEasyScore,
      this.lvlTwoMediumScore,
      this.lvlThreeEasyScore,
      this.lvlTwoVoiceScore,
      this.prefVoice,
      this.saveRecord,
      this.manualFix});

  factory UserData(
      {String id,
      @required String name,
      String age,
      String readingStage,
      String lvlOneCapsScore,
      String lvlOneScore,
      String lvlOneVoiceScore,
      String lvlThreeMediumScore,
      String lvlThreeVoiceScore,
      String lvlTwoEasyScore,
      String lvlTwoMediumScore,
      String lvlThreeEasyScore,
      String lvlTwoVoiceScore,
      PrefVoice prefVoice,
      bool saveRecord,
      bool manualFix}) {
    return UserData._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        age: age,
        readingStage: readingStage,
        lvlOneCapsScore: lvlOneCapsScore,
        lvlOneScore: lvlOneScore,
        lvlOneVoiceScore: lvlOneVoiceScore,
        lvlThreeMediumScore: lvlThreeMediumScore,
        lvlThreeVoiceScore: lvlThreeVoiceScore,
        lvlTwoEasyScore: lvlTwoEasyScore,
        lvlTwoMediumScore: lvlTwoMediumScore,
        lvlThreeEasyScore: lvlThreeEasyScore,
        lvlTwoVoiceScore: lvlTwoVoiceScore,
        prefVoice: prefVoice,
        saveRecord: saveRecord,
        manualFix: manualFix);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserData &&
        id == other.id &&
        name == other.name &&
        age == other.age &&
        readingStage == other.readingStage &&
        lvlOneCapsScore == other.lvlOneCapsScore &&
        lvlOneScore == other.lvlOneScore &&
        lvlOneVoiceScore == other.lvlOneVoiceScore &&
        lvlThreeMediumScore == other.lvlThreeMediumScore &&
        lvlThreeVoiceScore == other.lvlThreeVoiceScore &&
        lvlTwoEasyScore == other.lvlTwoEasyScore &&
        lvlTwoMediumScore == other.lvlTwoMediumScore &&
        lvlThreeEasyScore == other.lvlThreeEasyScore &&
        lvlTwoVoiceScore == other.lvlTwoVoiceScore &&
        prefVoice == other.prefVoice &&
        saveRecord == other.saveRecord &&
        manualFix == other.manualFix;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("UserData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("age=" + "$age" + ", ");
    buffer.write("readingStage=" + "$readingStage" + ", ");
    buffer.write("lvlOneCapsScore=" + "$lvlOneCapsScore" + ", ");
    buffer.write("lvlOneScore=" + "$lvlOneScore" + ", ");
    buffer.write("lvlOneVoiceScore=" + "$lvlOneVoiceScore" + ", ");
    buffer.write("lvlThreeMediumScore=" + "$lvlThreeMediumScore" + ", ");
    buffer.write("lvlThreeVoiceScore=" + "$lvlThreeVoiceScore" + ", ");
    buffer.write("lvlTwoEasyScore=" + "$lvlTwoEasyScore" + ", ");
    buffer.write("lvlTwoMediumScore=" + "$lvlTwoMediumScore" + ", ");
    buffer.write("lvlThreeEasyScore=" + "$lvlThreeEasyScore" + ", ");
    buffer.write("lvlTwoVoiceScore=" + "$lvlTwoVoiceScore" + ", ");
    buffer.write("prefVoice=" +
        (prefVoice != null ? enumToString(prefVoice) : "null") +
        ", ");
    buffer.write("saveRecord=" +
        (saveRecord != null ? saveRecord.toString() : "null") +
        ", ");
    buffer.write(
        "manualFix=" + (manualFix != null ? manualFix.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  UserData copyWith(
      {String id,
      String name,
      String age,
      String readingStage,
      String lvlOneCapsScore,
      String lvlOneScore,
      String lvlOneVoiceScore,
      String lvlThreeMediumScore,
      String lvlThreeVoiceScore,
      String lvlTwoEasyScore,
      String lvlTwoMediumScore,
      String lvlThreeEasyScore,
      String lvlTwoVoiceScore,
      PrefVoice prefVoice,
      bool saveRecord,
      bool manualFix}) {
    return UserData(
        id: id ?? this.id,
        name: name ?? this.name,
        age: age ?? this.age,
        readingStage: readingStage ?? this.readingStage,
        lvlOneCapsScore: lvlOneCapsScore ?? this.lvlOneCapsScore,
        lvlOneScore: lvlOneScore ?? this.lvlOneScore,
        lvlOneVoiceScore: lvlOneVoiceScore ?? this.lvlOneVoiceScore,
        lvlThreeMediumScore: lvlThreeMediumScore ?? this.lvlThreeMediumScore,
        lvlThreeVoiceScore: lvlThreeVoiceScore ?? this.lvlThreeVoiceScore,
        lvlTwoEasyScore: lvlTwoEasyScore ?? this.lvlTwoEasyScore,
        lvlTwoMediumScore: lvlTwoMediumScore ?? this.lvlTwoMediumScore,
        lvlThreeEasyScore: lvlThreeEasyScore ?? this.lvlThreeEasyScore,
        lvlTwoVoiceScore: lvlTwoVoiceScore ?? this.lvlTwoVoiceScore,
        prefVoice: prefVoice ?? this.prefVoice,
        saveRecord: saveRecord ?? this.saveRecord,
        manualFix: manualFix ?? this.manualFix);
  }

  UserData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        age = json['age'],
        readingStage = json['readingStage'],
        lvlOneCapsScore = json['lvlOneCapsScore'],
        lvlOneScore = json['lvlOneScore'],
        lvlOneVoiceScore = json['lvlOneVoiceScore'],
        lvlThreeMediumScore = json['lvlThreeMediumScore'],
        lvlThreeVoiceScore = json['lvlThreeVoiceScore'],
        lvlTwoEasyScore = json['lvlTwoEasyScore'],
        lvlTwoMediumScore = json['lvlTwoMediumScore'],
        lvlThreeEasyScore = json['lvlThreeEasyScore'],
        lvlTwoVoiceScore = json['lvlTwoVoiceScore'],
        prefVoice =
            enumFromString<PrefVoice>(json['prefVoice'], PrefVoice.values),
        saveRecord = json['saveRecord'],
        manualFix = json['manualFix'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'readingStage': readingStage,
        'lvlOneCapsScore': lvlOneCapsScore,
        'lvlOneScore': lvlOneScore,
        'lvlOneVoiceScore': lvlOneVoiceScore,
        'lvlThreeMediumScore': lvlThreeMediumScore,
        'lvlThreeVoiceScore': lvlThreeVoiceScore,
        'lvlTwoEasyScore': lvlTwoEasyScore,
        'lvlTwoMediumScore': lvlTwoMediumScore,
        'lvlThreeEasyScore': lvlThreeEasyScore,
        'lvlTwoVoiceScore': lvlTwoVoiceScore,
        'prefVoice': enumToString(prefVoice),
        'saveRecord': saveRecord,
        'manualFix': manualFix
      };

  static final QueryField ID = QueryField(fieldName: "userData.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField AGE = QueryField(fieldName: "age");
  static final QueryField READINGSTAGE = QueryField(fieldName: "readingStage");
  static final QueryField LVLONECAPSSCORE =
      QueryField(fieldName: "lvlOneCapsScore");
  static final QueryField LVLONESCORE = QueryField(fieldName: "lvlOneScore");
  static final QueryField LVLONEVOICESCORE =
      QueryField(fieldName: "lvlOneVoiceScore");
  static final QueryField LVLTHREEMEDIUMSCORE =
      QueryField(fieldName: "lvlThreeMediumScore");
  static final QueryField LVLTHREEVOICESCORE =
      QueryField(fieldName: "lvlThreeVoiceScore");
  static final QueryField LVLTWOEASYSCORE =
      QueryField(fieldName: "lvlTwoEasyScore");
  static final QueryField LVLTWOMEDIUMSCORE =
      QueryField(fieldName: "lvlTwoMediumScore");
  static final QueryField LVLTHREEEASYSCORE =
      QueryField(fieldName: "lvlThreeEasyScore");
  static final QueryField LVLTWOVOICESCORE =
      QueryField(fieldName: "lvlTwoVoiceScore");
  static final QueryField PREFVOICE = QueryField(fieldName: "prefVoice");
  static final QueryField SAVERECORD = QueryField(fieldName: "saveRecord");
  static final QueryField MANUALFIX = QueryField(fieldName: "manualFix");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserData";
    modelSchemaDefinition.pluralName = "UserData";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.AGE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.READINGSTAGE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.LVLONECAPSSCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.LVLONESCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.LVLONEVOICESCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.LVLTHREEMEDIUMSCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.LVLTHREEVOICESCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.LVLTWOEASYSCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.LVLTWOMEDIUMSCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.LVLTHREEEASYSCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.LVLTWOVOICESCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.PREFVOICE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.SAVERECORD,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.MANUALFIX,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));
  });
}

class _UserDataModelType extends ModelType<UserData> {
  const _UserDataModelType();

  @override
  UserData fromJson(Map<String, dynamic> jsonData) {
    return UserData.fromJson(jsonData);
  }
}

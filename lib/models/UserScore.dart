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

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the UserScore type in your schema. */
@immutable
class UserScore extends Model {
  static const classType = const _UserScoreModelType();
  final String id;
  final String userdataID;
  final double lvlOneCapsScore;
  final double lvlOneScore;
  final double lvlOneVoiceScore;
  final double lvlThreeMediumScore;
  final double lvlThreeVoiceScore;
  final double lvlTwoEasyScore;
  final double lvlTwoMediumScore;
  final double lvlThreeEasyScore;
  final double lvlTwoVoiceScore;
  final TemporalDateTime createdAt;
  final TemporalDateTime updatedAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const UserScore._internal(
      {@required this.id,
      @required this.userdataID,
      this.lvlOneCapsScore,
      this.lvlOneScore,
      this.lvlOneVoiceScore,
      this.lvlThreeMediumScore,
      this.lvlThreeVoiceScore,
      this.lvlTwoEasyScore,
      this.lvlTwoMediumScore,
      this.lvlThreeEasyScore,
      this.lvlTwoVoiceScore,
      this.createdAt,
      this.updatedAt});

  factory UserScore(
      {String id,
      @required String userdataID,
      double lvlOneCapsScore,
      double lvlOneScore,
      double lvlOneVoiceScore,
      double lvlThreeMediumScore,
      double lvlThreeVoiceScore,
      double lvlTwoEasyScore,
      double lvlTwoMediumScore,
      double lvlThreeEasyScore,
      double lvlTwoVoiceScore}) {
    return UserScore._internal(
        id: id == null ? UUID.getUUID() : id,
        userdataID: userdataID,
        lvlOneCapsScore: lvlOneCapsScore,
        lvlOneScore: lvlOneScore,
        lvlOneVoiceScore: lvlOneVoiceScore,
        lvlThreeMediumScore: lvlThreeMediumScore,
        lvlThreeVoiceScore: lvlThreeVoiceScore,
        lvlTwoEasyScore: lvlTwoEasyScore,
        lvlTwoMediumScore: lvlTwoMediumScore,
        lvlThreeEasyScore: lvlThreeEasyScore,
        lvlTwoVoiceScore: lvlTwoVoiceScore);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserScore &&
        id == other.id &&
        userdataID == other.userdataID &&
        lvlOneCapsScore == other.lvlOneCapsScore &&
        lvlOneScore == other.lvlOneScore &&
        lvlOneVoiceScore == other.lvlOneVoiceScore &&
        lvlThreeMediumScore == other.lvlThreeMediumScore &&
        lvlThreeVoiceScore == other.lvlThreeVoiceScore &&
        lvlTwoEasyScore == other.lvlTwoEasyScore &&
        lvlTwoMediumScore == other.lvlTwoMediumScore &&
        lvlThreeEasyScore == other.lvlThreeEasyScore &&
        lvlTwoVoiceScore == other.lvlTwoVoiceScore;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("UserScore {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userdataID=" + "$userdataID" + ", ");
    buffer.write("lvlOneCapsScore=" +
        (lvlOneCapsScore != null ? lvlOneCapsScore.toString() : "null") +
        ", ");
    buffer.write("lvlOneScore=" +
        (lvlOneScore != null ? lvlOneScore.toString() : "null") +
        ", ");
    buffer.write("lvlOneVoiceScore=" +
        (lvlOneVoiceScore != null ? lvlOneVoiceScore.toString() : "null") +
        ", ");
    buffer.write("lvlThreeMediumScore=" +
        (lvlThreeMediumScore != null
            ? lvlThreeMediumScore.toString()
            : "null") +
        ", ");
    buffer.write("lvlThreeVoiceScore=" +
        (lvlThreeVoiceScore != null ? lvlThreeVoiceScore.toString() : "null") +
        ", ");
    buffer.write("lvlTwoEasyScore=" +
        (lvlTwoEasyScore != null ? lvlTwoEasyScore.toString() : "null") +
        ", ");
    buffer.write("lvlTwoMediumScore=" +
        (lvlTwoMediumScore != null ? lvlTwoMediumScore.toString() : "null") +
        ", ");
    buffer.write("lvlThreeEasyScore=" +
        (lvlThreeEasyScore != null ? lvlThreeEasyScore.toString() : "null") +
        ", ");
    buffer.write("lvlTwoVoiceScore=" +
        (lvlTwoVoiceScore != null ? lvlTwoVoiceScore.toString() : "null") +
        ", ");
    buffer.write("createdAt=" +
        (createdAt != null ? createdAt.format() : "null") +
        ", ");
    buffer.write(
        "updatedAt=" + (updatedAt != null ? updatedAt.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  UserScore copyWith(
      {String id,
      String userdataID,
      double lvlOneCapsScore,
      double lvlOneScore,
      double lvlOneVoiceScore,
      double lvlThreeMediumScore,
      double lvlThreeVoiceScore,
      double lvlTwoEasyScore,
      double lvlTwoMediumScore,
      double lvlThreeEasyScore,
      double lvlTwoVoiceScore}) {
    return UserScore._internal(
        id: id ?? this.id,
        userdataID: userdataID ?? this.userdataID,
        lvlOneCapsScore: lvlOneCapsScore ?? this.lvlOneCapsScore,
        lvlOneScore: lvlOneScore ?? this.lvlOneScore,
        lvlOneVoiceScore: lvlOneVoiceScore ?? this.lvlOneVoiceScore,
        lvlThreeMediumScore: lvlThreeMediumScore ?? this.lvlThreeMediumScore,
        lvlThreeVoiceScore: lvlThreeVoiceScore ?? this.lvlThreeVoiceScore,
        lvlTwoEasyScore: lvlTwoEasyScore ?? this.lvlTwoEasyScore,
        lvlTwoMediumScore: lvlTwoMediumScore ?? this.lvlTwoMediumScore,
        lvlThreeEasyScore: lvlThreeEasyScore ?? this.lvlThreeEasyScore,
        lvlTwoVoiceScore: lvlTwoVoiceScore ?? this.lvlTwoVoiceScore);
  }

  UserScore.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userdataID = json['userdataID'],
        lvlOneCapsScore = (json['lvlOneCapsScore'] as num)?.toDouble(),
        lvlOneScore = (json['lvlOneScore'] as num)?.toDouble(),
        lvlOneVoiceScore = (json['lvlOneVoiceScore'] as num)?.toDouble(),
        lvlThreeMediumScore = (json['lvlThreeMediumScore'] as num)?.toDouble(),
        lvlThreeVoiceScore = (json['lvlThreeVoiceScore'] as num)?.toDouble(),
        lvlTwoEasyScore = (json['lvlTwoEasyScore'] as num)?.toDouble(),
        lvlTwoMediumScore = (json['lvlTwoMediumScore'] as num)?.toDouble(),
        lvlThreeEasyScore = (json['lvlThreeEasyScore'] as num)?.toDouble(),
        lvlTwoVoiceScore = (json['lvlTwoVoiceScore'] as num)?.toDouble(),
        createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userdataID': userdataID,
        'lvlOneCapsScore': lvlOneCapsScore,
        'lvlOneScore': lvlOneScore,
        'lvlOneVoiceScore': lvlOneVoiceScore,
        'lvlThreeMediumScore': lvlThreeMediumScore,
        'lvlThreeVoiceScore': lvlThreeVoiceScore,
        'lvlTwoEasyScore': lvlTwoEasyScore,
        'lvlTwoMediumScore': lvlTwoMediumScore,
        'lvlThreeEasyScore': lvlThreeEasyScore,
        'lvlTwoVoiceScore': lvlTwoVoiceScore,
        'createdAt': createdAt?.format(),
        'updatedAt': updatedAt?.format()
      };

  static final QueryField ID = QueryField(fieldName: "userScore.id");
  static final QueryField USERDATAID = QueryField(fieldName: "userdataID");
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
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserScore";
    modelSchemaDefinition.pluralName = "UserScores";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PRIVATE, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserScore.USERDATAID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserScore.LVLONECAPSSCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserScore.LVLONESCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserScore.LVLONEVOICESCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserScore.LVLTHREEMEDIUMSCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserScore.LVLTHREEVOICESCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserScore.LVLTWOEASYSCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserScore.LVLTWOMEDIUMSCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserScore.LVLTHREEEASYSCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserScore.LVLTWOVOICESCORE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'createdAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'updatedAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _UserScoreModelType extends ModelType<UserScore> {
  const _UserScoreModelType();

  @override
  UserScore fromJson(Map<String, dynamic> jsonData) {
    return UserScore.fromJson(jsonData);
  }
}

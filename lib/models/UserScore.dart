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

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the UserScore type in your schema. */
class UserScore extends amplify_core.Model {
  static const classType = const _UserScoreModelType();
  final String id;
  final String? _userdataID;
  final double? _lvlOneCapsScore;
  final double? _lvlOneScore;
  final double? _lvlOneVoiceScore;
  final double? _lvlThreeMediumScore;
  final double? _lvlThreeVoiceScore;
  final double? _lvlThreeVoiceMediumScore;
  final double? _lvlTwoEasyScore;
  final double? _lvlTwoMediumScore;
  final double? _lvlThreeEasyScore;
  final double? _lvlTwoVoiceScore;
  final double? _lvlTwoVoiceMediumScore;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get userdataID {
    try {
      return _userdataID!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double? get lvlOneCapsScore {
    return _lvlOneCapsScore;
  }
  
  double? get lvlOneScore {
    return _lvlOneScore;
  }
  
  double? get lvlOneVoiceScore {
    return _lvlOneVoiceScore;
  }
  
  double? get lvlThreeMediumScore {
    return _lvlThreeMediumScore;
  }
  
  double? get lvlThreeVoiceScore {
    return _lvlThreeVoiceScore;
  }
  
  double? get lvlThreeVoiceMediumScore {
    return _lvlThreeVoiceMediumScore;
  }
  
  double? get lvlTwoEasyScore {
    return _lvlTwoEasyScore;
  }
  
  double? get lvlTwoMediumScore {
    return _lvlTwoMediumScore;
  }
  
  double? get lvlThreeEasyScore {
    return _lvlThreeEasyScore;
  }
  
  double? get lvlTwoVoiceScore {
    return _lvlTwoVoiceScore;
  }
  
  double? get lvlTwoVoiceMediumScore {
    return _lvlTwoVoiceMediumScore;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const UserScore._internal({required this.id, required userdataID, lvlOneCapsScore, lvlOneScore, lvlOneVoiceScore, lvlThreeMediumScore, lvlThreeVoiceScore, lvlThreeVoiceMediumScore, lvlTwoEasyScore, lvlTwoMediumScore, lvlThreeEasyScore, lvlTwoVoiceScore, lvlTwoVoiceMediumScore, createdAt, updatedAt}): _userdataID = userdataID, _lvlOneCapsScore = lvlOneCapsScore, _lvlOneScore = lvlOneScore, _lvlOneVoiceScore = lvlOneVoiceScore, _lvlThreeMediumScore = lvlThreeMediumScore, _lvlThreeVoiceScore = lvlThreeVoiceScore, _lvlThreeVoiceMediumScore = lvlThreeVoiceMediumScore, _lvlTwoEasyScore = lvlTwoEasyScore, _lvlTwoMediumScore = lvlTwoMediumScore, _lvlThreeEasyScore = lvlThreeEasyScore, _lvlTwoVoiceScore = lvlTwoVoiceScore, _lvlTwoVoiceMediumScore = lvlTwoVoiceMediumScore, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UserScore({String? id, required String userdataID, double? lvlOneCapsScore, double? lvlOneScore, double? lvlOneVoiceScore, double? lvlThreeMediumScore, double? lvlThreeVoiceScore, double? lvlThreeVoiceMediumScore, double? lvlTwoEasyScore, double? lvlTwoMediumScore, double? lvlThreeEasyScore, double? lvlTwoVoiceScore, double? lvlTwoVoiceMediumScore}) {
    return UserScore._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      userdataID: userdataID,
      lvlOneCapsScore: lvlOneCapsScore,
      lvlOneScore: lvlOneScore,
      lvlOneVoiceScore: lvlOneVoiceScore,
      lvlThreeMediumScore: lvlThreeMediumScore,
      lvlThreeVoiceScore: lvlThreeVoiceScore,
      lvlThreeVoiceMediumScore: lvlThreeVoiceMediumScore,
      lvlTwoEasyScore: lvlTwoEasyScore,
      lvlTwoMediumScore: lvlTwoMediumScore,
      lvlThreeEasyScore: lvlThreeEasyScore,
      lvlTwoVoiceScore: lvlTwoVoiceScore,
      lvlTwoVoiceMediumScore: lvlTwoVoiceMediumScore);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserScore &&
      id == other.id &&
      _userdataID == other._userdataID &&
      _lvlOneCapsScore == other._lvlOneCapsScore &&
      _lvlOneScore == other._lvlOneScore &&
      _lvlOneVoiceScore == other._lvlOneVoiceScore &&
      _lvlThreeMediumScore == other._lvlThreeMediumScore &&
      _lvlThreeVoiceScore == other._lvlThreeVoiceScore &&
      _lvlThreeVoiceMediumScore == other._lvlThreeVoiceMediumScore &&
      _lvlTwoEasyScore == other._lvlTwoEasyScore &&
      _lvlTwoMediumScore == other._lvlTwoMediumScore &&
      _lvlThreeEasyScore == other._lvlThreeEasyScore &&
      _lvlTwoVoiceScore == other._lvlTwoVoiceScore &&
      _lvlTwoVoiceMediumScore == other._lvlTwoVoiceMediumScore;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserScore {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userdataID=" + "$_userdataID" + ", ");
    buffer.write("lvlOneCapsScore=" + (_lvlOneCapsScore != null ? _lvlOneCapsScore!.toString() : "null") + ", ");
    buffer.write("lvlOneScore=" + (_lvlOneScore != null ? _lvlOneScore!.toString() : "null") + ", ");
    buffer.write("lvlOneVoiceScore=" + (_lvlOneVoiceScore != null ? _lvlOneVoiceScore!.toString() : "null") + ", ");
    buffer.write("lvlThreeMediumScore=" + (_lvlThreeMediumScore != null ? _lvlThreeMediumScore!.toString() : "null") + ", ");
    buffer.write("lvlThreeVoiceScore=" + (_lvlThreeVoiceScore != null ? _lvlThreeVoiceScore!.toString() : "null") + ", ");
    buffer.write("lvlThreeVoiceMediumScore=" + (_lvlThreeVoiceMediumScore != null ? _lvlThreeVoiceMediumScore!.toString() : "null") + ", ");
    buffer.write("lvlTwoEasyScore=" + (_lvlTwoEasyScore != null ? _lvlTwoEasyScore!.toString() : "null") + ", ");
    buffer.write("lvlTwoMediumScore=" + (_lvlTwoMediumScore != null ? _lvlTwoMediumScore!.toString() : "null") + ", ");
    buffer.write("lvlThreeEasyScore=" + (_lvlThreeEasyScore != null ? _lvlThreeEasyScore!.toString() : "null") + ", ");
    buffer.write("lvlTwoVoiceScore=" + (_lvlTwoVoiceScore != null ? _lvlTwoVoiceScore!.toString() : "null") + ", ");
    buffer.write("lvlTwoVoiceMediumScore=" + (_lvlTwoVoiceMediumScore != null ? _lvlTwoVoiceMediumScore!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserScore copyWith({String? id, String? userdataID, double? lvlOneCapsScore, double? lvlOneScore, double? lvlOneVoiceScore, double? lvlThreeMediumScore, double? lvlThreeVoiceScore, double? lvlThreeVoiceMediumScore, double? lvlTwoEasyScore, double? lvlTwoMediumScore, double? lvlThreeEasyScore, double? lvlTwoVoiceScore, double? lvlTwoVoiceMediumScore}) {
    return UserScore._internal(
      id: id ?? this.id,
      userdataID: userdataID ?? this.userdataID,
      lvlOneCapsScore: lvlOneCapsScore ?? this.lvlOneCapsScore,
      lvlOneScore: lvlOneScore ?? this.lvlOneScore,
      lvlOneVoiceScore: lvlOneVoiceScore ?? this.lvlOneVoiceScore,
      lvlThreeMediumScore: lvlThreeMediumScore ?? this.lvlThreeMediumScore,
      lvlThreeVoiceScore: lvlThreeVoiceScore ?? this.lvlThreeVoiceScore,
      lvlThreeVoiceMediumScore: lvlThreeVoiceMediumScore ?? this.lvlThreeVoiceMediumScore,
      lvlTwoEasyScore: lvlTwoEasyScore ?? this.lvlTwoEasyScore,
      lvlTwoMediumScore: lvlTwoMediumScore ?? this.lvlTwoMediumScore,
      lvlThreeEasyScore: lvlThreeEasyScore ?? this.lvlThreeEasyScore,
      lvlTwoVoiceScore: lvlTwoVoiceScore ?? this.lvlTwoVoiceScore,
      lvlTwoVoiceMediumScore: lvlTwoVoiceMediumScore ?? this.lvlTwoVoiceMediumScore);
  }
  
  UserScore copyWithModelFieldValues({
    ModelFieldValue<String>? id,
    ModelFieldValue<String>? userdataID,
    ModelFieldValue<double?>? lvlOneCapsScore,
    ModelFieldValue<double?>? lvlOneScore,
    ModelFieldValue<double?>? lvlOneVoiceScore,
    ModelFieldValue<double?>? lvlThreeMediumScore,
    ModelFieldValue<double?>? lvlThreeVoiceScore,
    ModelFieldValue<double?>? lvlThreeVoiceMediumScore,
    ModelFieldValue<double?>? lvlTwoEasyScore,
    ModelFieldValue<double?>? lvlTwoMediumScore,
    ModelFieldValue<double?>? lvlThreeEasyScore,
    ModelFieldValue<double?>? lvlTwoVoiceScore,
    ModelFieldValue<double?>? lvlTwoVoiceMediumScore
  }) {
    return UserScore._internal(
      id: id == null ? this.id : id.value,
      userdataID: userdataID == null ? this.userdataID : userdataID.value,
      lvlOneCapsScore: lvlOneCapsScore == null ? this.lvlOneCapsScore : lvlOneCapsScore.value,
      lvlOneScore: lvlOneScore == null ? this.lvlOneScore : lvlOneScore.value,
      lvlOneVoiceScore: lvlOneVoiceScore == null ? this.lvlOneVoiceScore : lvlOneVoiceScore.value,
      lvlThreeMediumScore: lvlThreeMediumScore == null ? this.lvlThreeMediumScore : lvlThreeMediumScore.value,
      lvlThreeVoiceScore: lvlThreeVoiceScore == null ? this.lvlThreeVoiceScore : lvlThreeVoiceScore.value,
      lvlThreeVoiceMediumScore: lvlThreeVoiceMediumScore == null ? this.lvlThreeVoiceMediumScore : lvlThreeVoiceMediumScore.value,
      lvlTwoEasyScore: lvlTwoEasyScore == null ? this.lvlTwoEasyScore : lvlTwoEasyScore.value,
      lvlTwoMediumScore: lvlTwoMediumScore == null ? this.lvlTwoMediumScore : lvlTwoMediumScore.value,
      lvlThreeEasyScore: lvlThreeEasyScore == null ? this.lvlThreeEasyScore : lvlThreeEasyScore.value,
      lvlTwoVoiceScore: lvlTwoVoiceScore == null ? this.lvlTwoVoiceScore : lvlTwoVoiceScore.value,
      lvlTwoVoiceMediumScore: lvlTwoVoiceMediumScore == null ? this.lvlTwoVoiceMediumScore : lvlTwoVoiceMediumScore.value
    );
  }
  
  UserScore.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userdataID = json['userdataID'],
      _lvlOneCapsScore = (json['lvlOneCapsScore'] as num?)?.toDouble(),
      _lvlOneScore = (json['lvlOneScore'] as num?)?.toDouble(),
      _lvlOneVoiceScore = (json['lvlOneVoiceScore'] as num?)?.toDouble(),
      _lvlThreeMediumScore = (json['lvlThreeMediumScore'] as num?)?.toDouble(),
      _lvlThreeVoiceScore = (json['lvlThreeVoiceScore'] as num?)?.toDouble(),
      _lvlThreeVoiceMediumScore = (json['lvlThreeVoiceMediumScore'] as num?)?.toDouble(),
      _lvlTwoEasyScore = (json['lvlTwoEasyScore'] as num?)?.toDouble(),
      _lvlTwoMediumScore = (json['lvlTwoMediumScore'] as num?)?.toDouble(),
      _lvlThreeEasyScore = (json['lvlThreeEasyScore'] as num?)?.toDouble(),
      _lvlTwoVoiceScore = (json['lvlTwoVoiceScore'] as num?)?.toDouble(),
      _lvlTwoVoiceMediumScore = (json['lvlTwoVoiceMediumScore'] as num?)?.toDouble(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userdataID': _userdataID, 'lvlOneCapsScore': _lvlOneCapsScore, 'lvlOneScore': _lvlOneScore, 'lvlOneVoiceScore': _lvlOneVoiceScore, 'lvlThreeMediumScore': _lvlThreeMediumScore, 'lvlThreeVoiceScore': _lvlThreeVoiceScore, 'lvlThreeVoiceMediumScore': _lvlThreeVoiceMediumScore, 'lvlTwoEasyScore': _lvlTwoEasyScore, 'lvlTwoMediumScore': _lvlTwoMediumScore, 'lvlThreeEasyScore': _lvlThreeEasyScore, 'lvlTwoVoiceScore': _lvlTwoVoiceScore, 'lvlTwoVoiceMediumScore': _lvlTwoVoiceMediumScore, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'userdataID': _userdataID,
    'lvlOneCapsScore': _lvlOneCapsScore,
    'lvlOneScore': _lvlOneScore,
    'lvlOneVoiceScore': _lvlOneVoiceScore,
    'lvlThreeMediumScore': _lvlThreeMediumScore,
    'lvlThreeVoiceScore': _lvlThreeVoiceScore,
    'lvlThreeVoiceMediumScore': _lvlThreeVoiceMediumScore,
    'lvlTwoEasyScore': _lvlTwoEasyScore,
    'lvlTwoMediumScore': _lvlTwoMediumScore,
    'lvlThreeEasyScore': _lvlThreeEasyScore,
    'lvlTwoVoiceScore': _lvlTwoVoiceScore,
    'lvlTwoVoiceMediumScore': _lvlTwoVoiceMediumScore,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final ID = amplify_core.QueryField(fieldName: "id");
  static final USERDATAID = amplify_core.QueryField(fieldName: "userdataID");
  static final LVLONECAPSSCORE = amplify_core.QueryField(fieldName: "lvlOneCapsScore");
  static final LVLONESCORE = amplify_core.QueryField(fieldName: "lvlOneScore");
  static final LVLONEVOICESCORE = amplify_core.QueryField(fieldName: "lvlOneVoiceScore");
  static final LVLTHREEMEDIUMSCORE = amplify_core.QueryField(fieldName: "lvlThreeMediumScore");
  static final LVLTHREEVOICESCORE = amplify_core.QueryField(fieldName: "lvlThreeVoiceScore");
  static final LVLTHREEVOICEMEDIUMSCORE = amplify_core.QueryField(fieldName: "lvlThreeVoiceMediumScore");
  static final LVLTWOEASYSCORE = amplify_core.QueryField(fieldName: "lvlTwoEasyScore");
  static final LVLTWOMEDIUMSCORE = amplify_core.QueryField(fieldName: "lvlTwoMediumScore");
  static final LVLTHREEEASYSCORE = amplify_core.QueryField(fieldName: "lvlThreeEasyScore");
  static final LVLTWOVOICESCORE = amplify_core.QueryField(fieldName: "lvlTwoVoiceScore");
  static final LVLTWOVOICEMEDIUMSCORE = amplify_core.QueryField(fieldName: "lvlTwoVoiceMediumScore");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserScore";
    modelSchemaDefinition.pluralName = "UserScores";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PRIVATE,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["userdataID"], name: "byUserData")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserScore.USERDATAID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserScore.LVLONECAPSSCORE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserScore.LVLONESCORE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserScore.LVLONEVOICESCORE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserScore.LVLTHREEMEDIUMSCORE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserScore.LVLTHREEVOICESCORE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserScore.LVLTHREEVOICEMEDIUMSCORE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserScore.LVLTWOEASYSCORE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserScore.LVLTWOMEDIUMSCORE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserScore.LVLTHREEEASYSCORE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserScore.LVLTWOVOICESCORE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserScore.LVLTWOVOICEMEDIUMSCORE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UserScoreModelType extends amplify_core.ModelType<UserScore> {
  const _UserScoreModelType();
  
  @override
  UserScore fromJson(Map<String, dynamic> jsonData) {
    return UserScore.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'UserScore';
  }
}
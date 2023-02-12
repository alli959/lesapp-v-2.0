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
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the UserData type in your schema. */
@immutable
class UserData extends Model {
  static const classType = const _UserDataModelType();
  final String id;
  final String name;
  final String age;
  final Schools school;
  final String classname;
  final bool agreement;
  final String readingStage;
  final PrefVoice prefVoice;
  final bool saveRecord;
  final bool manualFix;
  final List<UserScore> UserScores;
  final TemporalDateTime createdAt;
  final TemporalDateTime updatedAt;

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
      this.school,
      this.classname,
      this.agreement,
      this.readingStage,
      this.prefVoice,
      this.saveRecord,
      this.manualFix,
      this.UserScores,
      this.createdAt,
      this.updatedAt});

  factory UserData(
      {String id,
      @required String name,
      String age,
      Schools school,
      String classname,
      bool agreement,
      String readingStage,
      PrefVoice prefVoice,
      bool saveRecord,
      bool manualFix,
      List<UserScore> UserScores}) {
    return UserData._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        age: age,
        school: school,
        classname: classname,
        agreement: agreement,
        readingStage: readingStage,
        prefVoice: prefVoice,
        saveRecord: saveRecord,
        manualFix: manualFix,
        UserScores: UserScores != null
            ? List<UserScore>.unmodifiable(UserScores)
            : UserScores);
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
        school == other.school &&
        classname == other.classname &&
        agreement == other.agreement &&
        readingStage == other.readingStage &&
        prefVoice == other.prefVoice &&
        saveRecord == other.saveRecord &&
        manualFix == other.manualFix &&
        DeepCollectionEquality().equals(UserScores, other.UserScores);
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
    buffer.write(
        "school=" + (school != null ? enumToString(school) : "null") + ", ");
    buffer.write("classname=" + "$classname" + ", ");
    buffer.write("agreement=" +
        (agreement != null ? agreement.toString() : "null") +
        ", ");
    buffer.write("readingStage=" + "$readingStage" + ", ");
    buffer.write("prefVoice=" +
        (prefVoice != null ? enumToString(prefVoice) : "null") +
        ", ");
    buffer.write("saveRecord=" +
        (saveRecord != null ? saveRecord.toString() : "null") +
        ", ");
    buffer.write("manualFix=" +
        (manualFix != null ? manualFix.toString() : "null") +
        ", ");
    buffer.write("createdAt=" +
        (createdAt != null ? createdAt.format() : "null") +
        ", ");
    buffer.write(
        "updatedAt=" + (updatedAt != null ? updatedAt.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  UserData copyWith(
      {String id,
      String name,
      String age,
      Schools school,
      String classname,
      bool agreement,
      String readingStage,
      PrefVoice prefVoice,
      bool saveRecord,
      bool manualFix,
      List<UserScore> UserScores}) {
    return UserData._internal(
        id: id ?? this.id,
        name: name ?? this.name,
        age: age ?? this.age,
        school: school ?? this.school,
        classname: classname ?? this.classname,
        agreement: agreement ?? this.agreement,
        readingStage: readingStage ?? this.readingStage,
        prefVoice: prefVoice ?? this.prefVoice,
        saveRecord: saveRecord ?? this.saveRecord,
        manualFix: manualFix ?? this.manualFix,
        UserScores: UserScores ?? this.UserScores);
  }

  UserData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        age = json['age'],
        school = enumFromString<Schools>(json['school'], Schools.values),
        classname = json['classname'],
        agreement = json['agreement'],
        readingStage = json['readingStage'],
        prefVoice =
            enumFromString<PrefVoice>(json['prefVoice'], PrefVoice.values),
        saveRecord = json['saveRecord'],
        manualFix = json['manualFix'],
        UserScores = json['UserScores'] is List
            ? (json['UserScores'] as List)
                .map(
                    (e) => UserScore.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'school': enumToString(school),
        'classname': classname,
        'agreement': agreement,
        'readingStage': readingStage,
        'prefVoice': enumToString(prefVoice),
        'saveRecord': saveRecord,
        'manualFix': manualFix,
        'UserScores': UserScores?.map((UserScore e) => e?.toJson())?.toList(),
        'createdAt': createdAt?.format(),
        'updatedAt': updatedAt?.format()
      };

  Map<String, Object> toMap() => {
        'id': id,
        'name': name,
        'age': age,
        'school': school,
        'classname': classname,
        'agreement': agreement,
        'readingStage': readingStage,
        'prefVoice': prefVoice,
        'saveRecord': saveRecord,
        'manualFix': manualFix,
        'UserScores': UserScores,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField AGE = QueryField(fieldName: "age");
  static final QueryField SCHOOL = QueryField(fieldName: "school");
  static final QueryField CLASSNAME = QueryField(fieldName: "classname");
  static final QueryField AGREEMENT = QueryField(fieldName: "agreement");
  static final QueryField READINGSTAGE = QueryField(fieldName: "readingStage");
  static final QueryField PREFVOICE = QueryField(fieldName: "prefVoice");
  static final QueryField SAVERECORD = QueryField(fieldName: "saveRecord");
  static final QueryField MANUALFIX = QueryField(fieldName: "manualFix");
  static final QueryField USERSCORES = QueryField(
      fieldName: "UserScores",
      fieldType:
          ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'UserScore'));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserData";
    modelSchemaDefinition.pluralName = "UserData";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          provider: AuthRuleProvider.USERPOOLS,
          operations: [
            ModelOperation.CREATE,
            ModelOperation.DELETE,
            ModelOperation.UPDATE,
            ModelOperation.READ
          ]),
      AuthRule(
          authStrategy: AuthStrategy.PRIVATE, operations: [ModelOperation.READ])
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
        key: UserData.SCHOOL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.CLASSNAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.AGREEMENT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserData.READINGSTAGE,
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

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: UserData.USERSCORES,
        isRequired: false,
        ofModelName: 'UserScore',
        associatedKey: UserScore.USERDATAID));

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

class _UserDataModelType extends ModelType<UserData> {
  const _UserDataModelType();

  @override
  UserData fromJson(Map<String, dynamic> jsonData) {
    return UserData.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'UserData';
  }
}

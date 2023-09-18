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
import 'package:collection/collection.dart';


/** This is an auto generated class representing the UserData type in your schema. */
class UserData extends amplify_core.Model {
  static const classType = const _UserDataModelType();
  final String id;
  final String? _name;
  final String? _age;
  final Schools? _school;
  final String? _classname;
  final bool? _agreement;
  final String? _readingStage;
  final PrefVoice? _prefVoice;
  final bool? _saveRecord;
  final bool? _manualFix;
  final List<UserScore>? _UserScores;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get age {
    return _age;
  }
  
  Schools? get school {
    return _school;
  }
  
  String? get classname {
    return _classname;
  }
  
  bool? get agreement {
    return _agreement;
  }
  
  String? get readingStage {
    return _readingStage;
  }
  
  PrefVoice? get prefVoice {
    return _prefVoice;
  }
  
  bool? get saveRecord {
    return _saveRecord;
  }
  
  bool? get manualFix {
    return _manualFix;
  }
  
  List<UserScore>? get UserScores {
    return _UserScores;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const UserData._internal({required this.id, required name, age, school, classname, agreement, readingStage, prefVoice, saveRecord, manualFix, UserScores, createdAt, updatedAt}): _name = name, _age = age, _school = school, _classname = classname, _agreement = agreement, _readingStage = readingStage, _prefVoice = prefVoice, _saveRecord = saveRecord, _manualFix = manualFix, _UserScores = UserScores, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UserData({String? id, required String name, String? age, Schools? school, String? classname, bool? agreement, String? readingStage, PrefVoice? prefVoice, bool? saveRecord, bool? manualFix, List<UserScore>? UserScores}) {
    return UserData._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      age: age,
      school: school,
      classname: classname,
      agreement: agreement,
      readingStage: readingStage,
      prefVoice: prefVoice,
      saveRecord: saveRecord,
      manualFix: manualFix,
      UserScores: UserScores != null ? List<UserScore>.unmodifiable(UserScores) : UserScores);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserData &&
      id == other.id &&
      _name == other._name &&
      _age == other._age &&
      _school == other._school &&
      _classname == other._classname &&
      _agreement == other._agreement &&
      _readingStage == other._readingStage &&
      _prefVoice == other._prefVoice &&
      _saveRecord == other._saveRecord &&
      _manualFix == other._manualFix &&
      DeepCollectionEquality().equals(_UserScores, other._UserScores);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("age=" + "$_age" + ", ");
    buffer.write("school=" + (_school != null ? amplify_core.enumToString(_school)! : "null") + ", ");
    buffer.write("classname=" + "$_classname" + ", ");
    buffer.write("agreement=" + (_agreement != null ? _agreement!.toString() : "null") + ", ");
    buffer.write("readingStage=" + "$_readingStage" + ", ");
    buffer.write("prefVoice=" + (_prefVoice != null ? amplify_core.enumToString(_prefVoice)! : "null") + ", ");
    buffer.write("saveRecord=" + (_saveRecord != null ? _saveRecord!.toString() : "null") + ", ");
    buffer.write("manualFix=" + (_manualFix != null ? _manualFix!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserData copyWith({String? id, String? name, String? age, Schools? school, String? classname, bool? agreement, String? readingStage, PrefVoice? prefVoice, bool? saveRecord, bool? manualFix, List<UserScore>? UserScores}) {
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
  
  UserData copyWithModelFieldValues({
    ModelFieldValue<String>? id,
    ModelFieldValue<String>? name,
    ModelFieldValue<String?>? age,
    ModelFieldValue<Schools?>? school,
    ModelFieldValue<String?>? classname,
    ModelFieldValue<bool?>? agreement,
    ModelFieldValue<String?>? readingStage,
    ModelFieldValue<PrefVoice?>? prefVoice,
    ModelFieldValue<bool?>? saveRecord,
    ModelFieldValue<bool?>? manualFix,
    ModelFieldValue<List<UserScore>?>? UserScores
  }) {
    return UserData._internal(
      id: id == null ? this.id : id.value,
      name: name == null ? this.name : name.value,
      age: age == null ? this.age : age.value,
      school: school == null ? this.school : school.value,
      classname: classname == null ? this.classname : classname.value,
      agreement: agreement == null ? this.agreement : agreement.value,
      readingStage: readingStage == null ? this.readingStage : readingStage.value,
      prefVoice: prefVoice == null ? this.prefVoice : prefVoice.value,
      saveRecord: saveRecord == null ? this.saveRecord : saveRecord.value,
      manualFix: manualFix == null ? this.manualFix : manualFix.value,
      UserScores: UserScores == null ? this.UserScores : UserScores.value
    );
  }
  
  UserData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _age = json['age'],
      _school = amplify_core.enumFromString<Schools>(json['school'], Schools.values),
      _classname = json['classname'],
      _agreement = json['agreement'],
      _readingStage = json['readingStage'],
      _prefVoice = amplify_core.enumFromString<PrefVoice>(json['prefVoice'], PrefVoice.values),
      _saveRecord = json['saveRecord'],
      _manualFix = json['manualFix'],
      _UserScores = json['UserScores'] is List
        ? (json['UserScores'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UserScore.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'age': _age, 'school': amplify_core.enumToString(_school), 'classname': _classname, 'agreement': _agreement, 'readingStage': _readingStage, 'prefVoice': amplify_core.enumToString(_prefVoice), 'saveRecord': _saveRecord, 'manualFix': _manualFix, 'UserScores': _UserScores?.map((UserScore? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'age': _age,
    'school': _school,
    'classname': _classname,
    'agreement': _agreement,
    'readingStage': _readingStage,
    'prefVoice': _prefVoice,
    'saveRecord': _saveRecord,
    'manualFix': _manualFix,
    'UserScores': _UserScores,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final AGE = amplify_core.QueryField(fieldName: "age");
  static final SCHOOL = amplify_core.QueryField(fieldName: "school");
  static final CLASSNAME = amplify_core.QueryField(fieldName: "classname");
  static final AGREEMENT = amplify_core.QueryField(fieldName: "agreement");
  static final READINGSTAGE = amplify_core.QueryField(fieldName: "readingStage");
  static final PREFVOICE = amplify_core.QueryField(fieldName: "prefVoice");
  static final SAVERECORD = amplify_core.QueryField(fieldName: "saveRecord");
  static final MANUALFIX = amplify_core.QueryField(fieldName: "manualFix");
  static final USERSCORES = amplify_core.QueryField(
    fieldName: "UserScores",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UserScore'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserData";
    modelSchemaDefinition.pluralName = "UserData";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: amplify_core.AuthRuleProvider.USERPOOLS,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.READ
        ]),
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PRIVATE,
        operations: const [
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserData.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserData.AGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserData.SCHOOL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserData.CLASSNAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserData.AGREEMENT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserData.READINGSTAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserData.PREFVOICE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserData.SAVERECORD,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserData.MANUALFIX,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: UserData.USERSCORES,
      isRequired: false,
      ofModelName: 'UserScore',
      associatedKey: UserScore.USERDATAID
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

class _UserDataModelType extends amplify_core.ModelType<UserData> {
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
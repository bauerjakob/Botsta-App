import 'package:botsta_app/graphql/login.data.gql.dart' show GLoginData;
import 'package:botsta_app/graphql/login.req.gql.dart' show GLoginReq;
import 'package:botsta_app/graphql/login.var.gql.dart' show GLoginVars;
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:gql_code_builder/src/serializers/operation_serializer.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([GLoginData, GLoginReq, GLoginVars])
final Serializers serializers = _serializersBuilder.build();

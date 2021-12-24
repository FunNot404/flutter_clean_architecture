// Mocks generated by Mockito 5.0.17 from annotations
// in flutter_clean_architecture/test/data/datasources/user_remote_data_source_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:typed_data' as _i8;

import 'package:dio/dio.dart' as _i2;
import 'package:http_mock_adapter/http_mock_adapter.dart' as _i5;
import 'package:http_mock_adapter/src/request.dart' as _i3;
import 'package:http_mock_adapter/src/response.dart' as _i4;
import 'package:http_mock_adapter/src/types.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeDio_0 extends _i1.Fake implements _i2.Dio {}

class _FakeRequestMatcher_1 extends _i1.Fake implements _i3.RequestMatcher {}

class _FakeMockResponse_2 extends _i1.Fake implements _i4.MockResponse {}

class _FakeResponseBody_3 extends _i1.Fake implements _i2.ResponseBody {}

/// A class which mocks [DioAdapter].
///
/// See the documentation for Mockito's code generation for more information.
class MockDioAdapter extends _i1.Mock implements _i5.DioAdapter {
  MockDioAdapter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Dio get dio =>
      (super.noSuchMethod(Invocation.getter(#dio), returnValue: _FakeDio_0())
          as _i2.Dio);
  @override
  _i3.RequestMatcher get requestMatcher =>
      (super.noSuchMethod(Invocation.getter(#requestMatcher),
          returnValue: _FakeRequestMatcher_1()) as _i3.RequestMatcher);
  @override
  _i6.MockResponseBodyCallback get mockResponse => (super.noSuchMethod(
          Invocation.getter(#mockResponse),
          returnValue: (_i2.RequestOptions options) => _FakeMockResponse_2())
      as _i6.MockResponseBodyCallback);
  @override
  List<_i3.RequestMatcher> get history =>
      (super.noSuchMethod(Invocation.getter(#history),
          returnValue: <_i3.RequestMatcher>[]) as List<_i3.RequestMatcher>);
  @override
  _i7.Future<_i2.ResponseBody> fetch(
          _i2.RequestOptions? requestOptions,
          _i7.Stream<_i8.Uint8List>? requestStream,
          _i7.Future<dynamic>? cancelFuture) =>
      (super.noSuchMethod(
              Invocation.method(
                  #fetch, [requestOptions, requestStream, cancelFuture]),
              returnValue:
                  Future<_i2.ResponseBody>.value(_FakeResponseBody_3()))
          as _i7.Future<_i2.ResponseBody>);
  @override
  void close({bool? force = false}) =>
      super.noSuchMethod(Invocation.method(#close, [], {#force: force}),
          returnValueForMissingStub: null);
  @override
  void reset() => super.noSuchMethod(Invocation.method(#reset, []),
      returnValueForMissingStub: null);
  @override
  _i7.Future<void> setDefaultRequestHeaders(
          _i2.Dio? dio, _i2.RequestOptions? options) =>
      (super.noSuchMethod(
          Invocation.method(#setDefaultRequestHeaders, [dio, options]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  void onRoute(Pattern? route, _i6.MockServerCallback? requestHandlerCallback,
          {_i3.Request? request}) =>
      super.noSuchMethod(
          Invocation.method(
              #onRoute, [route, requestHandlerCallback], {#request: request}),
          returnValueForMissingStub: null);
  @override
  void onGet(Pattern? route, _i6.MockServerCallback? requestHandlerCallback,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          Map<String, dynamic>? headers}) =>
      super.noSuchMethod(
          Invocation.method(#onGet, [
            route,
            requestHandlerCallback
          ], {
            #data: data,
            #queryParameters: queryParameters,
            #headers: headers
          }),
          returnValueForMissingStub: null);
  @override
  void onHead(Pattern? route, _i6.MockServerCallback? requestHandlerCallback,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          Map<String, dynamic>? headers}) =>
      super.noSuchMethod(
          Invocation.method(#onHead, [
            route,
            requestHandlerCallback
          ], {
            #data: data,
            #queryParameters: queryParameters,
            #headers: headers
          }),
          returnValueForMissingStub: null);
  @override
  void onPost(Pattern? route, _i6.MockServerCallback? requestHandlerCallback,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          Map<String, dynamic>? headers}) =>
      super.noSuchMethod(
          Invocation.method(#onPost, [
            route,
            requestHandlerCallback
          ], {
            #data: data,
            #queryParameters: queryParameters,
            #headers: headers
          }),
          returnValueForMissingStub: null);
  @override
  void onPut(Pattern? route, _i6.MockServerCallback? requestHandlerCallback,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          Map<String, dynamic>? headers}) =>
      super.noSuchMethod(
          Invocation.method(#onPut, [
            route,
            requestHandlerCallback
          ], {
            #data: data,
            #queryParameters: queryParameters,
            #headers: headers
          }),
          returnValueForMissingStub: null);
  @override
  void onDelete(Pattern? route, _i6.MockServerCallback? requestHandlerCallback,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          Map<String, dynamic>? headers}) =>
      super.noSuchMethod(
          Invocation.method(#onDelete, [
            route,
            requestHandlerCallback
          ], {
            #data: data,
            #queryParameters: queryParameters,
            #headers: headers
          }),
          returnValueForMissingStub: null);
  @override
  void onPatch(Pattern? route, _i6.MockServerCallback? requestHandlerCallback,
          {dynamic data,
          Map<String, dynamic>? queryParameters,
          Map<String, dynamic>? headers}) =>
      super.noSuchMethod(
          Invocation.method(#onPatch, [
            route,
            requestHandlerCallback
          ], {
            #data: data,
            #queryParameters: queryParameters,
            #headers: headers
          }),
          returnValueForMissingStub: null);
  @override
  bool isMockDioError(_i4.MockResponse? mockResponse) =>
      (super.noSuchMethod(Invocation.method(#isMockDioError, [mockResponse]),
          returnValue: false) as bool);
}
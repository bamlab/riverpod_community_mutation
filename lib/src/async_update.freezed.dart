// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'async_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AsyncUpdate<TData> {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AsyncUpdate<TData>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AsyncUpdate<$TData>()';
  }
}

/// @nodoc
class $AsyncUpdateCopyWith<TData, $Res> {
  $AsyncUpdateCopyWith(
      AsyncUpdate<TData> _, $Res Function(AsyncUpdate<TData>) __);
}

/// @nodoc

class Idle<TData> extends AsyncUpdate<TData> {
  const Idle() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Idle<TData>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AsyncUpdate<$TData>.idle()';
  }
}

/// @nodoc

class Loading<TData> extends AsyncUpdate<TData> {
  const Loading() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Loading<TData>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AsyncUpdate<$TData>.loading()';
  }
}

/// @nodoc

class Success<TData> extends AsyncUpdate<TData> {
  const Success(this.value) : super._();

  final TData value;

  /// Create a copy of AsyncUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuccessCopyWith<TData, Success<TData>> get copyWith =>
      _$SuccessCopyWithImpl<TData, Success<TData>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Success<TData> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'AsyncUpdate<$TData>.success(value: $value)';
  }
}

/// @nodoc
abstract mixin class $SuccessCopyWith<TData, $Res>
    implements $AsyncUpdateCopyWith<TData, $Res> {
  factory $SuccessCopyWith(
          Success<TData> value, $Res Function(Success<TData>) _then) =
      _$SuccessCopyWithImpl;
  @useResult
  $Res call({TData value});
}

/// @nodoc
class _$SuccessCopyWithImpl<TData, $Res>
    implements $SuccessCopyWith<TData, $Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success<TData> _self;
  final $Res Function(Success<TData>) _then;

  /// Create a copy of AsyncUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(Success<TData>(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as TData,
    ));
  }
}

/// @nodoc

class ErrorDetails<TData> extends AsyncUpdate<TData> {
  const ErrorDetails(this.message, this.stackTrace) : super._();

  final Object? message;
  final StackTrace? stackTrace;

  /// Create a copy of AsyncUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorDetailsCopyWith<TData, ErrorDetails<TData>> get copyWith =>
      _$ErrorDetailsCopyWithImpl<TData, ErrorDetails<TData>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorDetails<TData> &&
            const DeepCollectionEquality().equals(other.message, message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(message), stackTrace);

  @override
  String toString() {
    return 'AsyncUpdate<$TData>.error(message: $message, stackTrace: $stackTrace)';
  }
}

/// @nodoc
abstract mixin class $ErrorDetailsCopyWith<TData, $Res>
    implements $AsyncUpdateCopyWith<TData, $Res> {
  factory $ErrorDetailsCopyWith(
          ErrorDetails<TData> value, $Res Function(ErrorDetails<TData>) _then) =
      _$ErrorDetailsCopyWithImpl;
  @useResult
  $Res call({Object? message, StackTrace? stackTrace});
}

/// @nodoc
class _$ErrorDetailsCopyWithImpl<TData, $Res>
    implements $ErrorDetailsCopyWith<TData, $Res> {
  _$ErrorDetailsCopyWithImpl(this._self, this._then);

  final ErrorDetails<TData> _self;
  final $Res Function(ErrorDetails<TData>) _then;

  /// Create a copy of AsyncUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(ErrorDetails<TData>(
      freezed == message ? _self.message : message,
      freezed == stackTrace
          ? _self.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

// dart format on

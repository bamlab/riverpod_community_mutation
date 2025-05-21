/// A utility for safely manipulating asynchronous mutation data.
///
/// There are two differences with riverpod `AsyncData`:
/// * The Update can be `Idle` when the mutation has not been executed.
/// * There is no `refreshing` because we do not have a use case for it.
sealed class AsyncUpdate<TData> {
  const AsyncUpdate._();

  /// Your mutation has never run, `mutate` hasn't been called yet.
  const factory AsyncUpdate.idle() = Idle<TData>;

  /// Your mutation has no data and is currently loading
  const factory AsyncUpdate.loading() = Loading<TData>;

  /// Your mutation  was successful, and you have data for it
  const factory AsyncUpdate.success(TData value) = Success<TData>;

  /// Your mutation did not work, and an error is set
  const factory AsyncUpdate.error(
    Object? message,
    StackTrace? stackTrace,
  ) = ErrorDetails<TData>;

  /// Get the associated status of [AsyncUpdate].
  ///
  /// See: [Status]
  Status get status => switch (this) {
        Idle<TData>() => Status.idle,
        Loading<TData>() => Status.loading,
        Success<TData>() => Status.success,
        ErrorDetails<TData>() => Status.error,
      };

  /// Return true if the status is `success`, false otherwise
  bool get isSuccess => this.status == Status.success;

  /// Return true if the status is `error`, false otherwise
  bool get isError => this.status == Status.error;

  /// Return true if the status is `idle`, false otherwise
  bool get isIdle => this.status == Status.idle;

  /// Return true if the status is `loading`, false otherwise
  bool get isLoading => this.status == Status.loading;

  /// Will return the value if status is success, otherwise null.
  TData? get value => switch (this) {
        Success(:final value) => value,
        _ => null,
      };

  /// Will return the error if status is error, otherwise null.
  Object? get error => switch (this) {
        ErrorDetails(:final error) => error,
        _ => null,
      };

  /// Perform some action based on the current state of the [AsyncUpdate].
  ///
  /// This allows reading the content of an [AsyncUpdate] in a type-safe way,
  /// without potentially ignoring to handle a case.
  R map<R>({
    required R Function() idle,
    required R Function(TData data) data,
    required R Function(Object? error, StackTrace? stackTrace) error,
    required R Function() loading,
  });

  @override
  bool operator ==(Object other) {
    return runtimeType == other.runtimeType &&
        other is AsyncUpdate<TData> &&
        other.status == status &&
        other.error == error &&
        other.value == value;
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        status,
        error,
        value,
      );
}

class Idle<TData> extends AsyncUpdate<TData> {
  const Idle() : super._();

  @override
  String toString() => 'AsyncUpdate<$TData>.idle()';

  @override
  R map<R>({
    required R Function() idle,
    required R Function(TData data) data,
    required R Function(Object? error, StackTrace? stackTrace) error,
    required R Function() loading,
  }) {
    return idle();
  }
}

class Success<TData> extends AsyncUpdate<TData> {
  const Success(this.value) : super._();

  final TData value;

  @override
  String toString() => 'AsyncUpdate<$TData>.success($value)';

  @override
  R map<R>({
    required R Function() idle,
    required R Function(TData data) data,
    required R Function(Object? error, StackTrace? stackTrace) error,
    required R Function() loading,
  }) {
    return data(value);
  }
}

class Loading<TData> extends AsyncUpdate<TData> {
  const Loading() : super._();

  @override
  String toString() => 'AsyncUpdate<$TData>.loading()';

  @override
  R map<R>({
    required R Function() idle,
    required R Function(TData data) data,
    required R Function(Object? error, StackTrace? stackTrace) error,
    required R Function() loading,
  }) {
    return loading();
  }
}

class ErrorDetails<TData> extends AsyncUpdate<TData> {
  const ErrorDetails(this.message, this.stackTrace) : super._();

  final Object? message;
  final StackTrace? stackTrace;

  @override
  String toString() => 'AsyncUpdate<$TData>.error($message)';

  @override
  R map<R>({
    required R Function() idle,
    required R Function(TData data) data,
    required R Function(Object? error, StackTrace? stackTrace) error,
    required R Function() loading,
  }) {
    return error(message, stackTrace);
  }
}

enum Status {
  /// Your mutation has never run, `mutate` hasn't been called yet.
  idle,

  /// Your mutation has no data and is currently loading
  loading,

  /// Your mutation  was successful, and you have data for it
  success,

  /// Your mutation did not work, and an error is set
  error,
}

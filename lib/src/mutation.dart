import 'dart:async';
import 'dart:developer';

import 'package:riverpod/riverpod.dart';
import 'package:riverpod_community_mutation/src/async_update.dart';

/// Generic mixin to handle mutations.
///
/// Unlike queries, mutations are typically used to create/update/delete data or
/// perform server side-effects.
///
/// Create a mutation by mixing [Mutation]. The mutation should execute
/// only one mutation.
///
/// Example of usage with a Favorite use case.
///
/// Mutation:
/// ```dart
/// @riverpod
/// class FavoritesMutation extends _$FavoritesMutation
///   with Mutation<String> {
///
///   AsyncUpdate<String> build() {
///     id = ref.watch(idProvider);
///     favoritesApi = ref.watch(favoriteApiProvider);
///     return const AsyncUpdate.idle();
///  }
///
///   late int id;
///   late FavoritesApi favoritesApi;
///
///   Future<String> toggleFavorite() async {
///     final result = await mutate(() => favoritesApi.postToggleFavorite(id));
///     return result;
///   }
/// }
/// ```
///
/// BPMN representation of a typical mutation:
///
/// ![](https://pbs.twimg.com/media/FczFdlfXwAIcCw9?format=jpg&name=small)
// ignore: invalid_use_of_internal_member, Required with codegen
mixin Mutation<TData> on AutoDisposeNotifier<AsyncUpdate<TData>> {
  /// Method that execute a mutation callback and update the state.
  ///
  /// eg:
  /// ```dart
  /// Future<String> toggleFavorite() async {
  ///   final result = await mutate(() => favoritesApi.postToggleFavorite(id));
  ///   return result;
  /// }
  /// ```
  Future<TData> mutateAsync(FutureOr<TData> Function() mutationFn) async {
    final ref = this.ref;
    final link = ref.keepAlive();
    state = const AsyncUpdate.loading();
    try {
      final value = await mutationFn();
      state = AsyncUpdate.success(value);

      return value;
    } catch (error, stackTrace) {
      state = AsyncUpdate.error(error, stackTrace);
      log(
        error.toString(),
        stackTrace: stackTrace,
        name: runtimeType.toString(),
      );
      rethrow;
    } finally {
      link.close();
    }
  }

  /// Method that execute a mutation callback and update the state, without
  /// throwing or returning a value .
  ///
  /// eg:
  /// ```dart
  /// void toggleFavorite() {
  ///    mutate(() => favoritesApi.postToggleFavorite(id));
  /// }
  /// ```
  Future<void> mutate(
    FutureOr<TData> Function() mutationFn, {
    FutureOr<void> Function(TData data)? onSuccess,
    FutureOr<void> Function(Object? error)? onError,
    FutureOr<void> Function()? onFinally,
  }) async {
    _lastMutationFn = mutationFn;
    _lastOnSuccessFn = onSuccess;
    _lastOnErrorFn = onError;
    _lastOnFinallyFn = onFinally;

    try {
      final value = await mutateAsync(mutationFn);
      await onSuccess?.call(value);
    } catch (error) {
      await onError?.call(error);
    } finally {
      await onFinally?.call();
    }
  }


  FutureOr<TData> Function()? _lastMutationFn;
  FutureOr<void> Function(TData data)? _lastOnSuccessFn;
  FutureOr<void> Function(Object? error)? _lastOnErrorFn;
  FutureOr<void> Function()? _lastOnFinallyFn;

  /// Retry the last mutation.
  ///
  /// This method is useful when you want to retry a mutation that failed.
  ///
  /// Will do nothing if the mutation is not in an error state or if the mutation has not been called yet.
  Future<void> retry() async {
    if (_lastMutationFn == null) return;
    if (!state.isError) return;
    await mutate(
      _lastMutationFn!,
      onSuccess: _lastOnSuccessFn,
      onError: _lastOnErrorFn,
      onFinally: _lastOnFinallyFn,
    );
  }
  /// Reset mutation status to `idle`
  void reset() {
    state = const AsyncUpdate.idle();
  }
}

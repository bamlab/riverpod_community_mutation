// ignore_for_file: public_member_api_docs

import 'package:riverpod_community_mutation/src/async_update.dart';
import 'package:riverpod_community_mutation/src/mutation.dart';
import 'package:riverpod/riverpod.dart';

class CreateTodoMutation extends AutoDisposeNotifier<AsyncUpdate<void>>
    with Mutation {
  @override
  AsyncUpdate<void> build() {
    return const AsyncUpdate<void>.idle();
  }

  Future<void> createTodo(
    String title, {
    Future<void> Function(void)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) {
    return mutate(
      () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}

final bussinessMutationProvider =
    AutoDisposeNotifierProvider<CreateTodoMutation, AsyncUpdate<void>>(
  CreateTodoMutation.new,
);

// ignore_for_file: public_member_api_docs

import 'package:riverpod_community_mutation/src/async_update.dart';
import 'package:riverpod_community_mutation/src/mutation.dart';
import 'package:riverpod/riverpod.dart';

// First, create your API or service class
class TodoApi {
  Future<Todo> createTodo(String title) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return Todo(id: DateTime.now().millisecondsSinceEpoch, title: title);
  }
}

// Create your data model
class Todo {
  const Todo({required this.id, required this.title});
  final int id;
  final String title;
}

class CreateTodoMutation extends AutoDisposeNotifier<AsyncUpdate<Todo>>
    with Mutation {
  @override
  AsyncUpdate<Todo> build() {
    return const AsyncUpdate<Todo>.idle();
  }

  Future<void> createTodo(
    String title, {
    Future<void> Function(Todo)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) {
    return mutate(
      () async {
        final todoApi = ref.read(todoApiProvider);

        final todo = await todoApi.createTodo(title);
        return todo;
      },
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}

// Create your API provider
final todoApiProvider = Provider((ref) => TodoApi());

final bussinessMutationProvider =
    AutoDisposeNotifierProvider<CreateTodoMutation, AsyncUpdate<Todo>>(
  CreateTodoMutation.new,
);

# Mutation

[<img src="https://raw.githubusercontent.com/bamlab/riverpod_community_extensions/main/doc/theodo_apps_white.png" width="200" alt="Theodo Apps">](https://apps.theodo.com)

A mixin to handle asynchronous mutations in a clean and type-safe way.

The `mutation` package provides a mixin to handle asynchronous mutations in a clean and type-safe way. It's particularly useful for operations like creating, updating, or deleting data.

## Features 🚀

The mutation mixin provides several useful features:

- **State Management**: Automatically handles loading, success, and error states
- **Type Safety**: Fully type-safe with generics
- **Error Handling**: Built-in error handling with stack traces
- **Lifecycle Management**: Proper cleanup of resources
- **Callbacks**: Support for success, error, and finally callbacks

## Installation 💻

**❗ In order to start using Mutation you must have the [Dart SDK][dart_install_link] installed on your machine.**

Install via `dart pub add`:

```sh
dart pub add riverpod_community_mutation
```

## Usage 🎨

Here's a complete example of how to use the mutation mixin:

```dart
import 'package:mutation/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

// Create your mutation provider
@riverpod
class CreateTodoMutation extends _$CreateTodoMutation with Mutation<Todo> {
  @override
  AsyncUpdate<Todo> build() {
    return const AsyncUpdate.idle();
  }

  // Method to create a new todo
  Future<Todo?> createTodo(String title) async {
    await mutate(
      () => ref.read(todoApiProvider).createTodo(title),
      onSuccess: (todo) {
        print('Todo created successfully: ${todo.title}');
      },
      onError: (error) {
        print('Failed to create todo: $error');
      },
    );

    return state.value;
  }
}

// Create your API provider
final todoApiProvider = Provider((ref) => TodoApi());

// Usage in your UI
class TodoScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mutation = ref.watch(createTodoMutationProvider);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            ref.read(createTodoMutationProvider.notifier).createTodo('New Todo');
          },
          child: const Text('Create Todo'),
        ),
        // Show loading state
        if (mutation.isLoading) const CircularProgressIndicator(),
        // Show error state
        if (mutation.isError) Text('Error: ${mutation.error}'),
        // Show success state
        if (mutation.isSuccess) Text('Created: ${mutation.value?.title}'),
      ],
    );
  }
}
```

The `AsyncUpdate` class provides these states:

- `idle`: Initial state before mutation starts
- `loading`: While the mutation is in progress
- `success`: When the mutation completes successfully
- `error`: When the mutation fails

You can check the current state using properties like `isLoading`, `isSuccess`, `isError`, and `isIdle`.

## 👉 About Theodo apps

We are a 130 people company developing and designing universal applications with [React Native](https://apps.theodo.com/expertise/react-native) and [Flutter](https://apps.theodo.com/expertise/flutter) using the Lean & Agile methodology. To get more information on the solutions that would suit your needs, feel free to get in touch by [email](mailto://contact-apps@theodo.com) or through or [contact form](https://apps.theodo.com/contact)!

We will always answer you with pleasure 😁

[dart_install_link]: https://dart.dev/get-dart

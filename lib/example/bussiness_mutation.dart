// ignore_for_file: public_member_api_docs

import 'package:riverpod_community_mutation/src/async_update.dart';
import 'package:riverpod_community_mutation/src/mutation.dart';
import 'package:riverpod/riverpod.dart';

class BussinessMutation extends AutoDisposeNotifier<AsyncUpdate<int>>
    with Mutation {
  @override
  AsyncUpdate<int> build() {
    return const AsyncUpdate<int>.idle();
  }

  Future<int?> toggleFavorite() async {
    await mutate(() {
      return 1;
    });

    return state.value;
  }
}

final bussinessMutationProvider =
    AutoDisposeNotifierProvider<BussinessMutation, AsyncUpdate<int>>(
  BussinessMutation.new,
);

import 'package:diffutil_dart/diffutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AnimatedListHelper {
  static void changeItems<T, ID>({
    int offset = 0,
    Duration removeDuration,
    Duration insertDuration,
    @required AnimatedListState state,
    @required List<T> oldList,
    @required List<T> newList,
    Widget Function(BuildContext context, Animation<double> animation, List<T> items, int position) buildRemovedWidget,
    ID Function(T item) getId,
  }) {
    if (oldList == null && newList != null) {
      for (int i = offset; i < newList.length + offset; i++) {
        state.insertItem(
          i,
          duration: insertDuration ?? const Duration(milliseconds: 300),
        );
      }

      return;
    } else if (oldList != null && newList == null) {
      for (int i = offset; i < oldList.length + offset; i++) {
        state.removeItem(
          i,
          (context, animation) => buildRemovedWidget(
            context,
            animation,
            oldList,
            i,
          ),
          duration: removeDuration ?? const Duration(milliseconds: 300),
        );
      }

      return;
    }

    calculateListDiff(
      oldList,
      newList,
      equalityChecker: (T first, T second) => getId(first) == getId(second),
    ).getUpdates(batch: false).forEach((element) {
      element.when(
        insert: (position, count) => state.insertItem(
          offset + position,
          duration: insertDuration ?? const Duration(milliseconds: 300),
        ),
        remove: (position, count) => state.removeItem(
          offset + position,
          (context, animation) => buildRemovedWidget(
            context,
            animation,
            oldList,
            position,
          ),
          duration: removeDuration ?? const Duration(milliseconds: 300),
        ),
      );
    });
  }
}

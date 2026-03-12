enum AsyncValueState { loading, error, success }

class AsyncValue<T> {
  final T? data;
  final Object? error;
  final AsyncValueState state;

  AsyncValue._({this.data, this.error, required this.state});

  factory AsyncValue.loading() => AsyncValue._(state: AsyncValueState.loading);

  factory AsyncValue.error(Object error) =>
      AsyncValue._(state: AsyncValueState.error, error: error);

  factory AsyncValue.success(T data) =>
      AsyncValue._(state: AsyncValueState.success, data: data);
}

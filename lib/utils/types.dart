typedef Callback = void Function();
typedef ModelAction<T> = Function(T model);
typedef ModelAction2<T, S> = Function(T model, S model2);
typedef ModelAction3<F, S, T> = Function(F model, S model2, T model3);

typedef WillPopUpAction<T> = Future<bool> Function(T model);

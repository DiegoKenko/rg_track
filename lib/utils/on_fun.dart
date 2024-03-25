void onFun<T>(dynamic testType, Function(T value) fun) {
  if (testType is T) {
    fun(testType);
  }
}

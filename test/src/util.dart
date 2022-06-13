import 'package:test/test.dart';

Matcher failsTheTest() => throwsA(isA<TestFailure>());

// To check the use of == and not only 'identical'
class Foo<T> {
  T bar;
  Foo(this.bar);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Foo && other.bar == bar;

  @override
  int get hashCode => bar.hashCode;
}

import 'package:dartz_test/src/either.dart';

import 'package:test/test.dart';
import 'package:dartz/dartz.dart';

class Foo<T> {
  T bar;
  Foo(this.bar);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Foo && other.bar == bar;

  @override
  int get hashCode => bar.hashCode;
}

void main() {
  test('isRight', () async {
    Either right = Right(null);
    expect(right.isRight(), isTrue);
    expect(right, isRight);

    Either left = Left(null);
    expect(left.isLeft(), isTrue);

    expect(() => expect(left, isRight), throwsA(isA<TestFailure>()));
  });

  test('isRightOf', () {
    Either right = Right(Foo("bar"));
    right.fold((l) => throw Exception(), (r) => expect(r, equals(Foo("bar"))));
    expect(right, isRightOf(Foo("bar")));
  });
}

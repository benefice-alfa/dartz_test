import 'package:dartz_test/src/either.dart';

import 'package:test/test.dart';
import 'package:dartz/dartz.dart';

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

void main() {
  group('isX', () {
    group('isRight', () {
      test('isRight on a Right passes the test', () {
        Either right = Right(null);
        expect(right.isRight(), isTrue);
        expect(right, isRight);
      });

      test('isRight on a Left fails the test', () {
        Either left = Left(null);
        expect(left.isLeft(), isTrue);
        expect(() => expect(left, isRight), throwsA(isA<TestFailure>()));
      });
    });

    group('isLeft', () {
      test('isLeft on a Left passes the test', () {
        Either left = Left(null);
        expect(left.isLeft(), true);
        expect(left, isLeft);
      });

      test('isLeft on a Right fails the test', () {
        Either right = Right(null);
        expect(right.isRight(), true);
        expect(() => expect(right, isLeft), throwsA(isA<TestFailure>()));
      });
    });
  });
  group('isXOf', () {
    test('isRightOf', () {
      Either right = Right(Foo('bar'));
      right.fold((l) => throw Error(), (r) => expect(r, equals(Foo('bar'))));
      expect(right, isRightOf(Foo('bar')));
    });

    test('isLeftOf', () {
      Either left = Left(Foo('bar'));

      left.fold((l) => expect(l, equals(Foo('bar'))), (_) => throw Error());
      expect(left, isLeftOf(Foo('bar')));
    });
  });

  group('right and left getters', () {
    test('getRight on Right returns the underlying value', () {
      Either right = Right("foo");

      expect(right.getRight(), equals("foo"));
    });
    test('getRight on Left fails the test', () {
      Either left = Left("foo");
      expect(() => left.getRight(), throwsA(isA<TestFailure>()));
    });

    test('getLeft on Left returns the underlying value', () {
      Either left = Left("foo");

      expect(left.getLeft(), equals("foo"));
    });
    test('getLeft on Right fails the test', () {
      Either right = Right("foo");
      expect(() => right.getLeft(), throwsA(isA<TestFailure>()));
    });
  });
}

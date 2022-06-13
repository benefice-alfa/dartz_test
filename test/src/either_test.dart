import 'package:dartz_test/src/either.dart';

import 'package:test/test.dart';
import 'package:dartz/dartz.dart';

import 'util.dart';

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
        expect(() => expect(left, isRight), failsTheTest());
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
        expect(() => expect(right, isLeft), failsTheTest());
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

      expect(right.getRightOrFailTest(), equals("foo"));
    });
    test('getRight on Left fails the test', () {
      Either left = Left("foo");
      expect(() => left.getRightOrFailTest(), failsTheTest());
    });

    test('getLeft on Left returns the underlying value', () {
      Either left = Left("foo");

      expect(left.getLeftOrFailTest(), equals("foo"));
    });
    test('getLeft on Right fails the test', () {
      Either right = Right("foo");
      expect(() => right.getLeftOrFailTest(), failsTheTest());
    });
  });
}

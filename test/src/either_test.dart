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
  group('XThat', () {
    group('isRightThat', () {
      test(
          'isRightThat passes the test when actual value is Right and matcher matches the right value',
          () {
        Either either = Right(null);

        expect(either, isRightThat(isNull));
      });
      test(
          "isRightThat fails the test when actual value is Right but matcher doesn't match the right value",
          () {
        Either either = Right(null);

        mustFailTest() => expect(either, isRightThat(isNotNull));

        expect(mustFailTest, failsTheTest());
      });
      test(
          'isRightThat fails the test when mather matches the right value but the actual value is Left',
          () {
        Either either = Left(null);
        mustFailTest() => expect(either, isRightThat(isNull));
        expect(mustFailTest, failsTheTest());
      });
      test(
          "isRightThat fails the test when mather doesn't match the right value and the actual value is Left",
          () {
        Either either = Left(null);
        mustFailTest() => expect(either, isRightThat(isNotNull));
        expect(mustFailTest, failsTheTest());
      });
    });
    group('isLeftThat', () {
      test(
          'isLeftThat passes the test when actual value is Left and matcher matches the left value',
          () {
        Either either = Left(null);

        expect(either, isLeftThat(isNull));
      });
      test(
          "isLeftThat fails the test when actual value is Right but matcher doesn't match the Right value",
          () {
        Either either = Left(null);

        mustFailTest() => expect(either, isLeftThat(isNotNull));

        expect(mustFailTest, failsTheTest());
      });

      test(
          'isLeftThat fails the test when mather matches the left value but the actual value is Right',
          () {
        Either either = Right(null);
        mustFailTest() => expect(either, isLeftThat(isNull));
        expect(mustFailTest, failsTheTest());
      });
      test(
          "isLeftThat fails the test when mather doesn't match the left value and the actual value is Right",
          () {
        Either either = Right(null);
        mustFailTest() => expect(either, isLeftThat(isNotNull));
        expect(mustFailTest, failsTheTest());
      });
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

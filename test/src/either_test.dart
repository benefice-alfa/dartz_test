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
    group('isRightOf', () {
      test('Passes the test with an == instance', () {
        Either right = Right(Foo('bar'));
        expect((right as Right).value, equals(Foo('bar')));
        expect(right, isRightOf(Foo('bar')));
      });
      test("Fails the test with a 'not ==' instance", () {
        Either right = Right(Foo('🍣'));
        expect((right as Right).value, isNot(equals(Foo('bar'))));
        mustFailTest() => expect(right, isRightOf(Foo('bar')));
        expect(mustFailTest, failsTheTest());
      });

      test(
          'Comparing two objects equal with the `equal` matcher but not with == fails the test ',
          () {
        var list1 = ['foo'];
        var list2 = ['foo'];

        expect(list1 == list2, isFalse);
        expect(list1, equals(list2));

        Either right = Right(list1);

        mustFail() => expect(right, isRightOf(list2));
        expect(mustFail, failsTheTest());
      });
    });

    group('isLeftOf', () {
      test('Passes the test with an == instance', () {
        Either left = Left(Foo('bar'));
        expect((left as Left).value, equals(Foo('bar')));
        expect(left, isLeftOf(Foo('bar')));
      });
      test("Fails the test with a 'not ==' instance", () {
        Either left = Left(Foo('🍣'));
        expect((left as Left).value, isNot(equals(Foo('bar'))));
        mustFailTest() => expect(left, isLeftOf(Foo('bar')));
        expect(mustFailTest, failsTheTest());
      });
      test(
          'Comparing two objects equal with the `equal` matcher but not with == fails the test ',
          () {
        var list1 = ['foo'];
        var list2 = ['foo'];

        expect(list1 == list2, isFalse);
        expect(list1, equals(list2));

        Either left = Left(list1);

        mustFail() => expect(left, isLeftOf(list2));
        expect(mustFail, failsTheTest());
      });
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

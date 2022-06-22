import 'package:dartz/dartz.dart';
import 'package:dartz_test/src/option.dart';
import 'package:test/test.dart';

import 'util.dart';

void main() {
  group('isSome', () {
    test('isSome on Some passes the test', () async {
      Option option = Some(1);
      expect(option.isSome(), isTrue);
      expect(option, isSome);
    });

    test('isSome on None fails the test', () {
      Option option = None();
      expect(option.isNone(), isTrue);

      expect(() => expect(option, isSome), failsTheTest());
    });
  });

  group('isSomeOf', () {
    test('isSomeOf(an == value)', () {
      Option option = Some(Foo('bar'));

      expect((option as Some).value == Foo('bar'), isTrue);
      expect(option, isSomeOf(Foo('bar')));
    });

    test("isSomeOf(an 'not ==' value)", () {
      Option option = Some(Foo('bar'));

      expect((option as Some).value != Foo('foo'), isTrue);
      expect(option, isNot(isSomeOf(Foo('foo'))));
    });

    test(
        'Comparing two objects equal with the `equal` matcher but not with == fails the test ',
        () {
      var list1 = ['foo'];
      var list2 = ['foo'];

      expect(list1 == list2, isFalse);
      expect(list1, equals(list2));

      Option left = Some(list1);

      mustFail() => expect(left, isSomeOf(list2));
      expect(mustFail, failsTheTest());
    });
  });

  group('getOrFailTest', () {
    test('getOrFailTest on Some passes the test', () {
      Option option = Some(1);

      option.fold(() => throw TestFailure("option should be Some"),
          (a) => expect(a, equals(1)));

      expect(option.getOrFailTest(), equals(1));
    });

    test('getOrFailTest on None fails the test', () {
      Option option = None();

      expect(() => option.getOrFailTest(), failsTheTest());
    });
  });

  group('isSomeThat', () {
    test(
        'isSomeThat on Some whose value matches against matcher passes the test',
        () {
      Option option = Some(1);
      expect(option, isSomeThat(equals(1)));
    });
    test(
        "isSomeThat on Some whose value doesn't match against matcher fails the test",
        () {
      Option option = Some(1);
      mustFailTest() => expect(option, isSomeThat(equals(0)));
      expect(mustFailTest, failsTheTest());
    });

    test('isSomeThat on None fails the test', () {
      Option option = None();
      mustFailTest() => expect(option, isSomeThat(anything));
      expect(mustFailTest, failsTheTest());
    });
  });
}

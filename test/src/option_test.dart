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
    test('isSomeOf(the same value)', () {
      Option option = Some(Foo('bar'));
      option.fold(() => throw TestFailure("option should be Some"),
          (a) => expect(a, equals(Foo('bar'))));

      expect(option, isSomeOf(Foo('bar')));
    });

    test('isSomeOf(a different value)', () {
      Option option = Some(Foo('bar'));
      option.fold(() => throw TestFailure("option should be Some"),
          (a) => expect(a, isNot(equals(Foo('foo')))));

      expect(option, isNot(isSomeOf(Foo('foo'))));
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

    test('isSomeThat on None whose fails the test', () {
      Option option = None();
      mustFailTest() => expect(option, isSomeThat(anything));
      expect(mustFailTest, failsTheTest());
    });
  });
}

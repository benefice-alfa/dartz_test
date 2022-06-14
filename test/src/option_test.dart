import 'package:dartz/dartz.dart';
import 'package:dartz_test/src/option.dart';
import 'package:test/test.dart';

import 'util.dart';

void main() {
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

  test('getOrFail on Some passes the test', () {
    Option option = Some(1);

    option.fold(() => throw TestFailure("option should be Some"),
        (a) => expect(a, equals(1)));

    expect(option.getOrFailTest(), equals(1));
  });

  test('getOrFailTest on None fails the test', () {
    Option option = None();

    expect(() => option.getOrFailTest(), failsTheTest());
  });
}

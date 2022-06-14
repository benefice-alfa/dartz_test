import 'package:dartz_test/dartz_test.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';

void main() {
  test('either is right', () {
    Either either = Right('foo');

    expect(either, isRight);
    expect(either, isRightOf('foo'));
    expect(either, isRightThat(equals('foo')));

    var value = either.getRightOrFailTest();
    expect(value, equals('foo'));
  });

  test('option is none', () {
    Option option = None();
    expect(option, isNone);
  });

  test('option is Some', () {
    Option option = Some('foo');

    expect(option, isSome);
    expect(option, isSomeOf('foo'));
    expect(option, isSomeThat(equals('foo')));

    var value = option.getOrFailTest();
    expect(value, equals('foo'));
  });
}

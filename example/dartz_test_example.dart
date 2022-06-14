import 'package:dartz_test/dartz_test.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';

void main() {
  test('either is right', () {
    Either either = Right('foo');

    expect(either, isRight);
    expect(either, isRightOf('foo'));

    var right = either.getRightOrFailTest();
    expect(right, equals('foo'));
  });

  test('option is none', () {
    Option option = None();
    expect(option, isNone);
  });

  test('option is Some', () {
    Option option = Some('foo');
    expect(option, isSomeOf('foo'));

    var foo = option.getOrFailTest();

    expect(foo, equals('foo'));
  });
}

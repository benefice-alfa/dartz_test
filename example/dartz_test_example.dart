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

  test('either is left', () {
    Either either = Left('foo');

    expect(either, isLeft);
    expect(either, isLeftOf('foo'));
    expect(either, isLeftThat(equals('foo')));

    var value = either.getRightOrFailTest();
    expect(value, equals('foo'));
  });

  test("isLeftOf and isRightOf work with == and not the 'equals' matcher ", () {
    var list1 = ['foo'];
    var list2 = ['foo'];

    // Unless list1 and list2 are declared with const in this example, list1 != list2
    // This line passes the test
    expect(list1 == list2, isFalse);

    // But the `equals` matcher compares the two lists item by item.
    // This line passes the test
    expect(list1, equals(list2));

    Either either = Right(list1);

    //! Because list1 != list2, this line doesn't pass the test
    expect(either, isRightOf(list2));

    // Use `isRightThat` instead
    expect(either, isRightThat(equals(list2)));

    // `isLeftOf` and `isLeftThat` behave exactly the same
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

  test("`isSomeOf` works with == and not the `equals` matcher", () {
    var list1 = ['foo'];
    var list2 = ['foo'];

    Either either = Right(list1);

    //! Because list1 != list2, this line doesn't pass the test
    expect(either, isSomeOf(list2));

    // Use `isSomeThat` instead
    expect(either, isSomeThat(equals(list2)));
  });
}

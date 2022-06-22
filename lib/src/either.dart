// dart pub global run coverage:test_with_coverage

import 'package:dartz/dartz.dart';
import 'package:test/test.dart';

class _IsRight extends Matcher {
  const _IsRight();
  @override
  Description describe(Description description) => description.add("right");
  @override
  bool matches(Object? item, Map matchState) => (item as Either).isRight();
}

/// Matches if the object is of type Right.
///
/// Example :
///
/// The following test is successfull if and only if `either.isRight()`
/// returns `true`
/// ```dart
/// Either<Failure, String> either = fetchData();
///
/// expect(either, isRight); // Passes the test if `either.isRight()` returns true
/// ```
const Matcher isRight = _IsRight();

class _IsRightOf extends Matcher {
  final Object? _expected;
  const _IsRightOf(this._expected);
  @override
  bool matches(Object? item, Map matchState) =>
      (item as Either).fold((l) => false, (r) => r == _expected);

  @override
  Description describe(Description description) => description
      .add('a right instance that is equal to')
      .addDescriptionOf(_expected);
}

/// Returns a matcher that matches if the actual object is of type [Right] and
/// the underlying value is equal (for ==) to the expected value.
///
/// Example :
///
/// ```dart
/// Either<Failure, String> either = fetchData();
///
/// expect((either as Right).value == 'foo', isTrue);
///
/// ```
///
/// is equivalent to :
///
/// ```dart
/// Either<Failure, String> either = fetchData();
///
/// expect(either, isRightOf('foo'))
/// ```
///
/// **This matcher hasn't the same behavior than the `equals` matcher when
/// comparing the two values** :
///
/// ```dart
/// test("isRightOf work with == and not the 'equals' matcher", () {
///    var list1 = ['foo'];
///    var list2 = ['foo'];
///
///    // Unless list1 and list2 are declared with const in this example, list1 != list2
///    // This line passes the test
///    expect(list1 == list2, isFalse);
///
///    // But the `equals` matcher compares the two lists item by item.
///    // This line passes the test
///    expect(list1, equals(list2));
///
///    Either either = Right(list1);
///
///    //! Because list1 != list2, this line doesn't pass the test
///    expect(either, isRightOf(list2));
///
///    // Use `isRightThat` instead
///    expect(either, isRightThat(equals(list2)));
///
///  });
/// ```
Matcher isRightOf(Object? expected) => _IsRightOf(expected);

class _IsLeft extends Matcher {
  const _IsLeft();
  @override
  Description describe(Description description) => description.add("left");
  @override
  bool matches(Object? item, Map matchState) => (item as Either).isLeft();
}

/// Matches if the object is of type Left.
///
/// Example :
///
/// The following test is successfull if and only if `either.isLeft()`
/// returns `true`
/// ```dart
/// Either<Failure, String> either = fetchData();
///
/// expect(either, isLeft); // Passes the test if `either.isLeft()` returns true
/// ```
const Matcher isLeft = _IsLeft();

class _IsLeftOf extends Matcher {
  final Object? _expected;
  const _IsLeftOf(this._expected);
  @override
  bool matches(Object? item, Map matchState) =>
      (item as Either).fold((l) => l == _expected, (_) => false);

  @override
  Description describe(Description description) => description
      .add('a left instance that is equal to')
      .addDescriptionOf(_expected);
}

/// Returns a matcher that matches if the actual object is of type [Left] and
/// the underlying value is equal (for ==) to the expected value.
///
/// Example :
///
/// ```dart
/// Either<Failure, String> either = fetchData();
///
/// expect((either as Left).value == 'foo', isTrue);
///
/// ```
///
/// is equivalent to :
///
/// ```dart
/// Either<Failure, String> either = fetchData();
///
/// expect(either, isLeftOf('foo'))
/// ```
///
/// **This matcher hasn't the same behavior than the `equals` matcher when
/// comparing the two values** :
///
/// ```dart
/// test("isLefttOf work with == and not the 'equals' matcher", () {
///    var list1 = ['foo'];
///    var list2 = ['foo'];
///
///    // Unless list1 and list2 are declared with const in this example, list1 != list2
///    // This line passes the test
///    expect(list1 == list2, isFalse);
///
///    // But the `equals` matcher compares the two lists item by item.
///    // This line passes the test
///    expect(list1, equals(list2));
///
///    Either either = Left(list1);
///
///    //! Because list1 != list2, this line doesn't pass the test
///    expect(either, isLefttOf(list2));
///
///    // Use `isRightThat` instead
///    expect(either, isLefttThat(equals(list2)));
///
///  });
/// ```
///
Matcher isLeftOf(Object? expected) => _IsLeftOf(expected);

/// Extension on [Either] type to use in tests.
extension TestEitherX<L, R> on Either<L, R> {
  /// Returns the right value of an [Either], or fails the test.
  ///
  /// To use only in tests.
  R getRightOrFailTest() =>
      getOrElse(() => throw TestFailure('Either should be right'));

  /// Returns the left value of an [Either], or fails the test.
  ///
  /// To use only in tests.
  L getLeftOrFailTest() =>
      swap().getOrElse(() => throw TestFailure('Either should be left'));
}

/// Matcher that tries to extract the right value of an [Either] instance to match
/// it against [matcher]
///
/// The test fails if the actual value is a [Left]
// ignore: camel_case_types
class isRightThat extends CustomMatcher {
  isRightThat(matcher) : super("Either whose right value is", "right", matcher);
  @override
  Object? featureValueOf(actual) => (actual as Right).value;
}

/// Matcher that tries to extract the left value of an [Either] instance to match
/// it against [matcher]
///
/// The test fails if the actual value is a [Right]
// ignore: camel_case_types
class isLeftThat extends CustomMatcher {
  isLeftThat(matcher) : super("Either whose left value is", "left", matcher);
  @override
  Object? featureValueOf(actual) => (actual as Left).value;
}

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

/// Returns a matcher that matches if the object is of type [Right] and the
/// underlying value is equal to the argument
///
/// Example :
///
/// ```dart
/// Either<Failure, String> either = fetchData();
///
/// either.fold((_) => throw TestFailure('Either should be right'), (r) => expect(r, equals('foo')));
/// ```
///
/// is equivalent to :
///
/// ```dart
/// Either<Failure, String> either = fetchData();
///
/// expect(either, isRightOf('foo'))
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

/// Returns a matcher that matches if the object is of type [Left] and the
/// underlying value is equal to the argument
///
/// Example :
///
/// ```dart
/// Either<Failure, String> either = fetchData();
///
/// either.fold((l) => expect(l, equals('foo')), (_) => throw TestFailure('Either should be left'));
/// ```
///
/// is equivalent to :
///
/// ```dart
/// Either<Failure, String> either = fetchData();
///
/// expect(either, isLeftOf('foo'))
/// ```
Matcher isLeftOf(Object? expected) => _IsLeftOf(expected);

extension EitherX<L, R> on Either<L, R> {
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

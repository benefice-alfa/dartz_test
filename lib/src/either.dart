import 'package:dartz/dartz.dart';
import 'package:test/test.dart';

// Matchers for the [Either] type

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
/// either.fold((l) => throw Exception(), (r) => expect(r, equals('foo')));
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
///
Matcher isRightOf(Object? expected) => _IsRightOf(expected);

class EitherIsLeftError extends Error {}

extension EitherX<L, R> on Either<L, R> {
  R getOrCrash() => getOrElse(() => throw EitherIsLeftError());
}

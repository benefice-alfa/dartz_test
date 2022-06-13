import 'package:dartz/dartz.dart';
import 'package:test/test.dart';

class _IsNone extends Matcher {
  const _IsNone();
  @override
  Description describe(Description description) => description.add("none");
  @override
  bool matches(Object? item, Map matchState) => (item as Option).isNone();
}

/// Matches if the object is of type None
///
/// Example :
///
/// The following test is successfull if and only if
/// `option.isNone()` returns `true`
/// ```dart
/// Option<String> option = fetchData();
///
/// expect(option, isNone);
/// ```
const Matcher isNone = _IsNone();

class _IsSome extends Matcher {
  const _IsSome();
  @override
  Description describe(Description description) => description.add("some");
  @override
  bool matches(Object? item, Map matchState) => (item as Option).isSome();
}

/// Matches if the object is of type Some
///
/// Example :
///
/// The following test is successfull if and only if
/// `option.isSome()` returns `true`
/// ```dart
/// Option<String> option = fetchData();
///
/// expect(option, isSome);
/// ```
const Matcher isSome = _IsSome();

class _IsSomeOf extends Matcher {
  final Object? _expected;
  const _IsSomeOf(this._expected);
  @override
  bool matches(Object? item, Map matchState) =>
      (item as Option).fold(() => false, (a) => a == _expected);

  @override
  Description describe(Description description) => description
      .add('a Some instance whose underlying value is equal to ')
      .addDescriptionOf(_expected);
}

/// Matcher that matches with a Some instance whose underlying value is equal
/// to [expected]. Equality is tested with ==
///
/// Example :
///
/// The following test is successfull
/// ```dart
/// Option option = Some(0);
///
/// expect(option, isSomeOf(0));
/// expect(option, isNot(isSomeOf(42)));
/// ```
///
Matcher isSomeOf(Object expected) => _IsSomeOf(expected);

extension OptionX<T> on Option<T> {
  /// Returns the value or makes the test fail.
  T getOrFail() => getOrElse(() => throw TestFailure('option should be Some'));
}

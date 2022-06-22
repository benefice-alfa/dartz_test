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
///  **This matcher hasn't the same behavior than the `equals` matcher when
/// comparing the two values** :
///
/// ```dart
/// test(
///    "`isSomeOf` works with == and not the `equals` matcher",
///    () {
///      var list1 = ['foo'];
///      var list2 = ['foo'];
///
///    Either either = Right(list1);
///
///    //! Because list1 != list2, this line doesn't pass the test
///    expect(either, isSomeOf(list2));
///
///    // Use `isSomeThat` instead
///    expect(either, isSomeThat(equals(list2)));
///    }
///  )
/// ```
Matcher isSomeOf(Object expected) => _IsSomeOf(expected);

/// Extension on [Option] type to use in tests.
extension TestOptionX<T> on Option<T> {
  /// Returns the value or makes the test fail.
  T getOrFailTest() =>
      getOrElse(() => throw TestFailure('option should be Some'));
}

/// Matcher that tries to extract the value of a [Some] instance to match
/// it against [matcher]
///
/// The test fails if the actual value is a [None]
// ignore: camel_case_types
class isSomeThat extends CustomMatcher {
  isSomeThat(matcher)
      : super("Option that holds a value that is", "some", matcher);
  @override
  Object? featureValueOf(actual) => (actual as Some).value;
}

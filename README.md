Provides matchers to help unit-testing your apps when using functional programming types defined in the [dartz](https://pub.dev/packages/dartz) package.

---

[![codecov](https://codecov.io/gh/SuperMuel/dartz_test/branch/main/graph/badge.svg?token=5HERRNTPSI)](https://codecov.io/gh/SuperMuel/dartz_test)
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Pub badge](https://img.shields.io/pub/v/dartz_test)](https://pub.dev/packages/dartz_test)


## Getting started

### Installation :

`dart pub add --dev dartz_test`

## Usage

### Eithers

```dart
test('either is right', () {
    Either either = Right('foo');

    expect(either, isRight);
    expect(either, isRightOf('foo'));
    expect(either, isRightThat(equals('foo')));

    var value = either.getRightOrFailTest();
    expect(value, equals('foo'));
  });
```

The same matchers exist for `Left`

### Options

```dart
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
```

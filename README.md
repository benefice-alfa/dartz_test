Provides matchers to help unit-testing your apps when using functional programming types defined in the dartz package.

---

[![codecov](https://codecov.io/gh/SuperMuel/dartz_test/branch/main/graph/badge.svg?token=5HERRNTPSI)](https://codecov.io/gh/SuperMuel/dartz_test)

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

    var right = either.getRightOrFailTest();
    expect(right, equals('foo'));
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
    expect(option, isSomeOf('foo'));

    var foo = option.getOrFailTest();

    expect(foo, equals('foo'));
  });
```

## Additional information

Don't expect anything from this package for now.

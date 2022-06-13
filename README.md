Provides matchers to help unit-testing your apps when using functional programming types defined in the dartz package.

## Getting started

### Installation :

`dart pub add --dev dartz_test`

## Usage

```dart
Either<Failure, String> mustBeRight = mockFetchData();

expect(mustBeRight, isRight);

mustBeRight = Right('foo');

expect(mustBeRight, isRightOf('foo'));
```

## Additional information

Don't expect anything from this package for now.

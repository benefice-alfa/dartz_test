import 'package:dartz_test/dartz_test.dart';
import 'package:dartz/dartz.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('either is right', () {
    Either either = Right("foo");

    expect(either, isRight);
    expect(either, isRightOf("foo"));
  });
}

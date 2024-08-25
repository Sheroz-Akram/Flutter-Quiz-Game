import 'dart:math';

// Generate List of Random Number
List<int> generateUniqueRandomNumbers(int start, int end, int size) {
  if (size <= 0) {
    throw ArgumentError('Size must be greater than 0.');
  }
  if (start >= end) {
    throw ArgumentError('Start must be less than end.');
  }
  if (size > (end - start)) {
    throw ArgumentError(
        'Size must be less than or equal to the range between start and end.');
  }

  Random random = Random();
  Set<int> uniqueNumbers = <int>{};

  while (uniqueNumbers.length < size) {
    int number = random.nextInt(end - start) + start;
    uniqueNumbers.add(number);
  }

  return uniqueNumbers.toList();
}

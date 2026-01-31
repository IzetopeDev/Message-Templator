class NullValueException implements Exception {
  final String? context;
  final String? customMessage;

  const NullValueException({
    this.context,
    this.customMessage,
  });

  String get message {
    return customMessage ?? "${context ?? "value"} is null!";
  }

  static void check(
    dynamic value, {
    String? context,
    String? customMessage,
  }) {
    if (value == null) {
      throw NullValueException(context: context, customMessage: customMessage);
    }
  }

  @override
  String toString() {
    return message;
  }
}

class UnpredictedException implements Exception {
  final dynamic value; 
  final String? context;
  final String? customMessage;
  final StackTrace? stack;

  const UnpredictedException({
    this.value,
    this.context,
    this.customMessage,
    this.stack,
  });

  String get message {
    return customMessage 
      // ignore: prefer_adjacent_string_concatenation
      ?? "Unexpected value (${context ?? "unknown"})}\n" +
        "value: $value" +
        "stack trace: ${stack ?? StackTrace.current}"; 
  }

  @override
  String toString() {
    return message;
  }
}


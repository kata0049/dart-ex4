//code retrieved from https://dart.dev/tutorials/server/fetch-data

class PackageRetrievalException implements Exception {
  final int? statusCode;

  PackageRetrievalException({required this.statusCode});

  @override
  String toString() {
    final StringBuffer buf = StringBuffer();
    buf.write('Failed to retrieve package information');

    if (statusCode != null) {
      buf.write(' with a status code of $statusCode');
    }

    buf.write('!');
    return buf.toString();
  }
}

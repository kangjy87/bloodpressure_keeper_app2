/** SNS type -- platform */
enum SnsType {
  youtube,
  instagram
}

/** Feed media type */
enum MediaType {
  video,
  image
}

/** String to enum */
T enumFromString<T>(List<T> values, String value) {
  return values.firstWhere((v) => v.toString().split('.')[1] == value);
}
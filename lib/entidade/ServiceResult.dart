

class ServiceResult<T> {
  bool success;
  T data;
  String errorMessage;

  ServiceResult() {}

  ServiceResult.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        data = json['data'],
        errorMessage = json['errorMessage'];
}

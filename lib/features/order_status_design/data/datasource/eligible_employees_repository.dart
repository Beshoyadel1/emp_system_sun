import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/core/api/dio_function/dio_controller.dart';

class EligibleEmployee {
  const EligibleEmployee({required this.id, required this.name});
  final int id;
  final String name;
}

dynamic _field(Map data, String name) {
  for (final entry in data.entries) {
    if (entry.key.toString().toLowerCase() == name.toLowerCase()) {
      return entry.value;
    }
  }
  return null;
}

Future<List<EligibleEmployee>> getEligibleEmployees({
  required int providerId,
  required int branchId,
  required List<int> serviceIds,
}) async {
  if (serviceIds.isEmpty) return [];
  final response = await Network.postDataWithBodyAndParams(
    {
      'ProviderId': providerId,
      'BranchId': branchId,
      'ServiceIds': serviceIds,
    },
    <String, dynamic>{},
    ApiLink.getProviderEmployeesByServices,
  );
  return eligibleEmployeesFromResponse(response.data, serviceIds);
}

List<EligibleEmployee> eligibleEmployeesFromResponse(
    dynamic body, List<int> serviceIds) {
  if (body is! Map || _field(body, 'success') != true) {
    throw StateError('Could not load eligible employees');
  }
  final data = _field(body, 'data');
  if (data is! List) return [];
  final result = <int, EligibleEmployee>{};
  for (final item in data.whereType<Map>()) {
    final wrapper = _field(item, 'EmployeeDetails');
    final details = wrapper is Map ? _field(wrapper, 'EmployeeDetails') : null;
    if (details is! Map) continue;
    final id = int.tryParse('${_field(details, 'id')}');
    if (id == null || id <= 0) continue;
    final assigned = wrapper is Map ? _field(wrapper, 'serviceIds') : null;
    if (assigned is! List ||
        !assigned.any((id) => serviceIds.contains(int.tryParse('$id')))) {
      continue;
    }
    final name = (_field(item, 'username') ?? _field(details, 'jobname'))
        ?.toString()
        .trim();
    result[id] = EligibleEmployee(
      id: id,
      name: name == null || name.isEmpty ? 'Employee #$id' : name,
    );
  }
  return result.values.toList();
}

import 'package:flutter/material.dart';
import 'package:emp_system_sun/core/language/language.dart';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/features/order_status_design/data/datasource/eligible_employees_repository.dart';

class AssignOrderDialog extends StatefulWidget {
  const AssignOrderDialog({
    super.key,
    required this.providerId,
    required this.branchId,
    required this.serviceIds,
  });

  final int providerId;
  final int branchId;
  final List<int> serviceIds;

  @override
  State<AssignOrderDialog> createState() => _AssignOrderDialogState();
}

class _AssignOrderDialogState extends State<AssignOrderDialog> {
  late final Future<List<EligibleEmployee>> employees = getEligibleEmployees(
    providerId: widget.providerId,
    branchId: widget.branchId,
    serviceIds: widget.serviceIds,
  );
  final Set<int> selected = {};

  @override
  Widget build(BuildContext context) {
    final language = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(language.translate(AppLanguageKeys.chooseEligibleEmployees)),
      content: SizedBox(
        width: 420,
        height: 300,
        child: FutureBuilder<List<EligibleEmployee>>(
          future: employees,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final people = snapshot.data!;
            if (people.isEmpty) {
              return Text(
                  language.translate(AppLanguageKeys.noEligibleEmployees));
            }
            return ListView(
              shrinkWrap: true,
              children: people
                  .map((person) => CheckboxListTile(
                        title: Text(person.name),
                        value: selected.contains(person.id),
                        onChanged: (value) => setState(() {
                          if (value == true) {
                            selected.add(person.id);
                          } else {
                            selected.remove(person.id);
                          }
                        }),
                      ))
                  .toList(),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(language.translate(AppLanguageKeys.cancel)),
        ),
        FilledButton(
          onPressed: selected.isEmpty
              ? null
              : () => Navigator.pop(context, selected.toList()),
          child: Text(language.translate(AppLanguageKeys.assignOrder)),
        ),
      ],
    );
  }
}

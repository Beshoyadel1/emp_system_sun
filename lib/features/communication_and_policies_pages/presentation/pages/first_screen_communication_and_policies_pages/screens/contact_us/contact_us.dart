import 'package:flutter/material.dart';
import 'last_button_in_contact_us.dart';
import 'data_send_in_contact_us.dart';
import 'first_title_in_contact_us.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 10),
            FirstTitleInContactUs(),
            DataSendInContactUs(),
            LastButtonInContactUs()
          ],
        ),
      ),
    );
  }
}

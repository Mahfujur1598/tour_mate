import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class TourBookingFormPage extends StatefulWidget {
  const TourBookingFormPage({super.key});

  @override
  State<TourBookingFormPage> createState() => _TourBookingFormPageState();
}

class _TourBookingFormPageState extends State<TourBookingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  DateTime? _date;
  int _guests = 2;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tour = (Get.arguments as Map?) ?? {};
    return Scaffold(
      appBar: AppBar(title: const Text('Book Tour')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(tour['name'] ?? 'Selected Tour', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Full name'),
              validator: (v) => (v==null || v.isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phone,
              decoration: const InputDecoration(labelText: 'Phone number'),
              keyboardType: TextInputType.phone,
              validator: (v) => (v==null || v.isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            ListTile(
              title: Text(_date == null ? 'Pick travel date' : _date!.toString().split(' ').first),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final now = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  initialDate: now.add(const Duration(days: 7)),
                  firstDate: now,
                  lastDate: now.add(const Duration(days: 365)),
                );
                if (picked != null) setState(() => _date = picked);
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Guests:'),
                const SizedBox(width: 12),
                DropdownButton<int>(
                  value: _guests,
                  items: List.generate(10, (i) => i+1)
                      .map((n) => DropdownMenuItem(value: n, child: Text(n.toString())))
                      .toList(),
                  onChanged: (v) => setState(() => _guests = v ?? 2),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() != true || _date == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please complete the form')));
                  return;
                }
                Get.toNamed(AppRoutes.bookingConfirm, arguments: {
                  'tour': tour,
                  'name': _name.text,
                  'phone': _phone.text,
                  'date': _date!.toIso8601String(),
                  'guests': _guests,
                });
              },
              child: const Text('Review & Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}

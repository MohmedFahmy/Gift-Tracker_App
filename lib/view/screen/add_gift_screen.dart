import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../../core/util/responsive.dart';
import '../../data/model/gift_model.dart';

class AddGiftScreen extends StatefulWidget {
  final Function(Gift) onGiftAdded;

  const AddGiftScreen({super.key, required this.onGiftAdded});

  @override
  State<AddGiftScreen> createState() => _AddGiftScreenState();
}

class _AddGiftScreenState extends State<AddGiftScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController eventNameController = TextEditingController();

  DateTime? selectedDate;
  bool isReminderEnabled = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final gift = Gift(
        name: nameController.text,
        description: descriptionController.text,
        recipient: recipientController.text,
        eventDate: isReminderEnabled ? selectedDate : null,
        eventName: isReminderEnabled && eventNameController.text.isNotEmpty
            ? eventNameController.text
            : null,
      );

      widget.onGiftAdded(gift);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gift added successfully!')),
      );

      Navigator.pop(context);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(responsive.dynamicRadius(12)),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Add Gift')),
      body: Padding(
        padding: EdgeInsets.all(responsive.dynamicPadding(16)),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Gift Name',
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter gift name' : null,
              ),
              SizedBox(height: responsive.dynamicPadding(12)),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                ),
              ),
              SizedBox(height: responsive.dynamicPadding(12)),
              TextFormField(
                controller: recipientController,
                decoration: InputDecoration(
                  labelText: 'Recipient',
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                ),
              ),
              SizedBox(height: responsive.dynamicPadding(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enable Reminder',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.dynamicFont(16),
                    ),
                  ),
                  Switch(
                    value: isReminderEnabled,
                    onChanged: (value) {
                      setState(() {
                        isReminderEnabled = value;
                      });
                    },
                  ),
                ],
              ),
              if (isReminderEnabled) ...[
                SizedBox(height: responsive.dynamicPadding(12)),
                TextFormField(
                  controller: eventNameController,
                  decoration: InputDecoration(
                    labelText: 'Event Name',
                    border: inputBorder,
                    focusedBorder: inputBorder,
                    enabledBorder: inputBorder,
                  ),
                ),
                SizedBox(height: responsive.dynamicPadding(20)),
                Text(
                  'Event Date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.dynamicFont(15),
                  ),
                ),
                SizedBox(height: responsive.dynamicPadding(8)),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius:
                        BorderRadius.circular(responsive.dynamicRadius(12)),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.dynamicPadding(12),
                    vertical: responsive.dynamicPadding(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today,
                          color: Colors.grey,
                          size: responsive.dynamicFont(18)),
                      SizedBox(width: responsive.dynamicPadding(8)),
                      Expanded(
                        child: Text(
                          selectedDate != null
                              ? DateFormat.yMMMd().format(selectedDate!)
                              : 'No date selected',
                          style: TextStyle(
                            fontSize: responsive.dynamicFont(15),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _pickDate,
                        child: const Text('Pick Date'),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: responsive.dynamicPadding(24)),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  'Add Gift',
                  style: TextStyle(fontSize: responsive.dynamicFont(16)),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: responsive.dynamicPadding(16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(responsive.dynamicRadius(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/feed_record.dart';
import '../providers/chicken_provider.dart';
import '../providers/record_provider.dart';

class AddFeedRecordScreen extends StatefulWidget {
  const AddFeedRecordScreen({Key? key}) : super(key: key);

  @override
  _AddFeedRecordScreenState createState() => _AddFeedRecordScreenState();
}

class _AddFeedRecordScreenState extends State<AddFeedRecordScreen> {
  late TextEditingController _quantityController;
  late TextEditingController _costController;
  late TextEditingController _notesController;
  String? _selectedChickenId;
  String _selectedFeedType = 'morning';
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController();
    _costController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _costController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chickens = context.watch<ChickenProvider>().chickens;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catat Konsumsi Pakan'),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Icon
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.restaurant,
                    size: 50,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Chicken Selector
              const Text(
                'Pilih Ayam',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              if (chickens.isEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red[300]!),
                  ),
                  child: const Text(
                    'Belum ada ayam terdaftar. Silakan tambahkan ayam terlebih dahulu.',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedChickenId,
                    isExpanded: true,
                    underline: const SizedBox(),
                    hint: const Text('Pilih ayam'),
                    items: chickens.map((chicken) {
                      return DropdownMenuItem(
                        value: chicken.id,
                        child: Text(chicken.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedChickenId = value;
                      });
                    },
                  ),
                ),
              const SizedBox(height: 16),

              // Date Picker
              _buildDateField(),
              const SizedBox(height: 16),

              // Feed Type Dropdown
              _buildFeedTypeDropdown(),
              const SizedBox(height: 16),

              // Quantity Field
              _buildTextField(
                controller: _quantityController,
                label: 'Jumlah Pakan (kg)',
                hint: '0.00',
                icon: Icons.kitchen,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Cost Field
              _buildTextField(
                controller: _costController,
                label: 'Biaya (Rp)',
                hint: '0',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Notes Field
              _buildTextField(
                controller: _notesController,
                label: 'Catatan',
                hint: 'Tambahkan catatan tentang pemberian pakan',
                icon: Icons.notes,
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _saveFeedRecord,
                  child: const Text(
                    'Simpan Catatan Pakan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.green[700]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.green[700]!, width: 2),
            ),
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tanggal',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              setState(() {
                _selectedDate = picked;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.green[700]),
                const SizedBox(width: 12),
                Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeedTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Jenis Pakan',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: _selectedFeedType,
            isExpanded: true,
            underline: const SizedBox(),
            items: [
              DropdownMenuItem(
                value: 'morning',
                child: Row(
                  children: const [
                    Icon(Icons.wb_sunny, size: 16, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('Pakan Pagi'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'noon',
                child: Row(
                  children: const [
                    Icon(Icons.wb_sunny, size: 16, color: Colors.yellow),
                    SizedBox(width: 8),
                    Text('Pakan Siang'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'evening',
                child: Row(
                  children: const [
                    Icon(Icons.wb_twilight, size: 16, color: Colors.purple),
                    SizedBox(width: 8),
                    Text('Pakan Malam'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'supplement',
                child: Row(
                  children: const [
                    Icon(Icons.add_circle, size: 16, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Suplemen'),
                  ],
                ),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedFeedType = value ?? 'morning';
              });
            },
          ),
        ),
      ],
    );
  }

  void _saveFeedRecord() {
    if (_selectedChickenId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih ayam terlebih dahulu')),
      );
      return;
    }

    if (_quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan jumlah pakan')),
      );
      return;
    }

    final quantity = double.tryParse(_quantityController.text) ?? 0.0;
    final cost = double.tryParse(_costController.text) ?? 0.0;

    final feedRecord = FeedRecord(
      id: const Uuid().v4(),
      chickenId: _selectedChickenId!,
      quantity: quantity,
      dateRecorded: _selectedDate,
      feedType: _selectedFeedType,
      cost: cost,
      notes: _notesController.text,
    );

    context.read<RecordProvider>().addFeedRecord(feedRecord);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Catatan pakan berhasil disimpan')),
    );

    Navigator.pop(context);
  }
}

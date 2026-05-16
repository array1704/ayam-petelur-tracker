import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/egg_record.dart';
import '../providers/chicken_provider.dart';
import '../providers/record_provider.dart';

class AddEggRecordScreen extends StatefulWidget {
  const AddEggRecordScreen({Key? key}) : super(key: key);

  @override
  _AddEggRecordScreenState createState() => _AddEggRecordScreenState();
}

class _AddEggRecordScreenState extends State<AddEggRecordScreen> {
  late TextEditingController _quantityController;
  late TextEditingController _weightController;
  late TextEditingController _notesController;
  String? _selectedChickenId;
  String _selectedQuality = 'normal';
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController();
    _weightController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chickens = context.watch<ChickenProvider>().chickens;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catat Produksi Telur'),
        backgroundColor: Colors.amber[700],
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
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.egg,
                    size: 50,
                    color: Colors.orange,
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

              // Quantity Field
              _buildTextField(
                controller: _quantityController,
                label: 'Jumlah Telur',
                hint: '0',
                icon: Icons.egg,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Quality Dropdown
              _buildQualityDropdown(),
              const SizedBox(height: 16),

              // Weight Field
              _buildTextField(
                controller: _weightController,
                label: 'Berat Rata-rata (g)',
                hint: '0.00',
                icon: Icons.scale,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Notes Field
              _buildTextField(
                controller: _notesController,
                label: 'Catatan',
                hint: 'Tambahkan catatan tentang produksi telur',
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
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _saveEggRecord,
                  child: const Text(
                    'Simpan Catatan Telur',
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
            prefixIcon: Icon(icon, color: Colors.orange),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.orange, width: 2),
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
                const Icon(Icons.calendar_today, color: Colors.orange),
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

  Widget _buildQualityDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kualitas Telur',
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
            value: _selectedQuality,
            isExpanded: true,
            underline: const SizedBox(),
            items: [
              DropdownMenuItem(
                value: 'normal',
                child: Row(
                  children: const [
                    Icon(Icons.circle, size: 8, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Normal'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'small',
                child: Row(
                  children: const [
                    Icon(Icons.circle, size: 8, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('Kecil'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'large',
                child: Row(
                  children: const [
                    Icon(Icons.circle, size: 8, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Besar'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'cracked',
                child: Row(
                  children: const [
                    Icon(Icons.circle, size: 8, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Retak'),
                  ],
                ),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedQuality = value ?? 'normal';
              });
            },
          ),
        ),
      ],
    );
  }

  void _saveEggRecord() {
    if (_selectedChickenId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih ayam terlebih dahulu')),
      );
      return;
    }

    if (_quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan jumlah telur')),
      );
      return;
    }

    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final weight = double.tryParse(_weightController.text);

    final eggRecord = EggRecord(
      id: const Uuid().v4(),
      chickenId: _selectedChickenId!,
      dateRecorded: _selectedDate,
      quantity: quantity,
      quality: _selectedQuality,
      weight: weight,
      notes: _notesController.text,
    );

    context.read<RecordProvider>().addEggRecord(eggRecord);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Catatan telur berhasil disimpan')),
    );

    Navigator.pop(context);
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/chicken.dart';
import '../providers/chicken_provider.dart';

class AddChickenScreen extends StatefulWidget {
  final Chicken? chicken;

  const AddChickenScreen({Key? key, this.chicken}) : super(key: key);

  @override
  _AddChickenScreenState createState() => _AddChickenScreenState();
}

class _AddChickenScreenState extends State<AddChickenScreen> {
  late TextEditingController _nameController;
  late TextEditingController _breedController;
  late TextEditingController _weightController;
  late TextEditingController _notesController;
  String _selectedStatus = 'active';
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.chicken?.name ?? '');
    _breedController = TextEditingController(text: widget.chicken?.breed ?? '');
    _weightController =
        TextEditingController(text: widget.chicken?.currentWeight.toString() ?? '');
    _notesController = TextEditingController(text: widget.chicken?.notes ?? '');
    _selectedStatus = widget.chicken?.status ?? 'active';
    _selectedDate = widget.chicken?.dateAdded ?? DateTime.now();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chicken == null ? 'Tambah Ayam' : 'Edit Ayam'),
        backgroundColor: Colors.amber[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Section
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.chicken_meat,
                    size: 50,
                    color: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Form Fields
              _buildTextField(
                controller: _nameController,
                label: 'Nama Ayam',
                hint: 'Masukkan nama ayam',
                icon: Icons.pets,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _breedController,
                label: 'Ras Ayam',
                hint: 'Contoh: Pelung, Leghorn, Brahma',
                icon: Icons.category,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _weightController,
                label: 'Berat Awal (kg)',
                hint: '0.00',
                icon: Icons.scale,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Date Picker
              _buildDateField(),
              const SizedBox(height: 16),

              // Status Dropdown
              _buildStatusDropdown(),
              const SizedBox(height: 16),

              // Notes Field
              _buildTextField(
                controller: _notesController,
                label: 'Catatan',
                hint: 'Tambahkan catatan tentang ayam ini',
                icon: Icons.notes,
                maxLines: 4,
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _saveChicken,
                  child: const Text(
                    'Simpan Ayam',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Cancel Button
              if (widget.chicken != null)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.amber[700]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Batal',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
            prefixIcon: Icon(icon, color: Colors.amber[700]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
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
          'Tanggal Ditambahkan',
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
              initialDate: _selectedDate ?? DateTime.now(),
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
                Icon(Icons.calendar_today, color: Colors.amber[700]),
                const SizedBox(width: 12),
                Text(
                  _selectedDate != null
                      ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                      : 'Pilih tanggal',
                  style: TextStyle(
                    fontSize: 14,
                    color: _selectedDate != null ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Status',
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
            value: _selectedStatus,
            isExpanded: true,
            underline: const SizedBox(),
            items: [
              DropdownMenuItem(
                value: 'active',
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('Aktif'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'sick',
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('Sakit'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'sold',
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('Terjual'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'dead',
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('Mati'),
                  ],
                ),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedStatus = value ?? 'active';
              });
            },
          ),
        ),
      ],
    );
  }

  void _saveChicken() {
    if (_nameController.text.isEmpty || _breedController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan ras ayam harus diisi')),
      );
      return;
    }

    final weight = double.tryParse(_weightController.text) ?? 0.0;

    if (widget.chicken == null) {
      // Add new chicken
      final newChicken = Chicken(
        id: const Uuid().v4(),
        name: _nameController.text,
        breed: _breedController.text,
        currentWeight: weight,
        status: _selectedStatus,
        dateAdded: _selectedDate ?? DateTime.now(),
        notes: _notesController.text,
        eggCount: 0,
      );

      context.read<ChickenProvider>().addChicken(newChicken);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ayam berhasil ditambahkan')),
      );
    } else {
      // Update existing chicken
      final updatedChicken = widget.chicken!.copyWith(
        name: _nameController.text,
        breed: _breedController.text,
        currentWeight: weight,
        status: _selectedStatus,
        notes: _notesController.text,
      );

      context.read<ChickenProvider>().updateChicken(updatedChicken);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ayam berhasil diperbarui')),
      );
    }

    Navigator.pop(context);
  }
}

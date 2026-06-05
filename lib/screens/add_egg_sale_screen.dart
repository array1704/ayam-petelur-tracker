import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/egg_sale.dart';
import '../providers/egg_sale_provider.dart';

class AddEggSaleScreen extends StatefulWidget {
  const AddEggSaleScreen({Key? key}) : super(key: key);

  @override
  _AddEggSaleScreenState createState() => _AddEggSaleScreenState();
}

class _AddEggSaleScreenState extends State<AddEggSaleScreen> {
  late TextEditingController _quantityController;
  late TextEditingController _pricePerEggController;
  late TextEditingController _notesController;
  DateTime _selectedDate = DateTime.now();
  double _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController();
    _pricePerEggController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _pricePerEggController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _calculateTotalPrice() {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final pricePerEgg = double.tryParse(_pricePerEggController.text) ?? 0;
    setState(() {
      _totalPrice = quantity * pricePerEgg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catat Penjualan Telur'),
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
                  child: Icon(
                    Icons.attach_money,
                    size: 50,
                    color: Colors.green[700],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Date Picker
              _buildDateField(),
              const SizedBox(height: 16),

              // Quantity Field
              _buildTextField(
                controller: _quantityController,
                label: 'Jumlah Telur (butir)',
                hint: '0',
                icon: Icons.egg,
                keyboardType: TextInputType.number,
                onChanged: (_) => _calculateTotalPrice(),
              ),
              const SizedBox(height: 16),

              // Price Per Egg Field
              _buildTextField(
                controller: _pricePerEggController,
                label: 'Harga Per Telur (Rp)',
                hint: '0',
                icon: Icons.local_offer,
                keyboardType: TextInputType.number,
                onChanged: (_) => _calculateTotalPrice(),
              ),
              const SizedBox(height: 16),

              // Total Price Display
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green[300]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Harga:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Rp${_formatCurrency(_totalPrice)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Notes Field
              _buildTextField(
                controller: _notesController,
                label: 'Catatan',
                hint: 'Tambahkan catatan tentang penjualan telur',
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
                  onPressed: _saveEggSale,
                  child: const Text(
                    'Simpan Penjualan Telur',
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
    Function(String)? onChanged,
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
          onChanged: onChanged,
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
          'Tanggal Penjualan',
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

  void _saveEggSale() {
    if (_quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan jumlah telur')),
      );
      return;
    }

    if (_pricePerEggController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan harga per telur')),
      );
      return;
    }

    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final pricePerEgg = double.tryParse(_pricePerEggController.text) ?? 0;

    final eggSale = EggSale(
      id: const Uuid().v4(),
      dateSold: _selectedDate,
      quantity: quantity,
      pricePerEgg: pricePerEgg,
      totalPrice: _totalPrice,
      notes: _notesController.text,
    );

    context.read<EggSaleProvider>().addEggSale(eggSale);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Penjualan telur berhasil disimpan')),
    );

    Navigator.pop(context);
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/chicken.dart';
import '../providers/chicken_provider.dart';

class ChickenListScreen extends StatefulWidget {
  const ChickenListScreen({Key? key}) : super(key: key);

  @override
  _ChickenListScreenState createState() => _ChickenListScreenState();
}

class _ChickenListScreenState extends State<ChickenListScreen> {
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Ayam'),
        backgroundColor: Colors.amber[700],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filter Buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  _buildFilterButton('all', 'Semua'),
                  const SizedBox(width: 8),
                  _buildFilterButton('active', 'Aktif'),
                  const SizedBox(width: 8),
                  _buildFilterButton('sick', 'Sakit'),
                  const SizedBox(width: 8),
                  _buildFilterButton('sold', 'Terjual'),
                  const SizedBox(width: 8),
                  _buildFilterButton('dead', 'Mati'),
                ],
              ),
            ),
          ),
          // Chicken List
          Expanded(
            child: Consumer<ChickenProvider>(
              builder: (context, chickenProvider, _) {
                final chickens = _getFilteredChickens(chickenProvider.chickens);

                if (chickens.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chicken_meat,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada ayam terdaftar',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: chickens.length,
                  itemBuilder: (context, index) {
                    final chicken = chickens[index];
                    return _buildChickenCard(chicken, context);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[700],
        onPressed: () {
          Navigator.pushNamed(context, '/add_chicken');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterButton(String value, String label) {
    final isSelected = _selectedFilter == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber[700] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  List<Chicken> _getFilteredChickens(List<Chicken> chickens) {
    if (_selectedFilter == 'all') {
      return chickens;
    }
    return chickens.where((c) => c.status == _selectedFilter).toList();
  }

  Widget _buildChickenCard(Chicken chicken, BuildContext context) {
    final daysOwned = DateTime.now().difference(chicken.dateAdded).inDays;
    final statusColor = _getStatusColor(chicken.status);

    return GestureDetector(
      onTap: () {
        // Navigate to chicken detail screen
        Navigator.pushNamed(context, '/chicken_detail', arguments: chicken);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Chicken Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.chicken_meat,
                  size: 32,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(width: 16),
              // Chicken Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            chicken.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getStatusLabel(chicken.status),
                            style: TextStyle(
                              fontSize: 12,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          chicken.breed,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${daysOwned} hari',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoChip(
                            icon: Icons.scale,
                            label: '${chicken.currentWeight.toStringAsFixed(1)} kg',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildInfoChip(
                            icon: Icons.egg,
                            label: '${chicken.eggCount} telur',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // More Options
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text('Edit'),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/add_chicken',
                        arguments: chicken,
                      );
                    },
                  ),
                  PopupMenuItem(
                    child: const Text('Hapus'),
                    onTap: () {
                      _showDeleteConfirmation(context, chicken);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'sick':
        return Colors.orange;
      case 'sold':
        return Colors.blue;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'active':
        return 'Aktif';
      case 'sick':
        return 'Sakit';
      case 'sold':
        return 'Terjual';
      case 'dead':
        return 'Mati';
      default:
        return status;
    }
  }

  void _showDeleteConfirmation(BuildContext context, Chicken chicken) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Ayam'),
          content: Text('Yakin ingin menghapus ${chicken.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                context.read<ChickenProvider>().deleteChicken(chicken.id);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ayam berhasil dihapus')),
                );
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

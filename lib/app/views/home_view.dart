import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.appTitle.value)),
        actions: [IconButton(onPressed: controller.navigateToSobre, icon: const Icon(Icons.info_outline))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo/Ícone principal
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(60)),
              child: Icon(Icons.lightbulb_outline, size: 60, color: Theme.of(context).colorScheme.primary),
            ),

            const SizedBox(height: 32),

            // Título de boas-vindas
            Text(
              'Bem-vindo ao Minhas Ideias',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Subtítulo
            Text(
              'O lugar perfeito para registrar e organizar suas ideias criativas',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 48),

            // Botões principais
            _buildActionButton(
              context: context,
              icon: Icons.add_circle_outline,
              title: 'Nova Ideia',
              subtitle: 'Registre uma nova ideia',
              color: Theme.of(context).colorScheme.primary,
              onPressed: controller.navigateToRegistroIdeia,
            ),

            const SizedBox(height: 16),

            _buildActionButton(
              context: context,
              icon: Icons.list_alt,
              title: 'Minhas Ideias',
              subtitle: 'Visualize suas ideias registradas',
              color: Theme.of(context).colorScheme.secondary,
              onPressed: controller.navigateToListaIdeias,
            ),

            const SizedBox(height: 48),

            // Estatísticas rápidas
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat(context: context, icon: Icons.lightbulb, count: '3', label: 'Ideias'),
                  _buildStat(context: context, icon: Icons.category, count: '3', label: 'Categorias'),
                  _buildStat(context: context, icon: Icons.star, count: '2', label: 'Favoritas'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.white),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9))),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStat({required BuildContext context, required IconData icon, required String count, required String label}) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
        const SizedBox(height: 8),
        Text(
          count,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

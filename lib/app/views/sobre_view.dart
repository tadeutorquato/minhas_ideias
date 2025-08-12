import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sobre_controller.dart';

class SobreView extends GetView<SobreController> {
  const SobreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre'), leading: IconButton(onPressed: controller.goBack, icon: const Icon(Icons.arrow_back))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo/Ícone do app
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.lightbulb, size: 50, color: Theme.of(context).colorScheme.primary),
            ),

            const SizedBox(height: 24),

            // Nome do app
            Text(
              'Minhas Ideias',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
            ),

            const SizedBox(height: 8),

            // Versão
            Obx(
              () => Text(
                'Versão ${controller.appVersion.value}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
              ),
            ),

            const SizedBox(height: 24),

            // Descrição
            Obx(() => Text(controller.appDescription.value, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center)),

            const SizedBox(height: 32),

            // Funcionalidades
            _buildSection(
              context: context,
              title: 'Funcionalidades',
              child: Column(
                children:
                    controller.features.map((feature) {
                      return _buildFeatureItem(context: context, title: feature['title']!, description: feature['description']!);
                    }).toList(),
              ),
            ),

            const SizedBox(height: 32),

            // Informações técnicas
            _buildSection(
              context: context,
              title: 'Informações Técnicas',
              child: Column(
                children: [
                  _buildInfoRow(context: context, icon: Icons.phone_android, label: 'Plataforma', value: 'Android'),
                  _buildInfoRow(context: context, icon: Icons.code, label: 'Framework', value: 'Flutter'),
                  _buildInfoRow(context: context, icon: Icons.architecture, label: 'Arquitetura', value: 'MVC com GetX'),
                  _buildInfoRow(context: context, icon: Icons.palette, label: 'Design', value: 'Material Design 3'),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Desenvolvedor
            _buildSection(
              context: context,
              title: 'Desenvolvedor',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red[400], size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Obx(
                        () => Text(
                          controller.developerName.value,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Agradecimentos
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  Icon(Icons.star, color: Colors.amber[600], size: 32),
                  const SizedBox(height: 12),
                  Text(
                    'Obrigado por usar o Minhas Ideias!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Esperamos que este app ajude você a organizar e dar vida às suas ideias mais criativas.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required BuildContext context, required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  Widget _buildFeatureItem({required BuildContext context, required String title, required String description}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required BuildContext context, required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Text('$label:', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

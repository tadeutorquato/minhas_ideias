import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lista_ideias_controller.dart';
import '../models/ideia_model.dart';

class ListaIdeiasView extends GetView<ListaIdeiasController> {
  const ListaIdeiasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Ideias'),
        leading: IconButton(onPressed: controller.goBack, icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(onPressed: controller.carregarIdeias, icon: const Icon(Icons.refresh), tooltip: 'Atualizar'),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'limpar') {
                _showClearConfirmation(context);
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem<String>(
                    value: 'limpar',
                    child: Row(children: [Icon(Icons.clear_all, color: Colors.red), SizedBox(width: 8), Text('Limpar todas as ideias')]),
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de pesquisa e filtros
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              children: [
                // Campo de pesquisa
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Pesquisar ideias...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: Obx(
                      () =>
                          controller.searchQuery.value.isNotEmpty
                              ? IconButton(onPressed: () => controller.setSearchQuery(''), icon: const Icon(Icons.clear))
                              : const SizedBox.shrink(),
                    ),
                  ),
                  onChanged: controller.setSearchQuery,
                ),

                const SizedBox(height: 12),

                // Filtro por categoria
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => Row(
                      children:
                          controller.filtros.map((filtro) {
                            final isSelected = controller.selectedFilter.value == filtro;
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(filtro),
                                selected: isSelected,
                                onSelected: (_) => controller.setFilter(filtro),
                                selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                checkmarkColor: Theme.of(context).colorScheme.primary,
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Lista de ideias
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.ideiasFiltered.isEmpty) {
                return _buildEmptyState(context);
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: controller.ideiasFiltered.length,
                itemBuilder: (context, index) {
                  final ideia = controller.ideiasFiltered[index];
                  return _buildIdeiaCard(context, ideia);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.navigateToRegistroIdeia,
        tooltip: 'Nova Ideia',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lightbulb_outline, size: 64, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4)),
              const SizedBox(height: 16),
              Text(
                'Nenhuma ideia encontrada',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
              ),
              const SizedBox(height: 8),
              Text(
                'Que tal registrar sua primeira ideia?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(onPressed: controller.navigateToRegistroIdeia, icon: const Icon(Icons.add), label: const Text('Nova Ideia')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIdeiaCard(BuildContext context, IdeiaModel ideia) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showIdeiaDetails(context, ideia),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header com título e prioridade
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(ideia.titulo, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
                  const SizedBox(width: 8),
                  _buildPrioridadeChip(context, ideia.prioridade),
                ],
              ),

              const SizedBox(height: 8),

              // Descrição
              Text(
                ideia.descricao,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              // Footer com categoria, data e ações
              Row(
                children: [
                  // Categoria
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.category, size: 14, color: Theme.of(context).colorScheme.secondary),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              ideia.categoria,
                              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Data
                  Flexible(
                    child: Text(
                      _formatDate(ideia.dataCreacao),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const Spacer(),

                  // Botão de deletar
                  IconButton(
                    onPressed: () => _showDeleteConfirmation(context, ideia),
                    icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error, size: 20),
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrioridadeChip(BuildContext context, int prioridade) {
    Color color;
    String label;

    switch (prioridade) {
      case 1:
        color = Colors.grey;
        label = 'Baixa';
        break;
      case 2:
        color = Colors.blue[300]!;
        label = 'Baixa-Média';
        break;
      case 3:
        color = Colors.orange[300]!;
        label = 'Média';
        break;
      case 4:
        color = Colors.orange[600]!;
        label = 'Alta-Média';
        break;
      case 5:
        color = Colors.red[400]!;
        label = 'Alta';
        break;
      default:
        color = Colors.grey;
        label = 'Média';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: color)),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Hoje';
    } else if (difference == 1) {
      return 'Ontem';
    } else if (difference < 7) {
      return '$difference dias atrás';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showIdeiaDetails(BuildContext context, IdeiaModel ideia) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            maxChildSize: 0.9,
            minChildSize: 0.5,
            expand: false,
            builder:
                (context, scrollController) => Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Handle
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Título
                        Text(ideia.titulo, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),

                        const SizedBox(height: 16),

                        // Informações
                        Row(
                          children: [
                            _buildPrioridadeChip(context, ideia.prioridade),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                ideia.categoria,
                                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Data
                        Text(
                          'Criada em ${_formatDate(ideia.dataCreacao)}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                        ),

                        const SizedBox(height: 24),

                        // Descrição
                        Text('Descrição', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(ideia.descricao, style: Theme.of(context).textTheme.bodyMedium),

                        const SizedBox(height: 32),

                        // Botões
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _showDeleteConfirmation(context, ideia);
                                },
                                icon: const Icon(Icons.delete_outline),
                                label: const Text('Excluir'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Theme.of(context).colorScheme.error,
                                  side: BorderSide(color: Theme.of(context).colorScheme.error),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close),
                                label: const Text('Fechar'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, IdeiaModel ideia) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirmar Exclusão'),
            content: Text('Tem certeza que deseja excluir a ideia "${ideia.titulo}"?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.deleteIdeia(ideia.id);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
                child: const Text('Excluir'),
              ),
            ],
          ),
    );
  }

  void _showClearConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Limpar Todas as Ideias'),
            content: const Text('Tem certeza que deseja remover TODAS as ideias?\n\nEsta ação não pode ser desfeita!'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.limparTodasIdeias();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
                child: const Text('Limpar Tudo'),
              ),
            ],
          ),
    );
  }
}

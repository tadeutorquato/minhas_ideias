import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/registro_ideia_controller.dart';

class RegistroIdeiaView extends GetView<RegistroIdeiaController> {
  const RegistroIdeiaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Ideia'),
        leading: IconButton(onPressed: controller.goBack, icon: const Icon(Icons.arrow_back)),
        actions: [IconButton(onPressed: controller.limparFormulario, icon: const Icon(Icons.refresh), tooltip: 'Limpar formulário')],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Theme.of(context).colorScheme.primary, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Registre sua nova ideia e dê o primeiro passo para torná-la realidade!',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Campo Título
              Text('Título da Ideia', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.tituloController,
                decoration: const InputDecoration(hintText: 'Ex: App para organizar receitas', prefixIcon: Icon(Icons.title)),
                validator: controller.validateTitulo,
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: 24),

              // Campo Descrição
              Text('Descrição', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.descricaoController,
                decoration: const InputDecoration(hintText: 'Descreva sua ideia em detalhes...', prefixIcon: Icon(Icons.description)),
                validator: controller.validateDescricao,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: 24),

              // Categoria
              Text('Categoria', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedCategoria.value,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      items:
                          controller.categorias.map((String categoria) {
                            return DropdownMenuItem<String>(
                              value: categoria,
                              child: Row(
                                children: [
                                  Icon(Icons.category, size: 20, color: Theme.of(context).colorScheme.primary),
                                  const SizedBox(width: 12),
                                  Text(categoria),
                                ],
                              ),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.setCategoria(newValue);
                        }
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Prioridade
              Text('Prioridade', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Obx(
                () => Column(
                  children:
                      controller.prioridades.map((prioridade) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: RadioListTile<int>(
                            value: prioridade['value'],
                            groupValue: controller.selectedPrioridade.value,
                            onChanged: (int? value) {
                              if (value != null) {
                                controller.setPrioridade(value);
                              }
                            },
                            title: Text(prioridade['label']),
                            subtitle: Text(
                              _getPrioridadeDescription(prioridade['value']),
                              style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), fontSize: 12),
                            ),
                            activeColor: prioridade['color'],
                            tileColor: controller.selectedPrioridade.value == prioridade['value'] ? prioridade['color'].withOpacity(0.1) : null,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        );
                      }).toList(),
                ),
              ),

              const SizedBox(height: 32),

              // Botão Salvar
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.salvarIdeia,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child:
                        controller.isLoading.value
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            )
                            : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.save),
                                SizedBox(width: 8),
                                Text('Salvar Ideia', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ],
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

  String _getPrioridadeDescription(int prioridade) {
    switch (prioridade) {
      case 1:
        return 'Para ideias que podem ser desenvolvidas futuramente';
      case 2:
        return 'Ideias interessantes com potencial médio';
      case 3:
        return 'Ideias com bom potencial de implementação';
      case 4:
        return 'Ideias importantes que devem ser priorizadas';
      case 5:
        return 'Ideias urgentes e de alto impacto';
      default:
        return '';
    }
  }
}

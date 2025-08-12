# 💡 Minhas Ideias

**Um aplicativo Flutter elegante e profissional para registrar e organizar suas ideias criativas com persistência local.**

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" />
  <img src="https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white" />
</p>

## 📱 Sobre o Projeto

O **Minhas Ideias** é um aplicativo multiplataforma desenvolvido em Flutter que utiliza o framework GetX para gerenciamento de estado, rotas e dependências, e **Hive** para persistência local de dados. Suas ideias ficam sempre seguras no seu dispositivo, mesmo sem internet.

## ✨ Funcionalidades

- **🏠 Tela Inicial**: Dashboard principal com navegação intuitiva
- **➕ Registro de Ideias**: Formulário completo para cadastrar novas ideias
- **📋 Lista de Ideias**: Visualização organizada de todas as ideias registradas
- **ℹ️ Sobre**: Informações sobre o aplicativo e suas funcionalidades
- **🔍 Busca e Filtros**: Sistema de pesquisa e filtros por categoria
- **⭐ Sistema de Prioridades**: Classificação de ideias por importância (1-5)
- **🗑️ Gerenciamento**: Visualização detalhada e exclusão de ideias
- **💾 Persistência Local**: Dados salvos localmente com Hive (funciona offline)
- **🧹 Limpeza de Dados**: Opção para limpar todas as ideias registradas

## 🏗️ Arquitetura

O projeto segue o padrão **MVC (Model-View-Controller)** com as seguintes camadas:

### 📁 Estrutura de Pastas

```text
lib/
├── app/
│   ├── controllers/           # Controladores (GetX)
│   │   ├── home_controller.dart
│   │   ├── sobre_controller.dart
│   │   ├── registro_ideia_controller.dart
│   │   └── lista_ideias_controller.dart
│   ├── models/               # Modelos de dados com Hive
│   │   ├── ideia_model.dart
│   │   └── ideia_model.g.dart (gerado)
│   ├── repositories/         # Camada de acesso aos dados
│   │   └── ideia_repository.dart
│   ├── services/             # Serviços (Hive, etc.)
│   │   └── hive_service.dart
│   ├── utils/                # Utilitários e helpers
│   │   └── hive_utils.dart
│   ├── views/                # Interfaces de usuário
│   │   ├── home_view.dart
│   │   ├── sobre_view.dart
│   │   ├── registro_ideia_view.dart
│   │   └── lista_ideias_view.dart
│   ├── routes/               # Gerenciamento de rotas
│   │   └── app_routes.dart
│   └── themes/               # Temas e estilos
│       └── app_theme.dart
└── main.dart                 # Ponto de entrada
```

## 🛠️ Tecnologias Utilizadas

### **Framework & Linguagem**
- **Flutter**: Framework de desenvolvimento multiplataforma
- **Dart**: Linguagem de programação

### **Gerenciamento de Estado**
- **GetX**: Gerenciamento de estado, rotas e dependências

### **Persistência de Dados**
- **Hive**: Banco de dados NoSQL local e rápido
- **Hive Flutter**: Integração do Hive com Flutter
- **Path Provider**: Acesso aos diretórios do sistema

### **Desenvolvimento**
- **Hive Generator**: Geração automática de adapters
- **Build Runner**: Ferramenta de build

### **Design**
- **Material Design 3**: Sistema de design moderno e elegante

## 🎨 Design

O aplicativo utiliza um tema profissional e elegante com:

- **Cores Primárias**: Azul profissional (#1E3A8A)
- **Cores Secundárias**: Azul claro (#3B82F6)
- **Cor de Destaque**: Verde elegante (#10B981)
- **Tipografia**: Hierarquia clara e legível
- **Componentes**: Material Design 3 com bordas arredondadas
- **Layout**: Responsivo e intuitivo

## 🚀 Como Executar

1. **Pré-requisitos**:
   - Flutter SDK (versão 3.x ou superior)
   - Android Studio ou VS Code
   - Emulador Android ou dispositivo físico

2. **Instalação**:

   ```bash
   git clone https://github.com/tadeutorquato/minhas_ideias.git
   cd minhas_ideias
   flutter pub get
   dart run build_runner build
   ```

3. **Execução**:

   ```bash
   flutter run
   ```

## 📋 Funcionalidades Detalhadas

### 🏠 Tela Inicial (Home)

- Dashboard com botões de ação principais
- Estatísticas rápidas das ideias
- Navegação para outras telas
- Design acolhedor e profissional

### ➕ Registro de Ideias

- **Título**: Campo obrigatório com validação
- **Descrição**: Texto detalhado da ideia
- **Categoria**: Seleção entre 8 categorias predefinidas
- **Prioridade**: Sistema de 1 a 5 estrelas
- **Validações**: Formulário com validação completa
- **Feedback**: Mensagens de sucesso/erro

### 📋 Lista de Ideias

- **Busca**: Campo de pesquisa por título/descrição
- **Filtros**: Filtros por categoria com chips
- **Ordenação**: Por prioridade e data de criação
- **Cards**: Design elegante com informações resumidas
- **Detalhes**: Modal com informações completas
- **Ações**: Visualização e exclusão de ideias

### ℹ️ Sobre

- Informações do aplicativo
- Lista de funcionalidades
- Detalhes técnicos
- Créditos de desenvolvimento

## 🎯 Categorias Disponíveis

- **Geral**: Ideias diversas
- **Trabalho**: Projetos profissionais
- **Pessoal**: Ideias pessoais
- **Criativo**: Projetos artísticos
- **Tecnologia**: Inovações tecnológicas
- **Negócios**: Oportunidades de negócio
- **Estudo**: Ideias acadêmicas
- **Outros**: Categorias não especificadas

## 🔧 Próximas Melhorias

- [x] **Persistência local com Hive** ✅
- [ ] Backup na nuvem
- [ ] Notificações para ideias importantes
- [ ] Compartilhamento de ideias
- [ ] Modo escuro
- [ ] Exportação para PDF
- [ ] Sistema de tags
- [ ] Calendário de implementação
- [ ] Sincronização entre dispositivos

## 👨‍💻 Desenvolvimento

Desenvolvido com ❤️ utilizando as melhores práticas de:

- **Clean Code**: Código limpo e bem documentado
- **SOLID**: Princípios de programação orientada a objetos
- **DRY**: Evitando repetição de código
- **Responsividade**: Design adaptável
- **UX/UI**: Experiência do usuário intuitiva

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

---

## 👨‍💻 Autor

**Tadeu Torquato**
- GitHub: [@tadeutorquato](https://github.com/tadeutorquato)

---

**Minhas Ideias** - Dando vida às suas ideias mais criativas! 💡

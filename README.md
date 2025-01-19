# TODO List Application

Bem-vindo à documentação da aplicação TODO List, uma solução desenvolvida utilizando Flutter com SQLite e `Provider`. Este projeto é estruturado no padrão arquitetural MVVM, aprimorado com uma camada de serviços para regras de negócio. Aqui, abordaremos as responsabilidades das classes principais, o uso do `Provider`, os módulos organizacionais e exemplos técnicos.

---

## 🚀 Estrutura do Projeto

### 📂 Arquitetura MVVM com Camada de Serviços

A arquitetura MVVM (Model-View-ViewModel) organiza a aplicação em três camadas principais:

- **Model**: Representa os dados e entidades do sistema, como tarefas e filtros. Inclui métodos para carregar dados do banco de dados.
- **ViewModel**: Intermedia a View e o Model, fornecendo dados já preparados para exibição e gerenciando a lógica de interação.
- **View**: Responsável pela interface do usuário, consumindo o `ViewModel` para exibir dados e reagir às interações.

Adicionalmente, foi incluída uma **camada de serviços** que contém as regras de negócio da aplicação. Essa camada isola as responsabilidades, deixando o repository focado exclusivamente em interações com fontes externas (ex.: banco de dados SQLite e Firebase).

---

## 🌟 Uso do Provider

O `Provider` é usado para gerenciar estado e injeção de dependências em toda a aplicação. Ele facilita o compartilhamento de instâncias do ViewModel e de serviços entre diferentes partes do aplicativo, mantendo a separação de responsabilidades.

### Exemplo:
```dart
ChangeNotifierProvider(
  create: (_) => TaskViewModel(),
  child: TaskPage(),
)
```

No exemplo acima, o `TaskViewModel` é disponibilizado para a página `TaskPage` e seus descendentes.

---

## 📂 Estrutura de Módulos

A aplicação está dividida em módulos para melhorar a organização e facilitar a escalabilidade. Cada módulo segue a estrutura:

- **Pages**: Contém as telas (Views).
- **ViewModels**: Gerencia o estado e lógica para as páginas.
- **Services**: Regras de negócio.
- **Repositories**: Interações com fontes de dados externas, como o SQLite e Firebase.

---

## 📦 Classes e Responsabilidades

### **1. Modelos**

#### TaskModel
Representa uma tarefa no sistema, incluindo informações como título, descrição, data e status de conclusão.
```dart
class TaskModel {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,
  });

  factory TaskModel.loadFromDB(Map<String, dynamic> task) {
    return TaskModel(
      id: task['id'],
      title: task['title'],
      description: task['description'],
      date: DateTime.parse(task['date_time']),
      isDone: task['done'] == 1,
    );
  }
}
```

Responsabilidade: Modelar os dados de uma tarefa e fornecer métodos utilitários como `loadFromDB`.

---

#### TaskFilterEnum
Enumeração que define os filtros disponíveis para as tarefas.
```dart
enum TaskFilterEnum {
  today,
  tomorrow,
  week,
}

extension TaskFilterTitle on TaskFilterEnum {
  String get period {
    switch (this) {
      case TaskFilterEnum.today:
        return 'DE HOJE';
      case TaskFilterEnum.tomorrow:
        return 'DE AMANHÃ';
      case TaskFilterEnum.week:
        return 'DA SEMANA';
    }
  }
}
```

Responsabilidade: Definir e traduzir filtros para uso no aplicativo.

---

#### WeekTaskModel e MonthTaskModel
Modelos que agregam listas de tarefas por semana ou mês, com datas de início e fim.
```dart
class WeekTaskModel {
  final DateTime startDate;
  final DateTime endDate;
  final List<TaskModel> tasks;

  WeekTaskModel({
    required this.startDate,
    required this.endDate,
    required this.tasks,
  });
}
```

Responsabilidade: Facilitar o agrupamento e manipulação de tarefas em períodos específicos.

---

#### TotalTaskModel
Modela o total de tarefas e as concluídas.
```dart
class TotalTaskModel {
  final int totalTasks;
  final int totalTasksDone;

  TotalTaskModel({
    required this.totalTasks,
    required this.totalTasksDone,
  });
}
```

Responsabilidade: Fornecer estatísticas consolidadas.

---

### **2. Serviços**

#### TaskServiceImpl
Contém as regras de negócio relacionadas às tarefas.
- Validações.
- Agrupamento de tarefas por período.
- Comunicação com o repositório.

---

### **3. Repositórios**

#### TaskRepositoryImpl
Lida com a persistência de dados no SQLite.
- Salvar, atualizar, deletar e buscar tarefas.

---

### **4. ViewModels**

#### TaskViewModel
Gerencia o estado das tarefas filtradas e eventos da interface do usuário.

---

## 📋 Exemplos Técnicos

### Gerenciamento de Estado com Provider
```dart
class TaskViewModel extends ChangeNotifier {
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  void loadTasks() {
    // Carregar tarefas e notificar listeners
    _tasks = ...;
    notifyListeners();
  }
}
```

### Exemplo de Filtro
```dart
List<TaskModel> filterTasks(TaskFilterEnum filter) {
  switch (filter) {
    case TaskFilterEnum.today:
      return tasks.where((task) => task.date == DateTime.now()).toList();
    case TaskFilterEnum.week:
      // Lógica para filtrar por semana
  }
}
```

---

## 🛠 Tecnologias e Pacotes Utilizados

- **Flutter**: Framework principal.
- **SQLite**: Persistência de dados.
- **Provider**: Gerenciamento de estado.
- **Firebase**: Registro e login de usuário.

---

## 📌 Conclusão

A estrutura modular e o uso do padrão MVVM, combinado com o `Provider`, tornam o projeto escalável e fácil de manter. A inclusão de uma camada de serviços melhora a organização das responsabilidades. Este README serve como referência para entender e contribuir com o projeto.

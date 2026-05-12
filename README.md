# Base App Clean Architecture

Template base para aplicações em Flutter utilizando Clean Architecture, SOLID e foco em escalabilidade, testabilidade e reutilização.

## Objetivo

Este projeto foi criado para servir como fundação para novos aplicativos Flutter, padronizando a estrutura do código e acelerando o desenvolvimento de features com uma arquitetura consistente.

A arquitetura reflete padrões e práticas que venho utilizando em projetos reais, com foco em manutenção, escalabilidade, reutilização e testabilidade, a partir de necessidades concretas de:

- Manutenção de longo prazo
- Reutilização de componentes
- Escalabilidade do código
- Testabilidade

## Tecnologias e Conceitos

- Flutter
- Dart
- Cubit
- GetIt
- GoRouter
- Clean Architecture
- SOLID
- Testes unitários

## Estrutura Arquitetural

```text
lib/
├── core/           # Componentes compartilhados (erros, utilitários, tema, serviços e clients)
├── data/           # Models, mappers, datasources e implementações de repositórios
├── domain/         # Entities, enums, contratos de repositórios e use cases
├── presenter/      # Pages, components, gerenciadores de estado (Cubit/BLoC) e modules para injeção de dependência
└── main.dart       # Ponto de entrada da aplicação
```

## Fluxo de Dependências

```text
Presentation → Domain → Data
```

- **Presentation**: Interface do usuário e gerenciamento de estado.
- **Domain**: Regras de negócio e contratos.
- **Data**: Implementação de acesso a dados.

## Benefícios da Arquitetura

- Alta coesão e baixo acoplamento
- Facilidade para manutenção
- Reutilização entre projetos
- Escalabilidade
- Testabilidade
- Padronização

## Como Utilizar

1. Clone o repositório:

```bash
git clone https://github.com/marcio-diniz/base_app_clean_arch.git
```

2. Instale as dependências:

```bash
flutter pub get
```

3. Execute o projeto:

```bash
flutter run
```

## Quando Utilizar

Esta arquitetura é especialmente útil para:

- Aplicações de médio e grande porte
- Projetos com múltiplas features
- Times com mais de um desenvolvedor
- Produtos com evolução contínua

Para aplicativos muito simples, uma estrutura mais enxuta pode ser suficiente.

## Filosofia do Projeto

O objetivo não é aplicar padrões por obrigação, mas utilizá-los quando agregam valor real ao projeto.

A arquitetura foi construída com foco em pragmatismo, equilibrando:

- Organização
- Simplicidade
- Reutilização
- Produtividade

## Autor

Desenvolvido por Marcio Diniz.

- GitHub: https://github.com/marcio-diniz

# urbandrive_dart
Urban Drive é um aplicativo de locação de carros desenvolvido com Flutter. O objetivo do aplicativo é permitir que os usuários aluguem carros de forma prática e rápida, sem a necessidade de filas ou papelada, diretamente pelo celular.

Funcionalidades
Registro e Login: Os usuários podem criar uma conta ou fazer login para acessar o aplicativo.
Locação de Carros: Alugue carros por algumas horas, dias ou por quanto tempo precisar.
Busca por Carros Próximos: Encontre o carro mais próximo disponível para locação.
Abertura de Carro via Celular: Após a locação, o usuário pode abrir o carro pelo celular.
Interface Intuitiva: Uma interface amigável que facilita a navegação e o uso do aplicativo.

Tecnologias Utilizadas
Flutter: Para o desenvolvimento da interface do usuário e lógica de negócios.
Dart: Linguagem de programação utilizada com Flutter.
Node.js (API Backend): O backend foi desenvolvido utilizando Node.js para o gerenciamento de usuários e locação.
API REST: Comunicação entre o frontend e o backend via chamadas RESTful.
Git: Controle de versão do código-fonte.
Estrutura do Projeto

lib/
│
├── assets/                     # Imagens e ícones do projeto
│   ├── icons/                  # Ícones em SVG
│   └── img/                    # Imagens utilizadas nas telas
│
├── config/                     # Configurações e comunicação com a API
│   └── api_service.dart        # Serviço para comunicação com o backend
│
├── data/                       # Modelos de dados
│   └── models/                 # Definições dos modelos de dados (User, Car, etc.)
│
├── presentation/               # Camada de apresentação (telas e widgets)
│   ├── screens/                # Telas principais do app (login, registro, home)
│   └── widgets/                # Widgets reutilizáveis (botões, cartões, etc.)
│
└── utils/                      # Utilidades como cores e constantes globais
└── constants/              # Definição de cores, estilos e textos
└── appcolors.dart      # Paleta de cores do projeto

Instalação

Clone o repositório:
git clone https://github.com/lucax011/urbandrive_dart.git
Navegue até o diretório do projeto:


cd urbandrive_dart
Instale as dependências do Flutter:


flutter pub get
Execute o aplicativo:


flutter run
Configuração de Assets
Certifique-se de que os assets (imagens e ícones) estão corretamente definidos no arquivo pubspec.yaml:

flutter:
assets:
- assets/images/
- assets/icons/


Gerenciamento de Estado

O gerenciamento de estado no Urban Drive é feito através de Provider (ou outro método que você utilize, como GetX, Riverpod, etc.). Certifique-se de adicionar as dependências adequadas no arquivo pubspec.yaml.
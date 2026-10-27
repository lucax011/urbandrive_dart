# Urban Drive (Flutter)

App de aluguel de carros: o usuário encontra o carro mais próximo no mapa e aluga por algumas horas ou dias, sem fila nem papelada, direto pelo celular.

Versões e serviços relacionados:
- [api-carRental](https://github.com/lucax011/api-carRental): API em Node.js + MySQL que este app consome
- [UrbanDrive](https://github.com/lucax011/UrbanDrive): versão Android nativa em Kotlin

## Funcionalidades

- Cadastro e login de usuários
- Mapa com os carros disponíveis por perto (Google Maps)
- Solicitação de carro para aluguel

## Stack

- Flutter 3 / Dart 3.5
- `google_maps_flutter`, `http` e `flutter_svg`
- Backend REST em Node.js ([api-carRental](https://github.com/lucax011/api-carRental))

## Como rodar

Pré-requisitos: Flutter SDK, um emulador Android e a [api-carRental](https://github.com/lucax011/api-carRental) rodando na porta 3000.

1. Crie uma chave da **Maps SDK for Android** no Google Cloud e adicione ao arquivo `android/local.properties` (já ignorado pelo git):
   ```properties
   MAPS_API_KEY=sua_chave_aqui
   ```
2. Rode o app:
   ```bash
   flutter pub get
   flutter run
   ```

O app acessa a API em `http://10.0.2.2:3000/`, que é o endereço do seu computador visto pelo emulador Android (`lib/config/api_service.dart`).

## Estrutura

```
lib/
  config/         comunicação com a API
  data/models/    modelos User e Car
  presentation/   telas: login, cadastro, mapa e solicitação de carro
  utils/          cores e constantes
```

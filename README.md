# Máquina de Turing
Esse repositório contém uma implementação da Máquina de Turing feita em linguagem Dart e exibida graficamente com Flutter.

Feito por Gustavo Alba e Paulo Oyama para a disciplina de Teoria da Computação na Universidade Federal de Uberlândia.

O resultado final pode ser visualizado no seguinte [link](https://turing.alba.dev)

## Execução
O Flutter pode ser instalado seguindo a documentação oficial: https://docs.flutter.dev/get-started/install

Após isso, basta rodar o seguinte comando para baixar as dependências:
```
flutter pub get
```

E para rodar o projeto:
```
flutter run
```
selecionando para qual plataforma(mobile, web ou desktop) deseja rodar

## Funcionamento
Na aplicação, as máquinas de Turing estão representadas dentro do arquivo `turing_machines.json` nos assets do projeto(`/assets/jsons`). Nesse arquivo terá uma lista de objetos semelhantes ao abaixo, para representar a máquina de Turing:
```json
{
    "name": "Máquina de Turing  - Slide MT",
    "description": "Subtracao 0ˆm10ˆn, o número de 0's expressa a diferença m com n, se n > m retorne 0",
    "states": [
      "q0", "q1","q2", "q3","q4", "q5", "q6"
    ],
    "alphabet": [
      "0", "1", "B"
    ],
    "tapeSymbols": [
      "0", "1", "B"
    ],
    "initialState": "q0",
    "blankState": "B",
    "finalStates": [
      "q6"
    ],
    "transitions": [
      {
        "readSymbol": "0",
        "currentState": "q0",
        "movementDirection": "right",
        "nextState": "q1",
        "writtenSymbol": "B"
      },
      {
        "readSymbol": "1",
        "currentState": "q0",
        "movementDirection": "right",
        "nextState": "q5",
        "writtenSymbol": "B"
      }
      // ...
    ]
  }
```

Assim, para adicionar novas máquinas de Turing, basta editar o arquivo `turing_machines.json`, inserindo a nova máquina.

## Usando a Aplicação

Dentro do programa, será possível ter essas cadeias listadas:
![Lista de Máquinas](/docs/machines_list.png)

Após selecionar a máquina desejada, pode-se colocar a cadeia a ser executada:
![Entrada da Cadeia](/docs/machine_input.png)

Com isso, têm-se a tela de execução da máquina, onde pode-se:
- Começar a execução automática
- Alterar a velocidade de execução
- Executar passo a passo
- Reiniciar a máquina
- Ver detalhes da máquina escolhida

![Execução de um Máquina](/docs/execution.gif)
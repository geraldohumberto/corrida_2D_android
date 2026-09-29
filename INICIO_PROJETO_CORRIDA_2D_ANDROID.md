# Projeto de Corrida e Combate 2D para Android

## Instrução principal para o Codex no VS Code

Quero iniciar um jogo original de corrida e combate em 2D, com visual retrô em pixel art e pistas montadas por mosaicos (*tiles*). O jogo deve ser desenvolvido no Godot usando GDScript e preparado para funcionar no Windows durante o desenvolvimento e no Android como plataforma principal.

Leia este documento inteiro antes de alterar arquivos. Primeiro inspecione a pasta aberta no VS Code e verifique quais ferramentas estão instaladas. Depois apresente resumidamente o que encontrou e comece a implementar o primeiro protótipo funcional. Não copie código, personagens, músicas, pistas, nomes, logotipos ou artes de Heavy Metal Racing, Heavy Metal Machines, Rock n’ Roll Racing ou qualquer outro jogo. Eles são apenas referências gerais de gênero.

## Visão do jogo

- Gênero: corrida arcade com combate entre veículos.
- Gráfico: 2D em pixel art.
- Câmera: vista de cima acompanhando o carro.
- Orientação no Android: horizontal (*landscape*).
- Cenário: pistas construídas com `TileMapLayer`/`TileSet`.
- Tema: veículos armados, metal, velocidade e ambiente pós-apocalíptico.
- Nome: ainda não definido; utilizar provisoriamente `Projeto Corrida Metal 2D` somente durante o desenvolvimento.
- Plataforma principal: Android.
- Plataforma de teste: Windows.
- Motor: versão estável do Godot, edição Standard, sem .NET.
- Linguagem: GDScript.

## Estratégia de desenvolvimento

Desenvolver primeiro uma versão offline pequena e jogável. Não começar pelo multiplayer. A física e os controles precisam funcionar bem antes de adicionar rede.

Ordem planejada:

1. Protótipo offline com um carro e uma pista.
2. Voltas, cronômetro, colisões e interface.
3. Adversário controlado pelo computador.
4. Armas, energia e danos.
5. Seleção de carros e pistas.
6. Multiplayer local para testes.
7. Salas e multiplayer pela internet.
8. Exportação final e preparação para publicação.

## Primeira entrega: MVP offline

Criar uma primeira versão que possua:

- uma pista simples fechada;
- carro controlado pelo jogador;
- aceleração progressiva;
- frenagem e marcha a ré;
- direção para esquerda e direita;
- atrito/desaceleração quando o jogador soltar o acelerador;
- derrapagem arcade leve;
- colisão com os limites da pista;
- câmera seguindo o carro;
- linha de largada e chegada;
- contador de três voltas;
- cronômetro da corrida;
- botão para reiniciar;
- controles por teclado no Windows;
- controles touchscreen no Android;
- interface ajustada para diferentes resoluções horizontais.

## Controles

### Windows

- `W` ou seta para cima: acelerar.
- `S` ou seta para baixo: frear/marcha a ré.
- `A` ou seta para esquerda: virar à esquerda.
- `D` ou seta para direita: virar à direita.
- `R`: reiniciar a corrida.

### Android

- lado esquerdo: botões de virar para esquerda e direita;
- lado direito: acelerar e frear;
- botões grandes, semitransparentes e adequados para toque;
- permitir que direção e aceleração sejam pressionadas simultaneamente;
- manter espaço reservado para um futuro botão de arma.

## Arte provisória

Enquanto não houver arte definitiva, criar elementos provisórios originais e simples:

- carro representado por sprite básico ou forma desenhada no próprio projeto;
- pista formada por tiles simples de asfalto, borda e terreno;
- cores com bom contraste;
- resolução-base adequada para pixel art;
- filtros de textura configurados para preservar pixels nítidos.

Não buscar nem incorporar recursos protegidos de outros jogos. Se algum recurso externo gratuito for proposto futuramente, apresentar a origem e a licença antes de incorporá-lo.

## Estrutura sugerida

```text
res://
├── assets/
│   ├── audio/
│   ├── fonts/
│   ├── sprites/
│   └── tilesets/
├── scenes/
│   ├── cars/
│   ├── tracks/
│   ├── ui/
│   └── main.tscn
├── scripts/
│   ├── car/
│   ├── race/
│   └── ui/
├── project.godot
└── README.md
```

A estrutura poderá ser ajustada se houver uma justificativa técnica clara. Manter cenas e scripts pequenos e organizados. Evitar concentrar toda a lógica em um único arquivo.

## Configuração para Android

Preparar o projeto para exportação Android, mas não armazenar senhas, chaves de assinatura ou dados pessoais no repositório.

Verificar e orientar a configuração de:

- Export Templates compatíveis com a versão instalada do Godot;
- OpenJDK 17;
- Android SDK;
- caminho do Java SDK nas configurações do Godot;
- caminho do Android SDK nas configurações do Godot;
- preset de exportação Android;
- nome de pacote provisório, como `com.geraldohumberto.corridametal2d`;
- geração de APK de depuração para teste no celular.

Só configurar assinatura de lançamento e geração de AAB quando a versão estiver pronta para publicação.

## Multiplayer futuro

Depois que o MVP offline estiver estável, planejar multiplayer para inicialmente dois e posteriormente até quatro jogadores. A futura implementação deverá considerar servidor autoritativo, sincronização de posição, rotação, velocidade, colisões, voltas, armas e resultados.

Não adicionar multiplayer nesta primeira entrega, mas evitar uma arquitetura que torne sua inclusão desnecessariamente difícil.

## Qualidade e verificação

Antes de considerar cada etapa concluída:

- executar o projeto e verificar erros do Godot;
- confirmar que a cena principal abre corretamente;
- testar teclado e controles touchscreen;
- verificar colisões e contagem de voltas;
- informar exatamente quais arquivos foram criados ou modificados;
- explicar como executar o projeto no Godot;
- registrar limitações conhecidas e o próximo passo recomendado.

Se o executável do Godot estiver disponível pelo terminal, utilizá-lo para validar o projeto. Caso não esteja no `PATH`, localizar a instalação com segurança ou pedir ao usuário o caminho. Não presumir que uma alteração funcionou sem executar uma verificação possível.

## Git e segurança do projeto

- Inicializar Git caso a pasta ainda não seja um repositório.
- Criar `.gitignore` apropriado para Godot.
- Não apagar trabalhos existentes.
- Não executar comandos destrutivos.
- Não publicar o repositório nem torná-lo público sem autorização.
- Não armazenar senhas, tokens, keystores ou credenciais.
- Fazer mudanças em etapas pequenas e fáceis de testar.

## Primeira tarefa para executar agora

1. Inspecione a pasta e identifique se ela está vazia ou se já existe algum projeto.
2. Verifique se Godot, Git e ferramentas necessárias estão acessíveis.
3. Crie o projeto Godot organizado, caso ainda não exista.
4. Implemente o MVP offline descrito neste documento usando recursos provisórios originais.
5. Execute os testes disponíveis no Windows.
6. Entregue instruções objetivas para abrir no Godot, jogar e testar no Android.

Quando uma decisão visual ainda não estiver definida, escolha uma opção provisória simples e fácil de substituir, registre a decisão e continue o desenvolvimento.

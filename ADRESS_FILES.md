# Endereços de arquivos e ferramentas

Este documento registra onde o projeto e as ferramentas usadas nele estão neste computador. Os caminhos usam o perfil atual (`Humberto`); em outro computador eles podem mudar.

## Testar agora no PC

Para a primeira fase de testes, não é necessário instalar emulador Android.

1. Abra o Godot 4.7.2.
2. Importe ou abra `C:\Users\Humberto\Documents\corrida_2D_android\project.godot`.
3. Pressione `F6` ou `F5` para executar.
4. Use `W/A/S/D` ou as setas para dirigir e `R` para reiniciar a corrida.

O emulador Android fica para a segunda etapa, quando for necessário validar botões de toque, resolução horizontal e desempenho semelhante ao de um celular.

## Emulador Android no PC

O emulador foi preparado com um dispositivo virtual **Pixel 6** chamado `ProjetoCorrida_API35`, usando Android 15 / API 35 com Google APIs e arquitetura `x86_64`.

| Conteúdo | Caminho |
| --- | --- |
| Executável do emulador | `C:\Users\Humberto\AppData\Local\Android\Sdk\emulator\emulator.exe` |
| Imagem do sistema Android 35 | `C:\Users\Humberto\AppData\Local\Android\Sdk\system-images\android-35\google_apis\x86_64` |
| Configuração do Pixel virtual | `C:\Users\Humberto\.android\avd\ProjetoCorrida_API35.avd` |
| Atalho/configuração do dispositivo virtual | `C:\Users\Humberto\.android\avd\ProjetoCorrida_API35.ini` |
| Driver de aceleração instalado no SDK | `C:\Users\Humberto\AppData\Local\Android\Sdk\extras\google\Android_Emulator_Hypervisor_Driver` |

Para abrir, use o Android Studio: **More Actions > Virtual Device Manager > ProjetoCorrida_API35 > botão Play**.

Também foram criados estes atalhos na Área de Trabalho para abertura rápida:

- `Projeto Corrida Metal 2D (Godot)` — abre este projeto diretamente no editor Godot.
- `Pixel - Projeto Corrida API 35` — abre o celular virtual configurado.
- `Android Studio` — abre o Android Studio e o gerenciador de dispositivos virtuais.

O APK `build\ProjetoCorridaMetal2D-debug.apk` foi instalado no dispositivo virtual `ProjetoCorrida_API35`. Ao abrir pela primeira vez, o Android pode mostrar uma confirmação de modo tela cheia; confirme-a para continuar até a tela do jogo.

O dispositivo virtual está configurado com teclado físico ativado (`hw.keyboard=yes`). A versão atual do jogo também registra os keycodes enviados pelo Android: `W`/seta para cima acelera, `S`/seta para baixo freia ou dá ré, `A`/seta para esquerda vira à esquerda, `D`/seta para direita vira à direita e `R` reinicia a corrida. Clique uma vez na tela do jogo antes de usar o teclado para dar foco ao emulador.

O emulador, sua imagem e o driver de aceleração estão instalados e prontos. A verificação confirmou o **AEHD 2.2** ativo e utilizável. O instalador do driver permanece em `C:\Users\Humberto\AppData\Local\Android\Sdk\extras\google\Android_Emulator_Hypervisor_Driver\silent_install.bat` caso seja necessário reparar a instalação no futuro.

## Projeto

| Conteúdo | Caminho |
| --- | --- |
| Pasta principal do projeto | `C:\Users\Humberto\Documents\corrida_2D_android` |
| Configuração principal | `C:\Users\Humberto\Documents\corrida_2D_android\project.godot` |
| Cena principal | `C:\Users\Humberto\Documents\corrida_2D_android\scenes\main.tscn` |
| Lógica da corrida | `C:\Users\Humberto\Documents\corrida_2D_android\scripts\main.gd` |
| Controle do carro | `C:\Users\Humberto\Documents\corrida_2D_android\scripts\car.gd` |
| Preset de exportação Android | `C:\Users\Humberto\Documents\corrida_2D_android\export_presets.cfg` |
| APK Android de depuração | `C:\Users\Humberto\Documents\corrida_2D_android\build\ProjetoCorridaMetal2D-debug.apk` |
| Histórico Git | `C:\Users\Humberto\Documents\corrida_2D_android\.git` |

## Ferramentas instaladas

| Ferramenta | Versão | Caminho |
| --- | --- | --- |
| Godot Engine Standard | 4.7.2 | `C:\Users\Humberto\AppData\Local\Microsoft\WinGet\Packages\GodotEngine.GodotEngine_Microsoft.Winget.Source_8wekyb3d8bbwe` |
| Configurações e templates do Godot | 4.7.2 | `C:\Users\Humberto\AppData\Roaming\Godot` |
| Eclipse Temurin OpenJDK | 17.0.20.101 | `C:\Program Files\Eclipse Adoptium\jdk-17.0.20.101-hotspot` |
| Android Studio | instalado | `C:\Program Files\Android\Android Studio` |
| Android SDK, ADB e Build Tools | Platform 35 / Build Tools 35.0.1 | `C:\Users\Humberto\AppData\Local\Android\Sdk` |
| Android Emulator | instalado | `C:\Users\Humberto\AppData\Local\Android\Sdk\emulator` |
| Imagem Android do Pixel virtual | API 35 / Google APIs / x86_64 | `C:\Users\Humberto\AppData\Local\Android\Sdk\system-images\android-35\google_apis\x86_64` |
| Keystore de depuração do Godot | local | `C:\Users\Humberto\AppData\Roaming\Godot\keystores\debug.keystore` |
| Keystores Android locais | local | `C:\Users\Humberto\.android` |
| Conversas locais do Codex | local | `C:\Users\Humberto\.codex` |

## Levar o projeto a outro computador

Copie a pasta inteira `C:\Users\Humberto\Documents\corrida_2D_android`, incluindo a pasta oculta `.git`. No outro PC:

1. Instale Godot Standard, JDK 17 e Android Studio com o Android SDK.
2. Abra/importa o arquivo `project.godot`.
3. Para gerar APK, configure no Godot os caminhos do JDK e do Android SDK.

Não é necessário copiar Android Studio, SDK, templates do Godot ou as keystores de depuração. Eles podem ser instalados ou gerados novamente. Para uma futura versão publicada, guarde a keystore de lançamento em local seguro; não a envie ao Git.

## Remover deste computador no futuro

1. Desinstale Godot, JDK e Android Studio em **Configurações do Windows > Aplicativos instalados**.
2. Depois, se não forem mais necessários, apague manualmente:
   - `C:\Users\Humberto\AppData\Local\Android\Sdk`
   - `C:\Users\Humberto\AppData\Roaming\Godot`
   - `C:\Users\Humberto\.android`
3. Só apague `C:\Users\Humberto\Documents\corrida_2D_android` quando não quiser mais o projeto, o APK e o histórico Git.

As pastas de keystore devem ser preservadas enquanto houver APKs que precisem ser atualizados com a mesma assinatura.

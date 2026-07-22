# Primeira instalação e migração

Este guia apresenta o processo necessário para adaptar e instalar este repositório em outra máquina. Ele não pressupõe que o computador, o usuário ou o layout de discos sejam iguais aos usados no desenvolvimento original. Ao final, a pessoa que estiver seguindo o documento deverá ter criado uma configuração própria para o seu hardware, registrado seu host no Flake, instalado ou migrado o NixOS e ativado o Home Manager de maneira independente.

Os nomes `host` e `username` são usados ao longo do guia como valores genéricos. Antes de executar os comandos, substitua `host` pelo hostname escolhido para a máquina e `username` pelo nome da conta que será utilizada no sistema. O mesmo valor deve ser mantido nos diretórios, no `flake.nix`, na configuração do NixOS e na configuração do Home Manager.

> Este documento parte do princípio de que o leitor já possui uma instalação funcional do NixOS ou iniciou a máquina pela imagem oficial de instalação. O particionamento e a formatação dos discos devem ser realizados de acordo com o hardware e com o layout desejado, pois esses procedimentos não podem ser reproduzidos com segurança por uma configuração genérica.

## Como esta configuração funciona

Este repositório descreve dois ambientes relacionados, mas independentes. O primeiro é o sistema NixOS, responsável pelo bootloader, kernel, hardware, sistemas de arquivos, usuários, rede, serviços globais e demais recursos necessários para iniciar e operar a máquina. O segundo é o ambiente do Home Manager, responsável pelos pacotes, programas, serviços e arquivos de configuração pertencentes à sessão do usuário.

O `flake.nix` é o ponto de entrada desses ambientes. Ele declara os inputs externos, fixa suas versões por meio do `flake.lock` e exporta as configurações que podem ser construídas. A configuração de sistema é exposta em `nixosConfigurations.host`, enquanto o perfil do usuário é exposto em `homeConfigurations."username@host"`.

```text
flake.nix
├── nixosConfigurations.host
│   └── hosts/host/configuration.nix
└── homeConfigurations."username@host"
    └── home/username/home.nix
```

Essa separação é intencional. O NixOS deve conseguir iniciar e funcionar mesmo que o Home Manager ainda não tenha sido ativado. Da mesma forma, uma alteração nos programas ou dotfiles do usuário não deve exigir a reconstrução do kernel, do bootloader ou dos serviços globais.

### Host e usuário

Um host representa uma máquina específica. Seu diretório contém as configurações que dependem daquele computador, como o arquivo de hardware, o hostname e os módulos de sistema importados. Caso o mesmo repositório seja usado em dois computadores, cada máquina deve possuir seu próprio diretório dentro de `hosts/` e sua própria entrada em `nixosConfigurations`.

O usuário é representado separadamente dentro de `home/`. Essa configuração pode ser reutilizada em mais de um host, desde que os programas e serviços declarados sejam compatíveis com as máquinas envolvidas. O identificador `username@host` evita ambiguidades quando o mesmo repositório contém vários usuários ou vários computadores.

A estrutura esperada para uma única máquina é semelhante a esta:

```text
.
├── flake.nix
├── flake.lock
├── hosts/
│   └── host/
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── modules/
│   ├── nixos/
│   └── home/
└── home/
    └── username/
        └── home.nix
```

### Hardware configuration

O arquivo `hardware-configuration.nix` não deve ser copiado de outra máquina. Ele contém informações detectadas localmente, como UUIDs dos sistemas de arquivos, módulos necessários no initrd, dispositivos de swap e características do armazenamento. Mesmo computadores do mesmo modelo podem possuir discos, partições ou UUIDs diferentes.

Em uma migração feita na mesma instalação, o arquivo existente em `/etc/nixos/hardware-configuration.nix` pode ser reutilizado. Em uma instalação limpa, em outra máquina ou depois de recriar as partições, um novo arquivo deve ser gerado com base nos sistemas de arquivos montados.

### Flake e arquivos rastreados pelo Git

Quando um Flake é avaliado a partir de um repositório Git, arquivos novos que ainda não foram adicionados ao índice podem não fazer parte da origem avaliada pelo Nix. Por isso, um novo diretório de host, um novo perfil de usuário ou qualquer módulo recém-criado deve ser adicionado com `git add` antes da avaliação.

Isso não significa que todas as alterações precisam ser enviadas para um repositório remoto. O arquivo precisa apenas estar rastreado localmente. Um aviso informando que a árvore está `dirty` indica que existem mudanças sem commit, mas não impede a construção.

### `stateVersion`

As opções `system.stateVersion` e `home.stateVersion` não controlam as versões dos pacotes. Elas preservam decisões de compatibilidade adotadas quando o sistema e o perfil foram criados.

Em uma migração, mantenha os valores já utilizados pela instalação anterior. Em uma instalação nova, use a versão estável com a qual o sistema está sendo iniciado. Não altere esses valores apenas porque o `nixpkgs` ou o Home Manager foram atualizados.

### Ordem de ativação

A primeira instalação deve respeitar a seguinte ordem lógica:

1. adaptar o repositório para o host e o usuário;
2. gerar ou copiar o `hardware-configuration.nix`;
3. validar e instalar ou ativar o NixOS;
4. confirmar que a máquina inicia e que o usuário consegue entrar na sessão;
5. ativar o Home Manager como o próprio usuário.

O Home Manager não deve ser usado para compensar uma configuração de sistema incompleta. Shells, terminais, compositores, agentes de sessão e serviços pessoais só devem ser ativados depois que a base do NixOS estiver funcionando.

## Antes de começar

Faça um fork do repositório ou clone-o para um local no qual você possa realizar alterações. O fork é recomendado quando a intenção é manter as personalizações em um repositório próprio e continuar recebendo mudanças do projeto original.

```bash
git clone URL_DO_REPOSITORIO nixos-config
cd nixos-config
```

Antes de modificar os arquivos, escolha o hostname e o username definitivos. O hostname deve ser curto, usar caracteres simples e identificar a máquina de forma estável. O username deve seguir as regras usuais de contas Linux e corresponder à conta declarada no módulo de usuários.

Neste guia, os valores genéricos são:

```text
hostname: host
username: username
```

O repositório utiliza uma versão estável do NixOS e a release correspondente do Home Manager. Mantenha os inputs alinhados durante a primeira instalação. Atualizações do `flake.lock` devem ser feitas somente depois que a configuração atual tiver sido instalada e validada.

```nix
nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

home-manager = {
  url = "github:nix-community/home-manager/release-26.05";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

Revise também os módulos importados pelo projeto. Configurações de GPU, Bluetooth, impressão, virtualização, sistemas de arquivos, dispositivos específicos e serviços opcionais podem não ser adequadas para todas as máquinas. Antes do primeiro build, desative módulos que dependam de hardware inexistente ou adapte suas opções ao computador de destino.

## 1. Adaptar a estrutura do repositório

Localize o diretório de host que acompanha o repositório e renomeie-o para o hostname escolhido. Faça o mesmo com o diretório do perfil pessoal, usando o username que será criado no sistema.

```bash
mv hosts/DIRETORIO_DO_HOST_ATUAL hosts/host
mv home/DIRETORIO_DO_USUARIO_ATUAL home/username
```

Depois da alteração, confirme que os arquivos principais estão nos seguintes caminhos:

```text
hosts/host/configuration.nix
hosts/host/hardware-configuration.nix
home/username/home.nix
```

Caso o repositório já ofereça um diretório de exemplo ou template, copie-o em vez de renomear uma configuração existente:

```bash
cp -r hosts/template hosts/host
cp -r home/template home/username
```

Use apenas uma dessas abordagens. O objetivo é terminar esta etapa com um diretório próprio para a máquina e outro para o usuário.

## 2. Registrar o host e o usuário no Flake

Abra o `flake.nix` e substitua os valores usados como hostname e username. A estrutura deve exportar o NixOS e o Home Manager como configurações independentes.

```nix
let
  system = "x86_64-linux";
  hostname = "host";
  username = "username";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  nixosConfigurations.${hostname} =
    nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs hostname username;
      };

      modules = [
        ./hosts/${hostname}/configuration.nix
        {
          nixpkgs.config.allowUnfree = true;
        }
      ];
    };

  homeConfigurations."${username}@${hostname}" =
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit inputs hostname username;
      };

      modules = [
        ./home/${username}/home.nix
      ];
    };
}

  # Esse é um modelo de exemplo, não o copie cegamente, provavelmente ele não vai funcionar corretamente use o padrão que está no repositório clonado 

```

Se o computador utiliza outra arquitetura, substitua `x86_64-linux` pelo sistema adequado. Não faça essa alteração apenas com base no fabricante do processador; confirme a arquitetura executando `uname -m` na máquina de destino.

```bash
uname -m
```

Um resultado `x86_64` corresponde normalmente a `x86_64-linux`. Máquinas ARM de 64 bits normalmente utilizam `aarch64-linux`, desde que todos os módulos e pacotes escolhidos estejam disponíveis para essa plataforma.

## 3. Configurar o usuário do NixOS

O NixOS precisa criar a conta antes que o Home Manager possa gerenciá-la. Confirme que algum módulo importado pela configuração declara `users.users.${username}` e que o valor recebido pelo módulo vem do `flake.nix`.

```nix
{
  pkgs,
  username,
  ...
}:

{
  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    shell = pkgs.fish;

    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
    ];
  };

  programs.fish.enable = true;
}

  # Esse é um modelo de exemplo, não o copie cegamente, provavelmente ele não vai funcionar corretamente use o padrão que está no repositório clonado 


```

Os grupos devem refletir os recursos realmente utilizados. `wheel` permite administrar o sistema por meio do `sudo`, enquanto `networkmanager` permite controlar conexões quando o NetworkManager está habilitado. Grupos adicionais só devem ser mantidos quando forem necessários para os dispositivos e serviços configurados.

Se outro shell for utilizado, substitua o Fish e habilite o shell correspondente no NixOS. O shell de login precisa existir na configuração do sistema antes de ser atribuído ao usuário.

## 4. Configurar o perfil do Home Manager

Como o Home Manager é standalone, o perfil deve declarar explicitamente o nome do usuário e seu diretório pessoal. Abra `home/username/home.nix` e confirme a presença das opções abaixo:

```nix
{
  username,
  ...
}:

{
  imports = [
    ../../modules/home
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}

  # Esse é um modelo de exemplo, não o copie cegamente, provavelmente ele não vai funcionar corretamente use o padrão que está no repositório clonado 

```

Em uma migração, substitua `26.05` pelo valor já usado no perfil anterior. Caso a configuração anterior do Home Manager não esteja disponível, procure por `home.stateVersion` nos arquivos antigos antes de escolher um novo valor.

Revise os módulos importados pelo perfil. Remova temporariamente programas que dependam de credenciais, caminhos privados, monitores específicos, dispositivos que não existem ou arquivos que não fazem parte do repositório. A primeira ativação deve produzir um ambiente funcional; personalizações específicas podem ser reintroduzidas depois.

## 5. Preparar o hardware da máquina

A forma de obter o `hardware-configuration.nix` depende de a instalação atual ser preservada ou recriada.

### Migração de uma instalação existente

Quando a configuração está sendo migrada na mesma máquina, com os mesmos discos e partições, copie o arquivo atualmente utilizado pelo NixOS:

```bash
cp /etc/nixos/hardware-configuration.nix \
  hosts/host/hardware-configuration.nix
```

Compare o conteúdo copiado com a situação atual dos discos:

```bash
lsblk -f
```

Verifique principalmente os pontos de montagem de `/`, `/boot`, `/home`, swap, partições criptografadas e subvolumes Btrfs. Caso o layout tenha sido alterado, gere um arquivo novo em vez de manter referências antigas.

## 6. Revisar a configuração específica do host

Abra `hosts/host/configuration.nix` e confirme que ele importa o arquivo de hardware e os módulos compartilhados do sistema:

```nix
{
  hostname,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = hostname;

  system.stateVersion = "26.05";
}

  # Esse é um modelo de exemplo, não o copie cegamente, provavelmente ele não vai funcionar corretamente use o padrão que está no repositório clonado 

```

Em uma migração, preserve o `system.stateVersion` usado anteriormente. Ele normalmente pode ser encontrado no antigo `/etc/nixos/configuration.nix` ou em algum módulo importado pela configuração anterior.

Revise as opções de boot antes de continuar. A configuração precisa corresponder ao modo de inicialização da máquina, ao ponto de montagem da partição EFI e ao bootloader escolhido. Também confira drivers gráficos, microcode, suporte a firmware, sistemas de arquivos e serviços que precisam estar disponíveis durante o boot.

Não aplique configurações de GPU, armazenamento ou bootloader que pertenciam a outra máquina. Um módulo pode ser sintaticamente válido e ainda impedir a inicialização quando assume dispositivos inexistentes ou pontos de montagem incorretos.

## 7. Adicionar os arquivos ao Git e avaliar o Flake

Adicione ao índice todos os arquivos criados ou renomeados:

```bash
git add flake.nix flake.lock hosts/host home/username modules
```

Caso a organização do repositório seja diferente, use `git add -A` e revise o resultado com `git status`:

```bash
git add -A
git status
```

Em seguida, confirme que o Flake expõe as configurações esperadas:

```bash
nix flake show
```

A saída deve incluir uma entrada `nixosConfigurations` para `host` e uma entrada `homeConfigurations` para `username@host`. Depois, execute a avaliação completa:

```bash
nix flake check --show-trace
```

Uma falha nesta etapa precisa ser corrigida antes da instalação. Erros comuns incluem imports apontando para diretórios antigos, arquivos novos fora do índice do Git, nomes diferentes entre o Flake e os diretórios, opções removidas e pacotes indisponíveis para a arquitetura escolhida.

## 8. Construir e ativar o NixOS

### Em uma instalação existente

Construa primeiro a configuração sem ativá-la e sem criar o link simbólico `result` no repositório:

```bash
nix build \
  .#nixosConfigurations.host.config.system.build.toplevel \
  --no-link \
  --option max-jobs 1 \
  --option cores 2
```

O build confirma que a configuração pode ser avaliada e construída, mas não altera o sistema em execução. Depois, use uma ativação temporária:

```bash
sudo nixos-rebuild test \
  --flake .#host \
  --option max-jobs 1 \
  --option cores 2
```

O modo `test` aplica a nova configuração à sessão atual sem defini-la como a geração padrão do próximo boot. Verifique o acesso com `sudo`, a rede, o ambiente gráfico, o áudio, as montagens e os serviços essenciais:

```bash
systemctl is-system-running
systemctl --failed
```

Quando o sistema estiver saudável, aplique a configuração definitivamente:

```bash
sudo nixos-rebuild switch \
  --flake .#host \
  --option max-jobs 1 \
  --option cores 2
```

Reinicie a máquina e selecione a geração anterior no bootloader caso a nova geração não consiga iniciar corretamente. Não remova gerações antigas até concluir a validação do novo host.

## 9. Ativar o Home Manager pela primeira vez

O Home Manager deve ser ativado como o usuário normal, sem `sudo`. Entre no diretório em que o repositório foi mantido. Em uma instalação limpa, este guia utiliza `/etc/nixos`; em uma migração, use o caminho escolhido durante o clone.

```bash
cd CAMINHO_DO_REPOSITORIO

nix build \
  '.#homeConfigurations."username@host".activationPackage' \
  --no-link \
  --option max-jobs 1 \
  --option cores 2
```

Na primeira instalação, o executável `home-manager` pode ainda não estar disponível. Nesse caso, execute temporariamente a release correspondente ao NixOS para criar a primeira geração:

```bash
nix run github:nix-community/home-manager/release-26.05 -- \
  switch \
  --flake '.#username@host' \
  --option max-jobs 1 \
  --option cores 2 \
  -b backup
```

A opção `-b backup` renomeia arquivos existentes que entrariam em conflito com arquivos gerenciados pelo Home Manager. Depois da ativação, revise os arquivos com extensão `.backup` antes de removê-los.

Como `programs.home-manager.enable = true` está declarado no perfil, as próximas ativações poderão utilizar diretamente o comando instalado no ambiente do usuário:

```bash
home-manager switch \
  --flake '.#username@host' \
  --option max-jobs 1 \
  --option cores 2 \
  -b backup
```

Abra uma nova sessão do terminal ou reinicie o shell para carregar as variáveis e os caminhos definidos pelo perfil. Em seguida, confirme que nenhuma unidade do usuário falhou:

```bash
systemctl --user --failed
```

Se o ambiente gráfico, o terminal ou algum serviço da sessão não iniciar, corrija o módulo correspondente no Home Manager e execute novamente o `switch`. Não é necessário reconstruir o NixOS para alterações que pertencem exclusivamente ao perfil do usuário.

## 10. Confirmar a instalação

A configuração pode ser considerada instalada quando o NixOS inicia pela nova geração, o usuário consegue autenticar, o Home Manager ativa sem erros e os serviços essenciais permanecem saudáveis.

Confirme a identidade da máquina e do usuário:

```bash
hostname
whoami
```

Os resultados devem corresponder aos valores registrados como `host` e `username`. Verifique também a versão e os perfis ativos:

```bash
nixos-version
readlink -f /run/booted-system
readlink -f /run/current-system
readlink -f /nix/var/nix/profiles/system
```

Depois de um reboot bem-sucedido, os três caminhos devem apontar para a mesma geração do sistema. Por fim, verifique as unidades do sistema e da sessão:

```bash
systemctl is-system-running
systemctl --failed
systemctl --user --failed
```

Teste manualmente os componentes que dependem da máquina: rede, áudio, Bluetooth, brilho, suspensão, retorno da suspensão, monitores, ambiente gráfico, terminal, shell, dispositivos externos e serviços de desenvolvimento.

## O que deve ser personalizado depois

A instalação inicial reproduz a estrutura e os módulos do repositório, mas não torna automaticamente apropriadas todas as preferências pessoais. Depois que o sistema estiver estável, revise nomes e endereços do Git, chaves SSH, credenciais, caminhos de projetos, monitores, dispositivos de áudio, temas, atalhos, aplicativos padrão e serviços opcionais.

Segredos não devem ser escritos diretamente em arquivos do Flake, pois o conteúdo usado nas construções pode ser copiado para o Nix Store. Utilize o mecanismo de segredos adotado pelo projeto ou mantenha dados sensíveis fora dos módulos públicos.

Não atualize todos os inputs durante a instalação inicial. Primeiro confirme que o estado fixado pelo `flake.lock` funciona na máquina. A manutenção cotidiana, a atualização de inputs e os rebuilds posteriores são tratados no README principal e não fazem parte deste processo de primeira instalação.

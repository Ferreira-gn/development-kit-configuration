# Minhas configurações 

Essas são **as minhas configuração** do meu setup de desenvolvimento criadas com o auxilo do `home-manager` e `flake` para um ambiente `nix` organizado e performatico.

<br/>

#### Adições futuras : 

[] - Implementar menu de gestão de redes
[] - Implementar menu de gestão de conexões bluetooth
[] - Implementar menu de gestão de áudio 
[] - Implementar menu de gestão dos wallpapers ( visual ) 
[] - Implementar menu de gestão de compartilhamento de tela
[] - Re-estruturar cada modulo de configuração para ser reproduzivel em qualquer setup

#### Observações : 
.......


<br/>

# Como rodar : 

```
  home-manager switch --flake .#seu-usuário-nixos
  ou
  nix run github:nix-community/home-manager -- switch --flake .#seu-usuário-nixos  

```

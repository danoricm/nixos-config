{config, pkgs, ...}

{
    home.username = "dddyo";
    home.homeDirectory = "/home/dddyo";
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
    home.packages = with pkgs; [
    alacritty
    wget
    neovim
    neofetch
    distrobox
    prismlauncher
    atlauncher
    pcmanfm
    ani-cli
    ];
    services.gpg-agent.enable = true;
    services.ssh-agent.enable = true;

    programs.zsh.enable = true;
    programs.bash.enable = true;
    programs.starship.enable = true;

    home.file.".config/awesome/rc.lua".source = "${config.home.homeDirectory}/.config/awesome/rc.lua";
    home.file.".bashrc".source = "${config.home.homeDirectory}/.bashrc";

}

{ config, lib, ... }:
let
  cfg = config.dbConfig;
in
{
  options = {
    dbConfig.tmux = lib.mkEnableOption "Enable tmux";
  };
  config = lib.mkIf cfg.tmux {
    programs.tmux = {
      enable = true;
      clock24 = true;
      baseIndex = 1;
      keyMode = "vi";
      shortcut = "a";
      newSession = true;
      terminal = "tmux-256color";
      extraConfig = "

        ";
    };
  };
}

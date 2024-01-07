{
  enable = true;
  enableBashIntegration = true;
  enableNushellIntegration = false;
  settings = {
    character = {
      error_symbol = "[✖](bold red) ";
      success_symbol = "[❱](bold blue) ";
    };
    directory = {
      truncation_length = 3;
      format = "[$path]($style)[$lock_symbol]($lock_style) ";
    };
    julia = {
      format = "[$symbol$version]($style) ";
      symbol = ".jl ";
      style = "bold green";
    };
    python = {
      format = "[$symbol$version - $virtualenv]($style)";
      symbol = ".py ";
      style = "bold blue";
    };
    rust = {
      format = "[$symbol$version]($style)";
      symbol = ".rs ";
      style = "bold fg:16";
    };
    nodejs = {
      format = "[$symbol$version]($style)";
      symbol = ".js ";
      style = "bold fg:130";
    };
    gcloud = {
      disabled = true;
    };
  };
}

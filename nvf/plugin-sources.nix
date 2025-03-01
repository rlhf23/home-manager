{pkgs, ...}: let
  inherit (pkgs) fetchFromGitHub;
  inherit (pkgs.vimUtils) buildVimPlugin;

  sources = {
    hmts = buildVimPlugin {
      name = "hmts.nvim";
      src = fetchFromGitHub {
        owner = "calops";
        repo = "hmts.nvim";
        rev = "c7ff4c3ad96cd05664b18fb5bbbe2abbd7682dd2";
        hash = "sha256-V5dwIJdxBulFVKk1iSlf4H5NRz1UH7uYQeMvwtgkpIs=";
      };
    };

    # best way to talk to an llm, pairs fantastically with mind.nvim
    # llm = buildVimPlugin {
    #   name = "llm.nvim";
    #   src = fetchFromGitHub {
    #     owner = "melbaldove";
    #     repo = "llm.nvim";
    #     rev = "0cc5a0fdf2e6b613a2ab62c5b3d5b2c9eee5b07e";
    #     hash = "sha256-mFi22n8vkVghjJXo5twoAFFqCI+To2vW0Ab/7cBzPTY=";
    #   };
    #   dependencies = with pkgs.vimPlugins; [plenary-nvim];
    # };
    llm = buildVimPlugin {
      name = "llm.nvim";
      src = fetchFromGitHub {
        owner = "rlhf23";
        repo = "llm.nvim";
        rev = "f67ba3144145c6fe73c0cd5ffa75a1c941b08f3f";
        hash = "sha256-4HUj3Ynio16lJ1kxjvKSxSYujMyDeHx8eK0+jzF78GE=";
      };
      dependencies = with pkgs.vimPlugins; [plenary-nvim];
    };

    # does not seem to work for me
    avante = buildVimPlugin {
      name = "avante.nvim";
      src = fetchFromGitHub {
        owner = "yetone";
        repo = "avante.nvim";
        rev = "9bad591e8a63f53058471f691497b04eea5dddbf";
        hash = "sha256-sQx4yjwt12OEyruV9ED6uByZbOL06zXzYaN69DdjSx4=";
      };
      dependencies = with pkgs.vimPlugins; [
        plenary-nvim
        dressing-nvim
        nui-nvim
      ];
      nvimSkipModule = [
        "avante.providers.copilot"
        "avante.providers.azure"
      ];
      build = "make";
    };

    codecompanion = buildVimPlugin {
      name = "codecompanion.nvim";
      src = fetchFromGitHub {
        owner = "olimorris";
        repo = "codecompanion.nvim";
        rev = "317737145a221c62320cf47019075aa0a65d1695";
        hash = "sha256-GBubkouKMxviG0LIGhGbL3nbxfXQFNWgr06J4vpZQS8=";
      };
      dependencies = with pkgs.vimPlugins; [plenary-nvim];
      nvimSkipModule = [
        "codecompanion.providers.actions.mini_pick"
        "codecompanion.providers.actions.telescope"
        "minimal"
      ];
    };
  };
in
  sources

{
  imports = [./plugins.nix ./keymaps.nix];
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings.vim = {
      #customize
      undoFile.enable = true;
      searchCase = "ignore";
      # inlay hints suggestion from "issues"
      luaConfigPre = ''
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr })
      '';
      options = {
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        autoindent = true;
      };

      dashboard.startify = {
        enable = true;
        customHeader = ["don't panic"];
      };

      viAlias = false;
      vimAlias = true;
      lsp = {
        enable = true;
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = false;
        lspsaga.enable = false;
        trouble.enable = true;
        lspSignature.enable = true;
        otter-nvim.enable = true;
      };
      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        # Languages that will be supported in default and maximal configurations.
        nix.enable = true;
        markdown.enable = true;

        # Languages that are enabled in the maximal configuration.
        bash.enable = true;
        clang.enable = true;
        css.enable = false;
        html.enable = true;
        sql.enable = false;
        java.enable = false;
        kotlin.enable = false;
        ts.enable = true;
        go.enable = true;
        lua.enable = true;
        zig.enable = false;
        python.enable = true;
        typst.enable = false;
        rust = {
          enable = true;
          crates.enable = true;
        };

        # Language modules that are not as common.
        assembly.enable = false;
        astro.enable = false;
        nu.enable = true;
        csharp.enable = false;
        julia.enable = false;
        vala.enable = false;
        scala.enable = false;
        r.enable = false;
        gleam.enable = true;
        dart.enable = false;
        ocaml.enable = false;
        elixir.enable = false;
        haskell.enable = false;
        ruby.enable = false;

        tailwind.enable = false;
        svelte.enable = false;
      };
      visuals = {
        nvim-scrollbar.enable = true;
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = true;

        highlight-undo.enable = true;
        indent-blankline.enable = true;

        # Fun
        cellular-automaton.enable = false;

        rainbow-delimiters.enable = true;
      };

      statusline = {
        lualine = {
          enable = true;
          theme = "auto";
        };
      };

      theme = {
        enable = true;
        name = "rose-pine";
        style = "main";
        transparent = false;
      };

      autopairs.nvim-autopairs.enable = true;

      autocomplete.nvim-cmp.enable = true;
      snippets.luasnip.enable = true;

      filetree = {
        neo-tree = {
          enable = true;
        };
      };

      tabline = {
        nvimBufferline = {
          enable = true;
          setupOpts.options.indicator.style = "icon";
          setupOpts.options.stype.preset = "minimal";
        };
      };

      treesitter.context.enable = true; # not sure how I feel about this one

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      telescope.enable = true;

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false; # throws an annoying debug message
      };

      minimap = {
        minimap-vim.enable = false;
        codewindow.enable = true; # lighter, faster, and uses lua for configuration
      };

      dashboard = {
        dashboard-nvim.enable = false;
        alpha.enable = false;
      };

      notify = {
        nvim-notify.enable = true;
      };

      projects = {
        project-nvim.enable = true;
      };

      utility = {
        ccc.enable = false;
        vim-wakatime.enable = false;
        icon-picker.enable = true;
        surround.enable = true;
        diffview-nvim.enable = true;
        yanky-nvim.enable = false;
        motion = {
          hop.enable = true;
          leap.enable = true;
          precognition.enable = false; # gave me cancer
        };

        images = {
          image-nvim.enable = false;
        };
      };

      notes = {
        obsidian.enable = false; # FIXME: neovim fails to build if obsidian is enabled
        neorg.enable = false;
        orgmode.enable = false;
        mind-nvim.enable = true;
        todo-comments.enable = true;
      };

      terminal = {
        toggleterm = {
          enable = true;
          lazygit.enable = true;
        };
      };

      ui = {
        borders.enable = true;
        noice.enable = true;
        colorizer.enable = true;
        modes-nvim.enable = false; # the theme looks terrible with catppuccin
        illuminate.enable = true;
        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };
        smartcolumn = {
          enable = true;
          setupOpts.custom_colorcolumn = {
            # this is a freeform module, it's `buftype = int;` for configuring column position
            nix = "110";
            ruby = "120";
            java = "130";
            go = ["90" "130"];
          };
        };
        fastaction.enable = true;
      };

      session = {
        nvim-session-manager.enable = false;
      };

      comments = {
        comment-nvim.enable = true;
      };

      assistant.codecompanion-nvim = {
        enable = true;
        setupOpts = {
          opts.send_code = true;
          strategies.chat = {
            adapter = "anthropic";
          };
          strategies.inline = {
            adapter = "anthropic";
          };
        };
      };
    };
  };
}

{
  self,
  pkgs,
  ...
}: let
  pluginSources = import ./plugin-sources.nix {inherit self pkgs;};
in {
  programs.nvf.settings.vim = {
    startPlugins = ["plenary-nvim" "dressing-nvim" "nui-nvim" "mini-pick"];

    extraPlugins = with pkgs.vimPlugins; {
      harpoon = {
        package = harpoon;
        setup = "require('harpoon').setup{}";
      };
      nvim-surround = {
        package = nvim-surround;
        setup = "require('nvim-surround').setup{}";
      };
      render-markdown-nvim = {
        package = render-markdown-nvim;
        setup = ''
          require('render-markdown').setup({
            file_types = { 'markdown', 'codecompanion' },
          })'';
      };

      ## built plugins
      hmts = {
        package = pluginSources.hmts;
        after = ["treesitter"];
      };
      llm = {
        package = pluginSources.llm;
        after = ["plenary"];
        setup = ''
          require('llm').setup{
            system_prompt_replace = "You should replace the code that you are sent, only following the comments. Do not talk at all. Only output valid code. Do not provide any backticks that surround the code. Never ever output backticks like this ```. Any comment that is asking you for something should be removed after you satisfy them. Other comments should left alone. Do not output backticks",
            timeout_ms = 20000,
            services = {
              groq = {
                url = "https://api.groq.com/openai/v1/chat/completions",
                -- model = "llama-3.3-70b-versatile",
                model = "deepseek-r1-distill-llama-70b",
                api_key_name = "GROQ_API_KEY",
              },
              anthropic = {
                  url = "https://api.anthropic.com/v1/messages",
                  model = "claude-3-7-sonnet-latest",
                  api_key_name = "ANTHROPIC_API_KEY",
              },
              openai = {
                url = "https://api.openai.com/v1/chat/completions",
                model = "gpt-4o",
                api_key_name = "OPENAI_API_KEY",
              }
            }
          }

          vim.keymap.set("n", "<leader>,m", function()
            require("llm").create_llm_md()
          end, { desc = "Create llm.md" })

          vim.keymap.set("n", "<leader>,q", function()
            require("llm").prompt({ replace = false, service = "groq" })
          end, { desc = "Prompt with groq" })

          vim.keymap.set("n", "<leader>,a", function()
            require("llm").prompt({ replace = false, service = "openai" })
          end, { desc = "Prompt with openai" })

          vim.keymap.set("v", "<leader>,a", function()
            require("llm").prompt({ replace = true, service = "openai" })
          end, { desc = "Prompt while replacing with openai" })

          vim.keymap.set("n", "<leader>,,", function()
            require("llm").prompt({ replace = false, service = "anthropic" })
          end, { desc = "Prompt with sonnet" })

          vim.keymap.set("v", "<leader>,,", function()
            require("llm").prompt({ replace = true, service = "anthropic" })
          end, { desc = "Prompt while replacing with sonnet" })
        '';
      };
      codecompanion = {
        package = pluginSources.codecompanion;
        setup = ''
          require('codecompanion').setup{
              strategies = {
                agent = {
                  adapter = "anthropic";
                },
                chat = {
                  adapter = "anthropic",
                },
                inline = {
                  adapter = "anthropic",
                },
              },
            }
          vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
          vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
          vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

          -- Expand 'cc' into 'CodeCompanion' in the command line
          vim.cmd([[cab cc CodeCompanion]])
        '';
      };
    };
  };
}

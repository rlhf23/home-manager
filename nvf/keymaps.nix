{
  programs.nvf.settings.vim = {
    keymaps = [
      {
        key = "<A-j>";
        mode = ["n"];
        action = "<cmd>execute 'move .+' . v:count1<cr>==";
        silent = true;
        desc = "Move Down";
      }
      {
        key = "<A-k>";
        mode = ["n"];
        action = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==";
        silent = true;
        desc = "Move Up";
      }
      {
        key = "<A-j>";
        mode = ["i"];
        action = "<esc><cmd>m .+1<cr>==gi";
        silent = true;
        desc = "Move Down";
      }
      {
        key = "<A-k>";
        mode = ["i"];
        action = "<esc><cmd>m .-2<cr>==gi";
        silent = true;
        desc = "Move Up";
      }
      {
        key = "<A-j>";
        mode = ["v"];
        action = ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv";
        silent = true;
        desc = "Move Down";
      }
      {
        key = "<A-k>";
        mode = ["v"];
        action = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
        silent = true;
        desc = "Move Up";
      }
      {
        key = "<leader>e";
        mode = ["n"];
        action = ":Neotree toggle<CR>";
        silent = true;
        desc = "Toggle Neo-tree";
      }
      {
        key = "<leader>u";
        mode = ["n"];
        action = ":UndotreeToggle<CR>";
        silent = true;
        desc = "Toggle Undotree";
      }
      {
        key = "<leader>y";
        mode = ["n"];
        action = ''"*yy'';
        silent = true;
        desc = "Copy line to system clipboard";
      }
      {
        key = "<leader><space>";
        mode = ["n"];
        action = ":Telescope find_files<CR>";
        silent = true;
        desc = "Find files with Telescope";
      }
      {
        key = "[b";
        mode = ["n"];
        action = ":bprevious<CR>";
        silent = true;
        desc = "Previous buffer";
      }
      {
        key = "]b";
        mode = ["n"];
        action = ":bnext<CR>";
        silent = true;
        desc = "Next buffer";
      }
      {
        key = "<esc>";
        mode = ["t"];
        action = "<C-\\><C-n>";
        silent = true;
        desc = "Exit to normal mode in toggleterm";
      }
      {
        key = "<leader>a";
        mode = ["n"];
        action = "CodeCompanionChat Toggle";
        silent = true;
        desc = "CodeCompanionChat Toggle";
      }
    ];
  };
}

{
  programs.nvf.settings.vim = {
    keymaps = [
      {
        key = "<leader>wq";
        mode = ["n"];
        action = ":wq<CR>";
        silent = true;
        desc = "Save file and quit";
      }
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
    ];
  };
}

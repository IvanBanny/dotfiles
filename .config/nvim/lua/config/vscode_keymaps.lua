local vscode = require("vscode-neovim")
local map = vim.keymap.set

-- Whimsy
map("n", "<leader>w", function() vscode.action("workbench.action.files.save") end)

-- Navigation
map("n", "<leader>,", function() vscode.action("workbench.action.showAllEditors") end)
map("n", "<leader>e", function()
    vscode.action("workbench.action.toggleSidebarVisibility")
    vscode.action("workbench.files.action.focusFilesExplorer")
end)
map("n", "<leader>t", function() vscode.action("workbench.action.terminal.toggleTerminal") end)
map("n", "<leader>bd", function() vscode.action("workbench.action.closeActiveEditor") end)
map("n", "<leader><leader>", function() vscode.action("workbench.action.quickOpen") end)
map("n", "<leader>sg", function() vscode.action("workbench.action.findInFiles") end)
map("n", "<leader>gg", function() vscode.action("workbench.view.scm") end)
map("n", "\t", function() vscode.action("workbench.action.nextEditorInGroup") end)
map("n", "<S-\t>", function() vscode.action("workbench.action.previousEditorInGroup") end)

-- Coding
map({"n", "v", "o"}, "<S-j>", function() vscode.action("editor.action.moveLinesDownAction") end)
map({"n", "v", "o"}, "<S-k>", function() vscode.action("editor.action.moveLinesUpAction") end)
map("n", "<S-k>", function() vscode.action("editor.action.showHover") end)
map("n", "<leader>ca", function() vscode.action("editor.action.codeAction") end)
map("n", "<leader>cr", function() vscode.action("editor.action.rename") end)
map("n", "<leader>cs", function() vscode.action("workbench.action.gotoSymbol") end)
map("n", "<leader>gd", function() vscode.action("editor.action.revealDefinition") end)
map("n", "<leader>gr", function() vscode.action("editor.action.goToReferences") end)
map("n", "<leader>gi", function() vscode.action("editor.action.goToImplementation") end)
map({"n", "v"}, "<C-n>", function() vscode.action("editor.action.addSelectionToNextFindMatch") end)

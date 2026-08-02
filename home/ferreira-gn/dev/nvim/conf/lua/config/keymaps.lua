local git_workflow = require("config.git-workflow")

vim.keymap.set("n", "<leader>gd", git_workflow.github_dashboard, {
  desc = "GitHub Dashboard",
})

vim.keymap.set("n", "<leader>gr", git_workflow.review_current_pr, {
  desc = "Review Current PR",
})

vim.keymap.set("n", "<leader>gR", git_workflow.review_pr_by_number, {
  desc = "Review PR by Number",
})

vim.keymap.set("n", "<leader>gw", git_workflow.review_worktree, {
  desc = "Review Working Tree",
})

vim.keymap.set("n", "<leader>ga", git_workflow.github_login, {
  desc = "GitHub Authenticate",
})

vim.keymap.set("n", "<leader>gA", git_workflow.github_auth_status, {
  desc = "GitHub Auth Status",
})

vim.cmd([[ map <C-a> ggVG ]])

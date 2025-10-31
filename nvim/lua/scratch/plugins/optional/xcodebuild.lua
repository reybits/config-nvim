return {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
        -- Uncomment a picker that you want to use, snacks.nvim might be additionally
        -- useful to show previews and failing snapshots.

        -- You must select at least one:
        -- "nvim-telescope/telescope.nvim",
        "ibhagwan/fzf-lua",
        -- "folke/snacks.nvim", -- (optional) to show previews

        "MunifTanjim/nui.nvim",
        -- "nvim-tree/nvim-tree.lua", -- (optional) to manage project files
        "stevearc/oil.nvim", -- (optional) to manage project files
        -- "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
    },
    keys = {
        { "<leader>xp", "<cmd>XcodebuildPicker<cr>", desc = "Open Picker" },
        { "<leader>xb", "<cmd>XcodebuildBuild<cr>", desc = "Build" },
        { "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", desc = "Build and Run" },
        { "<leader>xd", "<cmd>XcodebuildBuildDebug<cr>", desc = "Build and Debug" },
        { "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", desc = "Toggle Logs" },
    },
    cmd = {
        -- General
        "XcodebuildSetup", -- Run configuration wizard to select project configuration
        "XcodebuildPicker", -- Show picker with all available actions
        "XcodebuildBuild", -- Build project
        "XcodebuildCleanBuild", -- Build project (clean build)
        "XcodebuildBuildRun", -- Build & run app
        "XcodebuildBuildForTesting", -- Build for testing
        "XcodebuildRun", -- Run app without building
        "XcodebuildCancel", -- Cancel currently running action
        "XcodebuildCleanDerivedData", -- Deletes project's DerivedData
        "XcodebuildToggleLogs", -- Toggle logs panel
        "XcodebuildOpenLogs", -- Open logs panel
        "XcodebuildCloseLogs", -- Close logs panel
        "XcodebuildOpenInXcode", -- Open project in Xcode
        "XcodebuildQuickfixLine", -- Try fixing issues in the current line
        "XcodebuildCodeActions", -- Show code actions for the current line

        -- Project Manager
        "XcodebuildProjectManager", -- Show picker with all Project Manager actions
        "XcodebuildAssetsManager", -- Show picker with all Assets Manager actions
        "XcodebuildCreateNewFile", -- Create a new file and add it to target(s)
        "XcodebuildAddCurrentFile", -- Add the active file to target(s)
        "XcodebuildRenameCurrentFile", -- Rename the current file
        "XcodebuildDeleteCurrentFile", -- Delete the current file
        "XcodebuildCreateNewGroup", -- Create a new directory and add it to the project
        "XcodebuildAddCurrentGroup", -- Add the parent directory of the active file to the project
        "XcodebuildRenameCurrentGroup", -- Rename the current directory
        "XcodebuildDeleteCurrentGroup", -- Delete the current directory including all files inside
        "XcodebuildUpdateCurrentFileTargets", -- Update target membership of the active file
        "XcodebuildShowCurrentFileTargets", -- Show target membership of the active file

        -- Previews
        "XcodebuildPreviewGenerate", -- Generate preview (optional parameter: `hotReload`)
        "XcodebuildPreviewGenerateAndShow", -- Generate and show preview (optional parameter `hotReload`)
        "XcodebuildPreviewShow", -- Show preview
        "XcodebuildPreviewHide", -- Hide preview
        "XcodebuildPreviewToggle", -- Toggle preview

        -- Testing
        "XcodebuildTest", -- Run tests (whole test plan)
        "XcodebuildTestTarget", -- Run test target (where the cursor is)
        "XcodebuildTestClass", -- Run test class (where the cursor is)
        "XcodebuildTestNearest", -- Run test (where the cursor is)
        "XcodebuildTestSelected", -- Run selected tests (using visual mode)
        "XcodebuildTestFailing", -- Rerun previously failed tests
        "XcodebuildTestRepeat", -- Repeat the last test run
        "XcodebuildFailingSnapshots", -- Show a picker with failing snapshot tests

        -- Debugging
        "XcodebuildAttachDebugger", -- Attach debugger to the running process
        "XcodebuildDetachDebugger", -- Detach debugger without killing the process
        "XcodebuildBuildDebug", -- Build, install, and debug the app
        "XcodebuildDebug", -- Install and debug the app without building

        -- Code Coverage
        "XcodebuildToggleCodeCoverage", -- Toggle code coverage marks on the side bar
        "XcodebuildShowCodeCoverageReport", -- Open HTML code coverage report
        "XcodebuildJumpToNextCoverage", -- Jump to next code coverage mark
        "XcodebuildJumpToPrevCoverage", -- Jump to previous code coverage mark

        -- Test Explorer
        "XcodebuildTestExplorerShow", -- Show Test Explorer
        "XcodebuildTestExplorerHide", -- Hide Test Explorer
        "XcodebuildTestExplorerToggle", -- Toggle Test Explorer
        "XcodebuildTestExplorerClear", -- Clears Test Explorer
        "XcodebuildTestExplorerRerunTests", -- Re-run recently selected tests

        -- Configuration
        "XcodebuildSelectScheme", -- Show scheme picker
        "XcodebuildSelectDevice", -- Show device picker
        "XcodebuildNextDevice", -- Selects next device
        "XcodebuildPreviousDevice", -- Selects previous device
        "XcodebuildSelectTestPlan", -- Show test plan picker
        "XcodebuildShowConfig", -- Print current project configuration
        "XcodebuildEditEnvVars", -- Edit environment variables
        "XcodebuildEditRunArgs", -- Edit run arguments
        "XcodebuildBootSimulator", -- Boot selected simulator
        "XcodebuildInstallApp", -- Install application
        "XcodebuildUninstallApp", -- Uninstall application

        -- Swift Macros
        "XcodebuildApproveMacros", -- Show picker to approve Swift macros
    },
    init = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>x", group = "Xcode Build" },
        })
    end,
    config = function()
        local progress_handle

        require("xcodebuild").setup({
            -- put some options here or leave it empty to use default settings
            show_build_progress_bar = false,
            logs = {
                notify = function(message, severity)
                    local fidget = require("fidget")
                    if progress_handle then
                        progress_handle.message = message
                        if not message:find("Loading") then
                            progress_handle:finish()
                            progress_handle = nil
                            if vim.trim(message) ~= "" then
                                fidget.notify(message, severity)
                            end
                        end
                    else
                        fidget.notify(message, severity)
                    end
                end,
                notify_progress = function(message)
                    local progress = require("fidget.progress")

                    if progress_handle then
                        progress_handle.title = ""
                        progress_handle.message = message
                    else
                        progress_handle = progress.handle.create({
                            message = message,
                            lsp_client = { name = "xcodebuild.nvim" },
                        })
                    end
                end,
            },
        })
    end,
}

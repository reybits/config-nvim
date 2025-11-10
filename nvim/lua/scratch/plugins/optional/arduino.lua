-- A Vim plugin that streamlines Arduino development by providing commands for
-- compiling, uploading, and managing Arduino sketches directly within the editor.
-- Dependes on: Arduino CLI (https://arduino.github.io/arduino-cli/)
--
-- Before using this plugin, ensure you have Arduino CLI installed and configured.
--
-- Update the core index and install the necessary platform for your board:
-- `arduino-cli core update-index`
-- `arduino-cli core install arduino:avr` # or other platform
--
-- Check the installed cores with:
-- `arduino-cli core list`

return {
    "stevearc/vim-arduino",
    cmd = {
        "ArduinoAttach",
        "ArduinoChooseBoard",
        "ArduinoChooseProgrammer",
        "ArduinoChoosePort",
        "ArduinoVerify",
        "ArduinoUpload",
        "ArduinoSerial",
        "ArduinoUploadAndSerial",
        "ArduinoInfo",
    },
    keys = {
        { "<leader>taoa", "<cmd>ArduinoAttach<cr>", desc = "Attach to Arduino board" },
        { "<leader>taob", "<cmd>ArduinoChooseBoard<cr>", desc = "Select the type of board" },
        { "<leader>taop", "<cmd>ArduinoChooseProgrammer<cr>", desc = "Select the programmer" },
        { "<leader>taos", "<cmd>ArduinoChoosePort<cr>", desc = "Select the serial port" },
        { "<leader>tab", "<cmd>ArduinoVerify<cr>", desc = "Build" },
        { "<leader>tau", "<cmd>ArduinoUpload<cr>", desc = "Build, Upload" },
        { "<leader>tad", "<cmd>ArduinoUploadAndSerial<cr>", desc = "Build, Upload, Debug" },
        { "<leader>tac", "<cmd>ArduinoSerial<cr>", desc = "Connect for debugging" },
    },
    init = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>ta", group = "Arduino" },
            { "<leader>tao", group = "Options" },
        })
    end,
    config = function()
        vim.g.arduino_board = "arduino:avr:uno"
    end,
}

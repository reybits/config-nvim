require("scratch.core")
require("scratch.lazy")
-- Keymaps are loaded after lazy so toggleopt's which-key spec calls find the
-- plugin on the runtime path (which-key lives under lazy's lua/ tree).
require("scratch.core.keymaps")

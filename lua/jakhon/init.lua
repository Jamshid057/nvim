require("jakhon.remap")
require("jakhon.set")
require("jakhon.autocmds")
require("jakhon.python").setup()
require("jakhon.lazy_init")

function R(name)
    require("plenary.reload").reload_module(name)
end

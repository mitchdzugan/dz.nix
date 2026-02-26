package = "__"
version = "0.0.1-0"
source = {
  url = "https://github.com/mitchdzugan/free-dom/archive/refs/heads/main.zip",
  dir = "free-dom"
}
description = {
   summary = "html+ for simple UI building",
   detailed = "",
   homepage = "https://github.com/mitchdzugan/free-dom",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
      free_dom = "dist/free-dom.lua"
   }
}

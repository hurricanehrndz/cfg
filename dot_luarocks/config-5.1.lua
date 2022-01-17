lua_version = "5.1"
variables = {
  CMAKE = "env ICU_ROOT=/usr/local/opt/icu4c cmake",
  ICU_INCLUDE_DIR = "/usr/local/opt/icu4c/include",
  ICU_ROOT = "/usr/local/opt/icu4c",
  LUA_LIBDIR = "/usr/local/opt/lua@5.1/lib/",
  LUA_LIBDIR_FILE = "liblua5.1.dylib",
  LIBFLAG = "-bundle -undefined dynamic_lookup -all_load -L/usr/local/opt/icu4c/lib",
}

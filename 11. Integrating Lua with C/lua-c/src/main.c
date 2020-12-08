//
// Created by acakic on 8.12.20..
//

#include "../lib/lua/src/lua.h"
#include "../lib/lua/src/lualib.h"
#include "../lib/lua/src/lauxlib.h"

#include <stdio.h>

void lua_example_dofile(void) {
    // TODO: do some magic
    lua_State* L = luaL_newstate();
    luaL_openlibs(L);
    luaL_dofile(L, "./scripts/factorial.lua");
    lua_close(L);
}

void lua_example_getvar(void) {
    lua_State* L = luaL_newstate();
    luaL_dostring(L, "some_var = 486"); // Executing a Lua string
    lua_getglobal(L, "some_var"); // getting back a global value
    lua_Number some_var_in_c = lua_tonumber(L, -1);
    lua_close(L);
}

int main(int argc, char *argv[]) {
//    lua_example_dofile()
    lua_example_getvar();

    return 0;
}
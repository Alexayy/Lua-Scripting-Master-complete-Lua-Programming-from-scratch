//
// Created by acakic on 8.12.20..
//

#include "../lib/lua/src/lua.h"
#include "../lib/lua/src/lualib.h"
#include "../lib/lua/src/lauxlib.h"

#include <stdio.h>

void lua_example_dofile(void) {
    lua_State* L = luaL_newstate();
    luaL_openlibs(L);
    luaL_dofile(L, "./scripts/factorial.lua");
    lua_close(L);
}

void lua_example_getvar(void) {
    lua_State* L = luaL_newstate();
    luaL_dostring(L, "some_var = 486"); // Executing a Lua string
    lua_getglobal(L, "some_var"); // getting back a global value
    lua_Number some_var_in_c = lua_tonumber(L, -1); // -1 is the last position of the stack

    printf("The value of some var inside C is: %d\n", (int)some_var_in_c);

    lua_close(L);
}

void lua_example_stack(void) {
    lua_State* L = luaL_newstate();

    lua_pushnumber(L, 286); // stack[1] or stack position [-3]
    lua_pushnumber(L, 28386); // stack[2] or stack position [-2]
    lua_pushnumber(L, 386); // stack[3] or stack position [-1]

    lua_Number element;
    element = lua_tonumber(L, -1); // Peaking instruction

    printf("The last added element in position 3 of the stack is: %d\n", (int)element);

    lua_remove(L, 2);
    element = lua_tonumber(L, 2);
    printf("Position 2 of the stack is now: %d\n", (int)element);

    lua_close(L);
}

void lua_example_call_lua_function(void) {
    lua_State* L = luaL_newstate();

    if (luaL_dofile(L, "./scripts/pythagoras.lua") != LUA_OK) {
        luaL_error(L, "Error: %s\n", lua_tostring(L, -1));
    }

    lua_getglobal(L, "pythagoras");

    if (lua_isfunction(L, -1)) {

        lua_pushnumber(L, 3); // First function argument
        lua_pushnumber(L, 4); // Second function argument

        const int NUM_ARG = 2;
        const int NUM_RET = 1;

        if (lua_pcall(L, NUM_ARG, NUM_RET, 0) != LUA_OK ) {
            // TODO: Errors
            printf("You fucked up.");
            luaL_error(L, "Error: %s\n", lua_tostring(L, -1));
        } else {
            lua_Number pythagoras_result = lua_tonumber(L, -1);
            printf("The Pythagoras(3, 4) is: %f\n", (float)pythagoras_result);
        }
    }

    lua_close(L);
}

int native_pythagoras(lua_State* L) {
    lua_Number b = lua_tonumber(L, -1); // Get the last added param from the stack, b
    lua_Number a = lua_tonumber(L, -2); // Get the first added param from the stack, a
    lua_Number result = (a * a) + (b * b);
    lua_pushnumber(L, result);
    return 1; // Returns how many values the function returns to the stack
}

void lua_example_call_c_function(void) {
    lua_State* L = luaL_newstate();

    lua_pushcfunction(L, native_pythagoras);
    lua_setglobal(L, "native_pythagoras");

    luaL_dofile(L, "./scripts/pythagoras-native.lua");
    lua_getglobal(L, "pythagoras");
    if (lua_isfunction(L, -1)) {
        lua_pushnumber(L, 3);
        lua_pushnumber(L, 5);

        const int NUM_ARG = 2;
        const int NUM_RET = 1;
        lua_pcall(L, NUM_ARG, NUM_RET, 0);
        lua_Number pythagoras_result = lua_tonumber(L, -1);

        printf("Native Pythagoras(3, 5) = %f\n", (float)pythagoras_result);
    }

    lua_close(L);
}

typedef struct rectangle2d {
    int x;
    int y;
    int width;
    int height;
} rectangle;

int create_rectangle(lua_State* L) {
    rectangle* rect = (rectangle*)lua_newuserdata(L, sizeof(rectangle));
    rect -> x = 0;
    rect -> y = 0;
    rect -> width = 0;
    rect -> height = 0;

    return 1; // return our own type as new userdata so Lua can access it
}

int change_rectangle_size(lua_State* L) {
    rectangle* rect = (rectangle*)lua_touserdata(L, -3);
    rect -> width = (int)lua_tonumber(L, -2);
    rect -> height = (int)lua_tonumber(L, -1);
    return 0; // Does not return anything back to the stack
}

void lua_example_userdata(void) {
    lua_State* L = luaL_newstate();

    // Exposing the native create rectangle function to lua
    lua_pushcfunction(L, create_rectangle);
    lua_setglobal(L, "create_rectangle");

    // Exposing the native change_rectangle_size functin to Lua
    lua_pushcfunction(L, change_rectangle_size);
    lua_setglobal(L, "change_rectangle_size");

    luaL_dofile(L, "./scripts/rectangle.lua");

    lua_getglobal(L, "square");
    if (lua_isuserdata(L, -1)) {
        rectangle* r = (rectangle*)lua_touserdata(L, -1);
        printf("We got back a rectangle from Lua, width: %d, height: %d\n",
               r -> width, r -> height);
    } else {
        printf("We did not get a rectangle user data");
    }

    lua_close(L);
}

void lua_example_table(void) {
    lua_State* L = luaL_newstate();

    if (luaL_dofile(L, "./scripts/configtable.lua") == LUA_OK) {
        // ...
        lua_getglobal(L, "config_table");

        if (lua_istable(L, -1)) {
            lua_getfield(L, -1, "window_width");
            printf("The window_width defined in the Lua table is: %s\n", lua_tostring(L, -1));
        }

    } else {
        luaL_error(L, "Error: %s\n", lua_tostring(L, -1));
    }

    lua_close(L);
}

int main(int argc, char *argv[]) {
//    lua_example_dofile()
//    lua_example_getvar();
//    lua_example_stack();
//    lua_example_call_lua_function();
//    lua_example_call_c_function();
//    lua_example_userdata();
    lua_example_table();
    return 0;
}
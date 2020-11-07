project(lua C)
cmake_minimum_required(VERSION 3.17)
set(CMAKE_C_STANDARD 99)

set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/build)
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/build)

add_compile_options("$<$<C_COMPILER_ID:MSVC>:/utf-8>")
add_compile_options("$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")

if(WIN32)
    add_definitions( -D_CRT_SECURE_NO_WARNINGS )
endif()

# 1. lua 静态库 重命名为lua
add_library (lualib STATIC src/lapi.c src/lcode.c src/lctype.c src/ldebug.c src/ldo.c src/ldump.c src/lfunc.c src/lgc.c src/llex.c src/lmem.c src/lobject.c src/lopcodes.c src/lparser.c src/lstate.c src/lstring.c src/ltable.c src/ltm.c src/lundump.c src/lvm.c src/lzio.c src/lauxlib.c src/lbaselib.c src/lcorolib.c src/ldblib.c src/liolib.c src/lmathlib.c src/loslib.c src/lstrlib.c src/ltablib.c src/loadlib.c src/linit.c src/lutf8lib.c)
set_target_properties(lualib PROPERTIES OUTPUT_NAME "lua54") # rename the library output name

# 2. lua 解释器
add_executable (lua src/lua.c)
target_link_libraries (lua lualib)
if(UNIX)
    target_link_libraries( lua m )
endif()

# 3. lua编译器
add_executable (luac src/luac.c)
target_link_libraries (luac lualib)
if(UNIX)
    target_link_libraries( luac m )
endif()

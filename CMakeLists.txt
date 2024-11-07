cmake_minimum_required(VERSION 3.16)

set(CMAKE_C_STANDARD 11)
set(LUA_VERSION lua-5.4.7)

project(Lua C)

include_directories( "${CMAKE_CURRENT_SOURCE_DIR}/${LUA_VERSION}/src")
file(GLOB LIB_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/${LUA_VERSION}/src/*.c")
list(REMOVE_ITEM LIB_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/${LUA_VERSION}/src/lua.c" "${CMAKE_CURRENT_SOURCE_DIR}/${LUA_VERSION}/src/onelua.c")

message(STATUS find sources)
foreach (_source IN LISTS LIB_SOURCES)
    message(STATUS "${_source}")
endforeach ()

set(
        LUA_SOURCES
        "${CMAKE_CURRENT_SOURCE_DIR}/${LUA_VERSION}/src/lua.c"
)

set(
        LUAC_SOURCES
        "${CMAKE_CURRENT_SOURCE_DIR}/${LUA_VERSION}/src/luac.c"
)

file(GLOB LUA_INCLUDES "${CMAKE_CURRENT_SOURCE_DIR}/${LUA_VERSION}/src/*.h" "${CMAKE_CURRENT_SOURCE_DIR}/${LUA_VERSION}/src/*.hpp")

if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    add_definitions("/D _CRT_SECURE_NO_WARNINGS")
endif ()

# Lua library
add_library(lualib SHARED ${LIB_SOURCES})
set_target_properties(lualib PROPERTIES OUTPUT_NAME lua)
if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    target_compile_definitions(lualib PUBLIC "LUA_BUILD_AS_DLL")
    message(STATUS LUA_BUILD_AS_DLL)
else()
    target_link_libraries(lualib m)
endif ()
# Lua executable
add_executable(lua ${LUA_SOURCES})
target_link_libraries(lua lualib)

# Lua compiler
# TODO: Can't compile luac dynamically, fails with luaP_opmodes
add_executable(luac ${LUAC_SOURCES} ${LIB_SOURCES})
target_link_libraries(luac lualib)

# Installation of targets
#install(
#        TARGETS lualib lua luac
#        RUNTIME DESTINATION bin
#        LIBRARY DESTINATION lib
#        ARCHIVE DESTINATION lib
#)
#
## Includes
#install(
#        FILES ${LUA_INCLUDES}
#        DESTINATION include
#)


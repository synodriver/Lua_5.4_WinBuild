cmake_minimum_required(VERSION 3.20)

set(CMAKE_C_STANDARD 99)

project(Lua C)

file(GLOB LIB_SOURCES src/*.c)
list(REMOVE_ITEM LIB_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/lua.c" "${CMAKE_CURRENT_SOURCE_DIR}/src/luac.c")

message(STATUS find sources)
foreach (_source IN LISTS LIB_SOURCES)
    message(STATUS "${_source}")
endforeach ()

set(
        LUA_SOURCES
        src/lua.c
)

set(
        LUAC_SOURCES
        src/luac.c
)

file(GLOB LUA_INCLUDES src/*.h src/*.hpp)

if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    add_definitions("/D _CRT_SECURE_NO_WARNINGS")
endif ()

# Lua library
add_library(lualib SHARED ${LIB_SOURCES})
set_target_properties(lualib PROPERTIES OUTPUT_NAME lua)
if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    target_compile_definitions(lualib PUBLIC "LUA_BUILD_AS_DLL")
    message(STATUS LUA_BUILD_AS_DLL)
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


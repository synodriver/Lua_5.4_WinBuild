file(REMOVE_RECURSE
  "../build/staticbuild/lua.exe"
  "../build/staticbuild/lua.exe.manifest"
  "../build/staticbuild/lua.pdb"
  "CMakeFiles/lua_static.dir/src/lua.c.obj"
  "lua.lib"
)

# Per-language clean rules from dependency scanning.
foreach(lang C)
  include(CMakeFiles/lua_static.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()

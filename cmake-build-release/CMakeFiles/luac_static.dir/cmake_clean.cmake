file(REMOVE_RECURSE
  "../build/staticbuild/luac.exe"
  "../build/staticbuild/luac.exe.manifest"
  "../build/staticbuild/luac.pdb"
  "CMakeFiles/luac_static.dir/src/luac.c.obj"
  "luac.lib"
)

# Per-language clean rules from dependency scanning.
foreach(lang C)
  include(CMakeFiles/luac_static.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()

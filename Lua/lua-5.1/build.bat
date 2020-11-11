@echo off
:: ========================
:: build.bat
::
:: build lua to dist folder
:: tested with lua-5.3.5
:: based on:
:: https://medium.com/@CassiusBenard/lua-basics-windows-7-installation-and-running-lua-files-from-the-command-line-e8196e988d71
:: ========================
setlocal
:: you may change the following variable’s value
:: to suit the downloaded version
set work_dir=%~dp0
:: Removes trailing backslash
:: to enhance readability in the following steps
set work_dir=%work_dir:~0,-1%
set lua_install_dir=%work_dir%\dist
set compiler_bin_dir=%work_dir%\tdm-gcc\bin
set lua_build_dir=%work_dir%
set path=%compiler_bin_dir%;%path%
cd /D %lua_build_dir%
make PLAT=mingw
echo.
echo **** COMPILATION TERMINATED ****
echo.
echo **** BUILDING BINARY DISTRIBUTION ****
echo.
:: create a clean “binary” installation
mkdir %lua_install_dir%
mkdir %lua_install_dir%\doc
mkdir %lua_install_dir%\bin
mkdir %lua_install_dir%\include
mkdir %lua_install_dir%\lib
copy %lua_build_dir%\doc\*.* %lua_install_dir%\doc\*.*
copy %lua_build_dir%\src\*.exe %lua_install_dir%\bin\*.*
copy %lua_build_dir%\src\*.dll %lua_install_dir%\bin\*.*
copy %lua_build_dir%\src\luaconf.h %lua_install_dir%\include\*.*
copy %lua_build_dir%\src\lua.h %lua_install_dir%\include\*.*
copy %lua_build_dir%\src\lualib.h %lua_install_dir%\include\*.*
copy %lua_build_dir%\src\lauxlib.h %lua_install_dir%\include\*.*
copy %lua_build_dir%\src\lua.hpp %lua_install_dir%\include\*.*
copy %lua_build_dir%\src\liblua.a %lua_install_dir%\lib\liblua.a
echo.
echo **** BINARY DISTRIBUTION BUILT ****
echo.
%lua_install_dir%\bin\lua.exe -e "print [[Hello!]];print[[Simple Lua test successful!!!]]"
echo.

:: configure environment variable
:: https://stackoverflow.com/a/21606502/4394850
:: http://lua-users.org/wiki/LuaRocksConfig
:: SETX - Set an environment variable permanently.
:: /m Set the variable in the system environment HKLM.
setx LUA "%lua_install_dir%\bin\lua.exe" /m
setx LUA_BINDIR "%lua_install_dir%\bin" /m
setx LUA_INCDIR "%lua_install_dir%\include" /m
setx LUA_LIBDIR "%lua_install_dir%\lib" /m

pause

@echo off
setlocal

REM Настройка Emscripten
set EMSDK=C:\tmp\emsdk
set EMSCRIPTEN=%EMSDK%\upstream\emscripten
set EMSDK_NODE=%EMSDK%\node\22.16.0_64bit\bin\node.exe
set PATH=%EMSDK%;%EMSCRIPTEN%;%PATH%


set BUILD_DIR=_build_em

cmake.exe --build _build_em --target all

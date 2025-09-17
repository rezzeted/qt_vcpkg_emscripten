@echo off
setlocal

REM Настройка Emscripten
set EMSDK=C:\tmp\emsdk
set EMSCRIPTEN=%EMSDK%\upstream\emscripten
set EMSDK_NODE=%EMSDK%\node\22.16.0_64bit\bin\node.exe
set PATH=%EMSDK%;%EMSCRIPTEN%;%PATH%


set BUILD_DIR=build\WebAssembly_Qt_6_10_0_single_threaded-Debug
set SOURCE_DIR=D:\campus\qt_vcpkg_emscripten

cmake.exe --build D:/campus/qt_vcpkg_emscripten/build/WebAssembly_Qt_6_10_0_single_threaded-Debug --target all

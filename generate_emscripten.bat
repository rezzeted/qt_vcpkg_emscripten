@echo off
setlocal

REM Настройка Emscripten
set EMSDK=C:\tmp\emsdk
set EMSCRIPTEN=%EMSDK%\upstream\emscripten
set EMSDK_NODE=%EMSDK%\node\22.16.0_64bit\bin\node.exe
set PATH=%EMSDK%;%EMSCRIPTEN%;%PATH%

REM Активация Emscripten (если нужна конкретная версия)
REM call %EMSDK%\emsdk.bat activate latest

REM Проверка существования toolchain файла
if not exist "%EMSCRIPTEN%\cmake\Modules\Platform\Emscripten.cmake" (
    echo ERROR: Emscripten toolchain file not found!
    echo Expected at: %EMSCRIPTEN%\cmake\Modules\Platform\Emscripten.cmake
    exit /b 1
)

set BUILD_DIR=build\WebAssembly_Qt_6_10_0_single_threaded-Debug
set SOURCE_DIR=D:\campus\qt_vcpkg_emscripten

if not exist "%BUILD_DIR%" (
    mkdir "%BUILD_DIR%"
)

C:\Qt\Tools\CMake_64\bin\cmake.exe -S %SOURCE_DIR% -B %SOURCE_DIR%\%BUILD_DIR% ^
    "-DCMAKE_PREFIX_PATH:PATH=C:/Qt/6.10.0/wasm_singlethread" ^
    "-DCMAKE_C_COMPILER:FILEPATH=%EMSCRIPTEN%/emcc.bat" ^
    "-DCMAKE_CXX_COMPILER:FILEPATH=%EMSCRIPTEN%/em++.bat" ^
    "-DCMAKE_TOOLCHAIN_FILE:FILEPATH=C:/Qt/6.10.0/wasm_singlethread/lib/cmake/Qt6/qt.toolchain.cmake" ^
    "-DCMAKE_GENERATOR:STRING=Ninja" ^
    "-DCMAKE_BUILD_TYPE:STRING=Debug" ^
    "-DQT_QMAKE_EXECUTABLE:FILEPATH=C:/Qt/6.10.0/wasm_singlethread/bin/qmake.bat" ^
    "-DQT_MAINTENANCE_TOOL:FILEPATH=C:/Qt/MaintenanceTool.exe" ^
    "-DCMAKE_CXX_FLAGS_INIT:STRING=-DQT_QML_DEBUG" ^
    "-DCMAKE_COLOR_DIAGNOSTICS:BOOL=ON"
# Main toolchain file that combines Qt and vcpkg for Emscripten
set(CMAKE_SYSTEM_NAME Emscripten)
set(CMAKE_SYSTEM_VERSION 1)

# Установка triplet ДО подключения vcpkg
set(VCPKG_TARGET_TRIPLET "wasm32-emscripten")

# Путь к vcpkg
set(VCPKG_ROOT "${CMAKE_CURRENT_LIST_DIR}/toolchain/vcpkg")

# Подключаем vcpkg toolchain
if(EXISTS "${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
    include("${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
else()
    message(FATAL_ERROR "vcpkg toolchain not found at: ${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
endif()

# Подключаем Qt toolchain
set(QT_TOOLCHAIN_PATH "C:/Qt/6.10.0/wasm_singlethread/lib/cmake/Qt6/qt.toolchain.cmake")
if(EXISTS "${QT_TOOLCHAIN_PATH}")
    include("${QT_TOOLCHAIN_PATH}")
endif()
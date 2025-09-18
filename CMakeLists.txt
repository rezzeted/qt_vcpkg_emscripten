cmake_minimum_required(VERSION 3.16)

project(qt_app VERSION 0.1 LANGUAGES CXX)

# Укажи toolchain для WebAssembly
set(CMAKE_TOOLCHAIN_FILE "C:/Qt/6.10.0/wasm_singlethread/lib/cmake/Qt6/qt.toolchain.cmake" CACHE FILEPATH "Qt Toolchain")

#
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(boost_uuid CONFIG REQUIRED)

qt_standard_project_setup(REQUIRES 6.8)



if(EMSCRIPTEN)
  add_compile_options(-sDISABLE_EXCEPTION_CATCHING=1)

  # Флаги линковщика для Emscripten
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -sWASM=1") 
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -sNO_DISABLE_EXCEPTION_CATCHING") 
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -sALLOW_MEMORY_GROWTH=1") 
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -sFORCE_FILESYSTEM=1") 
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -sNO_EXIT_RUNTIME=0") 
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -sASSERTIONS=1") 
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -sEXPORTED_FUNCTIONS=_main") 
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -sEXPORTED_RUNTIME_METHODS=ccall,cwrap") 
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lembind") 
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -sFETCH -sFILESYSTEM=1")
  
  # WebGL 2.0 для Qt
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -sFULL_ES2 -sMIN_WEBGL_VERSION=2 -sMAX_WEBGL_VERSION=2")
  
  # Дополнительные флаги для Qt под Emscripten
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -sUSE_WEBGL2=1")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -sUSE_SDL=2")
  
  message(STATUS "Emscripten build configured with Qt support")
endif()



qt_add_executable(appqt_app
    main.cpp
)

qt_add_qml_module(appqt_app
    URI qt_app
    VERSION 1.0
    QML_FILES
        Main.qml
)

target_link_libraries(appqt_app
    PRIVATE Qt6::Quick
    Boost::uuid
)

# Исправление проблемы с библиотекой atomic в Emscripten
if(EMSCRIPTEN)
    # В Emscripten атомарные операции встроены в компилятор
    # Удаляем ссылку на несуществующую библиотеку atomic
    set_target_properties(Boost::uuid PROPERTIES
        INTERFACE_LINK_LIBRARIES "Boost::assert;Boost::config;Boost::throw_exception;Boost::type_traits"
    )
endif()


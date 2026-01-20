cmake_minimum_required(VERSION 3.31)
project(hardwareinfo) #${project_name}


set(CMAKE_EXPORT_COMPILE_COMMANDS on)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED on)
set(QT_QML_GENERATE_QMLLS_INI on)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Qml Gui)
find_package(amd_smi REQUIRED CONFIG)
qt_standard_project_setup(REQUIRES 6.9)
qt_add_qml_module(
   hardwareinfo
   URI Vixhardware
   VERSION 1.0
   OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/Vixhardware"
   SOURCES
     ./include/Cpu.hpp
     ./src/Cpu.cpp

     ./include/Ram.hpp
     ./src/Ram.cpp

     ./include/Gpu.hpp
     ./src/Gpu.cpp
)
target_include_directories(hardwareinfo PRIVATE  ./include)

target_link_libraries(
   hardwareinfo
   PRIVATE Qt6::Core Qt6::Qml Qt6::Quick Qt6::Gui
   PRIVATE amd_smi
)

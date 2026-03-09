cmake_minimum_required(VERSION 3.16)
project({project_name} LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS
   Core
)
qt6_policy(SET QTP0001 NEW)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED on)
set(CMAKE_AUTOMOC ON)

target_link_libraries({project_name} PRIVATE
   Qt6::Core
)

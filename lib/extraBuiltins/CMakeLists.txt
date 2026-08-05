cmake_minimum_required(VERSION 3.16)
project(nix-plugin LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED on)

find_package(PkgConfig)
pkg_check_modules(NIX REQUIRED nix-expr)


add_library(greenlib MODULE main.cpp)
target_include_directories(greenlib PUBLIC ${NIX_INCLUDE_DIRS})
target_compile_options(greenlib PUBLIC ${NIX_CFLAGS_OTHER})

install(TARGETS greenlib DESTINATION lib/nix/plugins)

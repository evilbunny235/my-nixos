cmake_minimum_required(VERSION 3.29)

add_compile_options(-Wall -Wextra -pedantic)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED True)

project(test)
add_executable(test src/main.cpp)


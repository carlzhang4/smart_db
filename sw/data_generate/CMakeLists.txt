cmake_minimum_required(VERSION 3.2)
set(CMAKE_CXX_STANDARD 11)

project(data_gen LANGUAGES CXX)

set(SOURCE_FILES
	main.cpp
	bench.cpp
	bench_simple.cpp
	bench_dual_mem.cpp
	bench_block_handler.cpp
)

ADD_DEFINITIONS("-g")

LINK_DIRECTORIES(/usr/lib64/cj)

ADD_EXECUTABLE(data_gen ${SOURCE_FILES})

TARGET_LINK_LIBRARIES(data_gen hw)
TARGET_LINK_LIBRARIES(data_gen common)

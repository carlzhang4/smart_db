cmake_minimum_required(VERSION 3.2)
set(CMAKE_CXX_STANDARD 11)

project(cj LANGUAGES CXX)

set(HW_FILES
	hardware.cpp
)

set(COMMON_FILES
	common.cpp
)

set(HEAD_FILES 
	hardware.hpp
	common.hpp
)

add_library(hw SHARED ${HW_FILES})
add_library(common SHARED ${COMMON_FILES})

install(
	TARGETS hw common
	DESTINATION /usr/lib64/cj
)

install(
	FILES ${HEAD_FILES}
	DESTINATION /usr/include/cj
)
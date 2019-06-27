cmake_minimum_required(VERSION 3.10) # 3.13 later, then 3.14

project(LearnCPP)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY  "${CMAKE_BINARY_DIR}/output/$<CONFIG>")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY  "${CMAKE_BINARY_DIR}/output/$<CONFIG>")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY  "${CMAKE_BINARY_DIR}/output/$<CONFIG>")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(source_code_ide)
include(copy)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

add_subdirectory(templates/parameter_pack)
add_subdirectory(templates/integer_sequence)
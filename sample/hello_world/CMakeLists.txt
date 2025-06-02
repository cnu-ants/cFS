cmake_minimum_required(VERSION 2.6.4)
project(CFE_HELLO_WORLD C)

include_directories(fsw/inc)

aux_source_directory(fsw/src APP_SRC_FILES)

set(APP_NAME "hello_world")
set(SOURCE_FILES 
    fsw/src/hello_world.c
)

exll_cfe_app(hello_world1 ${APP_SRC_FILES})
add_cfe_app(hello_world1 ${APP_SRC_FILES})

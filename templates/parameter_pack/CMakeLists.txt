# see https://en.cppreference.com/w/cpp/language/parameter_pack

set(TARGET_NAME parameter_pack)
add_executable(${TARGET_NAME} main.cpp)

set_target_properties(${TARGET_NAME} 
    PROPERTIES
        FOLDER  templates/${TARGET_NAME}
)


set(TARGET_NAME integer_sequence)
add_executable(${TARGET_NAME} main.cpp)

set_target_properties(${TARGET_NAME} 
    PROPERTIES
        FOLDER  templates/${TARGET_NAME}
)


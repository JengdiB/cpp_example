include_guard()
#this file is meant to hold code dedicated to copy files to the underlaying layout

function(copy_dirs_to_runtime_dir)
    set(options "")
    set(oneValueArgs "")
    set(multiValueArgs DIRS CONFIGURATIONS)
    cmake_parse_arguments(ARGS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    list(APPEND AVAILABLE_CONFIGURATIONS "Release" "Debug")

    if(NOT DEFINED ARGS_DIRS)
        message(WARNING "copy_dirs_to_runtime_dir was not given any directory to copy")
        return()
    endif()

    if(NOT CMAKE_BUILD_TYPE)
        if(NOT DEFINED ARGS_CONFIGURATIONS)
            list(APPEND ARGS_CONFIGURATIONS ${AVAILABLE_CONFIGURATIONS})
        endif()
        
        foreach(CONFIGURATION ${ARGS_CONFIGURATIONS})
            if(${CONFIGURATION} IN_LIST ARGS_CONFIGURATIONS)
                file(
                    COPY
                        ${ARGS_DIRS}
                    DESTINATION
                        ${CMAKE_BINARY_DIR}/output/${CONFIGURATION}
                )
            endif()
        endforeach()
    else()
        file(
            COPY
                ${ARGS_DIRS}
            DESTINATION
                ${CMAKE_BINARY_DIR}/output/${CMAKE_BUILD_TYPE}
        )
    endif(NOT CMAKE_BUILD_TYPE)
endfunction()

function(copy_to_runtime_dir)
    set(options "")
    set(oneValueArgs "" )
    set(multiValueArgs FILES)
    cmake_parse_arguments(C2RD "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    copy_binary_to_configs(
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/output
        CONFIGS ${CMAKE_CONFIGURATION_TYPES}
        FILES ${C2RD_FILES}
        WHITELIST_CONFIGS ${CMAKE_CONFIGURATION_TYPES}
    )
endfunction()

function(copy_dir)
    set(options RECURSIVE)
    set(oneValueArgs DIR DESTINATION )
    set(multiValueArgs RELATIVE_TO) # to make optional, but only one value
    cmake_parse_arguments(MY_COPY "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    # glob input files
    if(MY_COPY_RECURSIVE)
        file(GLOB_RECURSE FILES ${MY_COPY_DIR}/*)
    else()
        file(GLOB FILES ${MY_COPY_DIR}/*)
    endif()

    if(MY_COPY_RELATIVE_TO)
        get_filename_component(REL ${MY_COPY_RELATIVE_TO} ABSOLUTE)
        string(LENGTH ${REL} it1)
    else()
        set(it1 0)
    endif()

    message(STATUS "copy ${MY_COPY_DIRIR} to ${MY_COPY_DESTINATION}")

    foreach(FILE IN ITEMS ${FILES})

        # remove relative path
        get_filename_component(FILE ${FILE} ABSOLUTE)
        string(LENGTH ${FILE} it2)
        string(SUBSTRING ${FILE} ${it1} ${it2} TO)

        # copy to destination
        if(MY_COPY_RELATIVE_TO)

            get_filename_component(TARGET ${MY_COPY_DESTINATION}${TO} DIRECTORY)

        else()
            get_filename_component(TARGET ${MY_COPY_DESTINATION}${TO} DIRECTORY)
        endif()

        # message(STATUS "copy  ${FILE} to ${TARGET}")
        file_copy(${FILE} ${TARGET})
    endforeach()

endfunction()
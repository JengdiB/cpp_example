include_guard()

function(viz_source_code_ide_impl files paths PREFIX)

    # message("files: "${files})
    # message("paths: "${paths})

    foreach(file ${files})
        set (placed FALSE)
        foreach(path ${paths})
            get_filename_component(FILE_ABS ${file} ABSOLUTE)
            get_filename_component(PATH_ABS ${path} ABSOLUTE)

            if (FILE_ABS MATCHES "${PATH_ABS}/.*")
                file(RELATIVE_PATH FILEPATH ${path} ${FILE_ABS})
                get_filename_component(PATH ${FILEPATH} DIRECTORY)
                #message("${file} => ${PATH}")
                 STRING(REPLACE "/" "\\" FILTERS "${PATH}")
                SOURCE_GROUP(${PREFIX}\\${FILTERS} FILES ${file})
                set (placed TRUE)
            endif()
        endforeach()

        if (NOT ${placed})
            # this should not be a problem it will show up by default in the folder root
        #    message("not in path: ${file}  ->${paths}<-")

        endif()
    endforeach()
endfunction()

# adds support to show in IDE all files from a project, sorted in folders
# to automatize this, the folders will be the ones in the filesystem
# otherwise we willhave to maintain an artifical list which will only create
# trouble
# usage:
# viz_source_code_ide(SOURCES ${SRCS} HEADERS ${HEADERS} SOURCES_PATHS ${CMAKE_CURRENT_LIST_DIR} HEADERS_PATHS ${CMAKE_CURRENT_LIST_DIR})
function(viz_source_code_ide)

    cmake_parse_arguments(IDE "" "" "SOURCES;HEADERS;HEADERS_PATHS;SOURCES_PATHS" ${ARGN} )

    set(SPATH ${CMAKE_CURRENT_LIST_DIR})
    if (IDE_SOURCES_PATHS)
        set(SPATH ${IDE_SOURCES_PATHS})
    endif()
    if (IDE_SOURCES)
        set(SOURCES ${IDE_SOURCES})
    else()
        file(GLOB_RECURSE SOURCES RELATIVE ${CMAKE_CURRENT_LIST_DIR} *.cpp *.cc *.cxx)
    endif()
    viz_source_code_ide_impl("${SOURCES}" "${SPATH}" "Source Files")

    set(HPATH ${CMAKE_CURRENT_LIST_DIR})
    if (IDE_HEADERS_PATHS)
        set(HPATH ${IDE_HEADERS_PATHS})
    endif()
    if (IDE_HEADERS)
        set(HEADERS ${IDE_HEADERS})
    else()
        file(GLOB_RECURSE HEADERS RELATIVE ${CMAKE_CURRENT_LIST_DIR} *.h *.hpp)
    endif()
    viz_source_code_ide_impl("${HEADERS}" "${HPATH}" "Source Files")

endfunction()



function(viz_make_ide_folders_ext files)
    foreach(source IN LISTS files)
        get_filename_component(source_path "${source}" PATH)
        string(REPLACE "/" "\\" source_path_msvc "${source_path}")
        string(REPLACE "/" "\\" root_path "${CMAKE_CURRENT_SOURCE_DIR}")
        string(REPLACE ${root_path} "" relativePath "${source_path_msvc}")
        source_group("${relativePath}" FILES "${source}")
    endforeach()
endfunction()

function(viz_make_ide_folders)
    foreach(source IN LISTS SRCS)
        get_filename_component(source_path "${source}" PATH)
        string(REPLACE "/" "\\" source_path_msvc "${source_path}")
        string(REPLACE "/" "\\" root_path "${CMAKE_CURRENT_SOURCE_DIR}")
        string(REPLACE ${root_path} "" relativePath "${source_path_msvc}")
        source_group("${relativePath}" FILES "${source}")
    endforeach()

    foreach(source IN LISTS HEADERS)
    get_filename_component(source_path "${source}" PATH)
    string(REPLACE "/" "\\" source_path_msvc "${source_path}")
    string(REPLACE "/" "\\" root_path "${CMAKE_CURRENT_SOURCE_DIR}")
    string(REPLACE ${root_path} "" relativePath "${source_path_msvc}")
    source_group("${relativePath}" FILES "${source}")
    endforeach()
endfunction()

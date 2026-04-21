# Define library with existing source files
add_library(nexflow_common STATIC
    src/logging.cpp
    src/utils.cpp
)

target_include_directories(nexflow_common PUBLIC
    ${CMAKE_SOURCE_DIR}/common/include
)

target_link_libraries(nexflow_common
    OpenSSL::Crypto
)

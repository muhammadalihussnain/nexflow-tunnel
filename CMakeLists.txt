cmake_minimum_required(VERSION 3.20)
project(nexflow_tunnel VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    add_compile_options(
        -Wall -Wextra -Wpedantic -Wshadow
        -Wformat=2 -Werror
    )
endif()

find_package(OpenSSL REQUIRED)

add_subdirectory(common)
add_subdirectory(containers/nexflow-data-plane)

# Other containers disabled for Container A development
# add_subdirectory(containers/nexflow-control-plane)
# add_subdirectory(containers/nexflow-auth-engine)
# add_subdirectory(containers/nexflow-routing)
# add_subdirectory(containers/nexflow-client-mgr)
# add_subdirectory(containers/nexflow-monitoring)

# Tests disabled for now
# enable_testing()
# add_subdirectory(tests)

configure_file(
    ${CMAKE_SOURCE_DIR}/common/include/nexflow/version.h.in
    ${CMAKE_BINARY_DIR}/generated/nexflow/version.h
)

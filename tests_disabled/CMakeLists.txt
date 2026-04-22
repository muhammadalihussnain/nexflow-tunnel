# Google Test
include(FetchContent)
FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG v1.14.0
)
FetchContent_MakeAvailable(googletest)

# Test executable
add_executable(nexflow_tests
    unit/tun_device_test.cpp
    unit/crypto_test.cpp
    integration/udp_test.cpp
)

target_link_libraries(nexflow_tests
    nexflow_common
    gtest_main
    pthread
)

include(GoogleTest)
gtest_discover_tests(nexflow_tests)

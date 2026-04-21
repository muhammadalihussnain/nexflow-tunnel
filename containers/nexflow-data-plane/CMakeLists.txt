add_executable(nexflow_data_plane
    src/main.cpp
)

target_include_directories(nexflow_data_plane PRIVATE
    ${CMAKE_SOURCE_DIR}/containers/nexflow-data-plane/include
    ${CMAKE_SOURCE_DIR}/common/include
    ${CMAKE_BINARY_DIR}/generated
)

target_link_libraries(nexflow_data_plane
    nexflow_common
    OpenSSL::Crypto
    pthread
)

install(TARGETS nexflow_data_plane DESTINATION bin)

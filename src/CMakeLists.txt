add_executable(stm32_exe "main.cpp")
target_link_libraries(stm32_exe PRIVATE stm32_project_options stm32_project_warnings board)

target_find_dependencies(stm32_exe PRIVATE_CONFIG fmt)
target_link_system_libraries(stm32_exe PRIVATE fmt::fmt)

add_subdirectory(board)
target_link_libraries(stm32_exe PRIVATE board)
add_executable(stm32_exe "main.cpp")
target_link_libraries(stm32_exe PRIVATE stm32_project_options stm32_project_warnings board)

add_subdirectory(board)
target_link_libraries(stm32_exe PRIVATE board)
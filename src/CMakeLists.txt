add_executable(stm32_exe "main.cpp")
target_link_libraries(stm32_exe PRIVATE stm32_project_options stm32_project_warnings STM32::F1 STM32::NoSys)

target_find_dependencies(stm32_exe PRIVATE_CONFIG fmt)
target_link_system_libraries(stm32_exe PRIVATE fmt::fmt)
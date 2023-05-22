include_guard()

if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
    set(CMAKE_CROSSCOMPILING OFF CACHE BOOL "")
endif()

set(CMAKE_SYSTEM_NAME Generic CACHE STRING "")
set(CMAKE_SYSTEM_PROCESSOR arm CACHE STRING "")

string(APPEND VCPKG_C_FLAGS " --specs=nosys.specs")
string(APPEND VCPKG_CXX_FLAGS " --specs=nosys.specs")
string(APPEND VCPKG_LINKER_FLAGS " --specs=nosys.specs")

# Set compiler flags for target
# -Wall: all warnings activated
# -ffunction-sections -fdata-sections: remove unused code
string(APPEND VCPKG_C_FLAGS " -mthumb -Wall -ffunction-sections -fdata-sections")
string(APPEND VCPKG_CXX_FLAGS " -mthumb -Wall -ffunction-sections -fdata-sections")
# Set linker flags
# -mthumb: Generate thumb code
# -Wl,--gc-sections: Remove unused code
string(APPEND VCPKG_LINKER_FLAGS " -mthumb -Wl,--gc-sections")

if(VCPKG_TARGET_ARCHITECTURE STREQUAL "cortex-m3")
   string(APPEND VCPKG_C_FLAGS " -mcpu=cortex-m3")
   string(APPEND VCPKG_CXX_FLAGS " -mcpu=cortex-m3")
elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "cortex-m4")
   string(APPEND VCPKG_C_FLAGS " -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard")
   string(APPEND VCPKG_CXX_FLAGS " -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard")
endif()

if(NOT DEFINED CMAKE_CXX_COMPILER)
    set(CMAKE_CXX_COMPILER "arm-none-eabi-g++")
endif()
if(NOT DEFINED CMAKE_C_COMPILER)
    set(CMAKE_C_COMPILER "arm-none-eabi-gcc")
endif()
if(NOT DEFINED CMAKE_ASM_COMPILER)
    set(CMAKE_ASM_COMPILER "arm-none-eabi-gcc")
endif()
if(NOT DEFINED CMAKE_ASM-ATT_COMPILER)
    set(CMAKE_ASM-ATT_COMPILER "arm-none-eabi-as")
endif()
message(STATUS "Cross compiling arm on host x86_64, use cross compiler: ${CMAKE_CXX_COMPILER}/${CMAKE_C_COMPILER}")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

get_property(_CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE)
if(NOT _CMAKE_IN_TRY_COMPILE)
    string(APPEND CMAKE_C_FLAGS_INIT " -fPIC ${VCPKG_C_FLAGS} ")
    string(APPEND CMAKE_CXX_FLAGS_INIT " -fPIC ${VCPKG_CXX_FLAGS} ")
    string(APPEND CMAKE_C_FLAGS_DEBUG_INIT " ${VCPKG_C_FLAGS_DEBUG} ")
    string(APPEND CMAKE_CXX_FLAGS_DEBUG_INIT " ${VCPKG_CXX_FLAGS_DEBUG} ")
    string(APPEND CMAKE_C_FLAGS_RELEASE_INIT " ${VCPKG_C_FLAGS_RELEASE} ")
    string(APPEND CMAKE_CXX_FLAGS_RELEASE_INIT " ${VCPKG_CXX_FLAGS_RELEASE} ")

    string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT " ${VCPKG_LINKER_FLAGS} ")
    string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " ${VCPKG_LINKER_FLAGS} ")
    if(VCPKG_CRT_LINKAGE STREQUAL "static")
        string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT "-static ")
        string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT "-static ")
    endif()
    string(APPEND CMAKE_SHARED_LINKER_FLAGS_DEBUG_INIT " ${VCPKG_LINKER_FLAGS_DEBUG} ")
    string(APPEND CMAKE_EXE_LINKER_FLAGS_DEBUG_INIT " ${VCPKG_LINKER_FLAGS_DEBUG} ")
    string(APPEND CMAKE_SHARED_LINKER_FLAGS_RELEASE_INIT " ${VCPKG_LINKER_FLAGS_RELEASE} ")
    string(APPEND CMAKE_EXE_LINKER_FLAGS_RELEASE_INIT " ${VCPKG_LINKER_FLAGS_RELEASE} ")
endif()
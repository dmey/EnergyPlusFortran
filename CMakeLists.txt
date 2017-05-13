# This CMake file was specially created to build the Core EnergyPlus tool
# This file is a compilation of the CMake files used to build the release
# Energy Plus Release 8.1.0.009.
CMAKE_MINIMUM_REQUIRED(VERSION 3.0)
PROJECT(EnergyPlus Fortran C)

# https://github.com/llvm-mirror/llvm/blob/632c2834200b33571d51b91164efe5b8c6c44150/CMakeLists.txt#L52-L55
IF (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  MESSAGE(STATUS "No build type selected, default to Debug")
  SET(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Build type (default Debug)" FORCE)
ENDIF()


SET( USE_SQLIGHT TRUE CACHE BOOL "Use SQLITE?" )

IF (USE_SQLIGHT)
	ADD_SUBDIRECTORY(external/SQLite)
ENDIF()

ADD_SUBDIRECTORY(src)
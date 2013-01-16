cmake_minimum_required(VERSION 2.8)
project(SmallVCM)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

set(SOURCE
	src/smallvcm.cxx
)

set(HEADERS
	src/bsdf.hxx
	src/camera.hxx
	src/config.hxx
	src/eyelight.hxx
	src/frame.hxx
	src/framebuffer.hxx
	src/geometry.hxx
	src/hashgrid.hxx
	src/html_writer.hxx
	src/lights.hxx
	src/materials.hxx
	src/math.hxx
	src/pathtracer.hxx
	src/ray.hxx
	src/renderer.hxx
	src/rng.hxx
	src/scene.hxx
	src/smallvcm.cxx
	src/utils.hxx
	src/vertexcm.hxx
)

# C++11 support
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
	if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
		option(USE_LIBCPP "Use libc++ implementation with Clang" ON)
	else()
		option(USE_LIBCPP "Use libc++ implementation with Clang" OFF)
	endif()
	if(USE_LIBCPP)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
	endif()
endif()

# OpenCL support
option(USE_OPENCL "Enable OpenCL support" ON)
if(USE_OPENCL)
	find_package(OpenCL)
endif()

# OpenMP support
option(USE_OPENMP "Enable OpenMP support" ON)
if(USE_OPENMP)
	find_package(OpenMP)
	if(OPENMP_FOUND)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
	endif()
endif()

# Configuration file
set(HAVE_OPENCL ${OPENCL_FOUND})
set(HAVE_OPENMP ${OPENMP_FOUND})
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/src/platform.hxx.in ${CMAKE_CURRENT_BINARY_DIR}/src/platform.hxx @ONLY)

# Build paths
include_directories(
	${CMAKE_CURRENT_BINARY_DIR}/src
	${OPENCL_INCLUDE_DIRS}
)

add_executable(
	smallvcm
	WIN32
	MACOSX_BUNDLE
	${SOURCE}
	${HEADERS}
)

target_link_libraries(
	smallvcm
	${OPENCL_LIBRARIES}
)

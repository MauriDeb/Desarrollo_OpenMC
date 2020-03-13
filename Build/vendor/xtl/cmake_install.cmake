# Install script for directory: /home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/mauricio/.local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/xtl" TYPE FILE FILES
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xany.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xbasic_fixed_string.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xbase64.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xclosure.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xcomplex.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xcomplex_sequence.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xdynamic_bitset.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xfunctional.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xhash.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xhierarchy_generator.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xiterator_base.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xjson.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xmeta_utils.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xoptional.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xoptional_sequence.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xproxy_wrapper.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xsequence.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xtl_config.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xtype_traits.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xvariant.hpp"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/vendor/xtl/include/xtl/xvariant_impl.hpp"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/xtl" TYPE FILE FILES
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/Build/vendor/xtl/xtlConfig.cmake"
    "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/Build/vendor/xtl/xtlConfigVersion.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/xtl/xtlTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/xtl/xtlTargets.cmake"
         "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/Build/vendor/xtl/CMakeFiles/Export/lib/cmake/xtl/xtlTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/xtl/xtlTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/xtl/xtlTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/xtl" TYPE FILE FILES "/home/mauricio/Proyecto/GitHub_OpenMC/Desarrollo/Build/vendor/xtl/CMakeFiles/Export/lib/cmake/xtl/xtlTargets.cmake")
endif()


# EnergyPlusFortran

[![Build status](https://ci.appveyor.com/api/projects/status/8r2m9y8rr8tu9omc?svg=true)](https://ci.appveyor.com/project/dmey/energyplusfortran)
[![Build Status](https://travis-ci.org/dmey/EnergyPlusFortran.svg?branch=master)](https://travis-ci.org/dmey/EnergyPlusFortran)

This repository is a fork of [NREL's EnergyPlusRelease Fortran version 8.1.0.009](https://github.com/NREL/EnergyPlusRelease/tree/1ba8474958dbac5a371362731b23310d40e0635d).
Some of the missing files which could not be located in the original repository above, were added from the [nrgsim EnergyPlus-Fortran repository](https://github.com/nrgsim/EnergyPlus-Fortran/tree/ba8b3c6e053f02055ee83cff6218b800b7304635) and [SQLite](https://sqlite.org/download.html).

EnergyPlusFortran compiles the standalone EnergyPlus program `energyplus` plus a static library (`libenergyplus.a`) containing all public functions.

# Build instructions for Windows, Linux and macOS

To build the EnergyPlus executable and library, run the following commands:

```sh
$ mkdir build && cd build
$ cmake ..
$ cmake --build .
```

The `energyplus` program and the `libenergyplus.a` library can be found in the `build` folder after compilation.

## Tested Environments

EnergyPlusFortran was tested to work on the following systems:

- Windows: Visual Studio 2010 or above with Intel® Parallel Studio XE 2013 or above and Visual Studio Integration
- Linux: Intel® Parallel Studio XE 2013 or above, or GCC with gfortran 4.8 or above
- macOS: Intel® Parallel Studio XE Composer Edition for Fortran macOS 2013 or above, or GCC with gfortran 4.8 or above

### Note for Windows Users

Make sure you have installed the Intel® Visual Studio Integration plugins or CMake will not be able to identify your compiler (`No CMAKE_Fortran_COMPILER could be found` error).
Make sure that you use Intel® Command-Line Window when launching CMake - The Intel® compiler provides a command-line window with the appropriate environment variables already set (see: [Using the Intel® Command-Line Window](https://software.intel.com/en-us/node/522358)).
You may also need to specify the generator flag `-G` in CMake; for example, if you are using Intel® Command-Line Window for Visual Studio 2010, then the CMake command should now be `cmake -G "Visual Studio 10 2010" ..`. For more information on how to specify generators in CMake see [cmake-generators](https://cmake.org/cmake/help/latest/manual/cmake-generators.7.html#visual-studio-generators).

### Additional Notes

The instructions outlined above are for compiling EnergyPlus without the External Interface (`ExternalInterface.f90` was renamed `ExternalInterface.f90_off`).
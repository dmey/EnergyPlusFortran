FIND_PACKAGE (Threads)

IF(CMAKE_Fortran_COMPILER_ID MATCHES "GNU")
    SET(dialect "-ffree-line-length-none -ffree-form -std=gnu -fimplicit-none -cpp")
    SET(bounds "-fbounds-check")
ENDIF()
IF(CMAKE_Fortran_COMPILER_ID MATCHES "Intel")
	IF(WIN32)
		SET(dialect "/free /fp:strict /fpp /MP")
		SET(bounds "/check:bounds")
	ELSE()
		SET(dialect "-free -fp-model strict -implicitnone -fpp")
		SET(bounds "-check bounds")
	ENDIF()
ENDIF()

SET(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} ${bounds}")
SET(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${dialect}")

SET( DISABLE_PSYCHROMETRICS_CACHE FALSE CACHE BOOL "Disable Psychrometrics Cache")
if (DISABLE_PSYCHROMETRICS_CACHE)
	ADD_DEFINITIONS(-DEP_nocache_Psychrometrics)
ENDIF()

SET( CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/fmodules )
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})

FILE(GLOB ep_src *.f90 *.h)
LIST( REMOVE_ITEM ep_src EnergyPlus.f90 )

SET( USE_DELIGHT FALSE CACHE BOOL "Use Delight?" )

FOREACH(f ${ep_src}) 
	IF( ${f}  MATCHES ".*DElightManagerF.f90" )
		IF(NOT USE_DELIGHT)
			LIST( REMOVE_ITEM ep_src ${f} )
		ENDIF(NOT USE_DELIGHT)
	ENDIF( ${f}  MATCHES ".*DElightManagerF.f90" )
	
	IF( ${f}  MATCHES ".*SQLiteFortranRoutines.f90" )
		IF(NOT USE_SQLIGHT)
			LIST( REMOVE_ITEM ep_src ${f} )
		ENDIF(NOT USE_SQLIGHT)
	ENDIF( ${f}  MATCHES ".*SQLiteFortranRoutines.f90" )
	IF( ${f}  MATCHES ".*SQLiteFortranRoutines_NO.f90" )
		IF(USE_SQLIGHT)
			LIST( REMOVE_ITEM ep_src ${f} )
		ENDIF(USE_SQLIGHT)
	ENDIF( ${f}  MATCHES ".*SQLiteFortranRoutines_NO.f90" )

	
	IF( ${f}  MATCHES ".*CVFOnlyRoutines.f90" )
		LIST( REMOVE_ITEM ep_src ${f} )
	ENDIF( ${f}  MATCHES ".*CVFOnlyRoutines.f90" )
ENDFOREACH(f)

SOURCE_GROUP( energyplus FILES ${ep_src} )

ADD_LIBRARY( energyplus STATIC ${ep_src} )
TARGET_LINK_LIBRARIES( energyplus ${CMAKE_THREAD_LIBS_INIT})

IF(USE_SQLIGHT)
    TARGET_LINK_LIBRARIES( energyplus sqlite3)
ENDIF()

ADD_EXECUTABLE( energyplus-bin EnergyPlus.f90 )
TARGET_LINK_LIBRARIES( energyplus-bin energyplus )
SET_TARGET_PROPERTIES( energyplus-bin
  PROPERTIES OUTPUT_NAME energyplus)

INSTALL(TARGETS energyplus-bin energyplus
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib)
		
# Install Fortran mod files, see https://cmake.org/pipermail/cmake/2010-May/037106.html
INSTALL ( CODE
  "EXECUTE_PROCESS (COMMAND \"${CMAKE_COMMAND}\" -E copy_directory \"${CMAKE_Fortran_MODULE_DIRECTORY}/\${BUILD_TYPE}\" \"${CMAKE_INSTALL_PREFIX}/mod\")"
)
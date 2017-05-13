FIND_PACKAGE (Threads)

SET( sql_src 
    src/sqlite3.c
    src/sqlite3.h
    src/SQLiteCRoutines.c
    src/SQLiteCRoutines.h
    src/strings.h
)
# not using extensions, and by omitting we remove the need to link to -ldl
ADD_DEFINITIONS(-DSQLITE_OMIT_LOAD_EXTENSION)
INCLUDE_DIRECTORIES(src)
ADD_LIBRARY(sqlite3 STATIC ${sql_src})
TARGET_LINK_LIBRARIES( sqlite3 ${CMAKE_THREAD_LIBS_INIT})
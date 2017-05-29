#!/bin/bash
set -e

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then

    case "${COMPENV}" in
        GCC)
            export FC=gfortran
            echo "GCC - nothing to do"
            ;;
        Intel)
            export FC=ifort
            pushd /tmp
            wget http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11537/parallel_studio_xe_2017_update4_cluster_edition_online.tgz
            tar -zxvf parallel_studio_xe_2017_update4_cluster_edition_online.tgz
            cd parallel_studio_xe_2017_update4_cluster_edition_online
            sed "s/__serial_number__/${ACTIVATION_SERIAL_NUMBER}/" ${TRAVIS_BUILD_DIR}/.travis/intel_silent_linux.cfg > ${TRAVIS_BUILD_DIR}/.travis/temp_intel_silent_linux.cfg
            sudo ./install.sh --silent ${TRAVIS_BUILD_DIR}/.travis/temp_intel_silent_linux.cfg | sed "s/${ACTIVATION_SERIAL_NUMBER}/***/"
            source /opt/intel/bin/compilervars.sh intel64
            popd
            ;;
    esac
elif [[ $TRAVIS_OS_NAME == 'osx' ]]; then

        case "${COMPENV}" in
        GCC)
            export FC=gfortran         
            brew update
            brew install gcc@4.8
            ln -s /usr/local/bin/gfortran-4.8 /usr/local/bin/gfortran
            ;;
        Intel)
            export FC=ifort
            pushd /tmp
            curl -O http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11561/m_fcompxe_online_2017.4.049.dmg
            hdiutil attach m_fcompxe_online_2017.4.049.dmg
            sed "s/__serial_number__/${ACTIVATION_SERIAL_NUMBER_OSX}/" ${TRAVIS_BUILD_DIR}/.travis/intel_silent_osx.cfg > ${TRAVIS_BUILD_DIR}/.travis/temp_intel_silent_osx.cfg
            sudo /Volumes/m_fcompxe_online_2017.4.049/m_fcompxe_online_2017.4.049.app/Contents/MacOS/install.sh --silent ${TRAVIS_BUILD_DIR}/.travis/temp_intel_silent_osx.cfg | sed "s/${ACTIVATION_SERIAL_NUMBER_OSX}/***/"
            popd
            ;;
        esac
else
    echo "The environment is not recognised"
fi
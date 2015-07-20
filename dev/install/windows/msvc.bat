:: Run this batch file from VS2013 x64 Native Tools Command Prompt

set MSYS=C:\msys64\mingw64\bin

pushd ..\..\lib\msvc

:: ------------------------------

call :genlib  tbb                       tbb
call :genlib  libbz2-1                  bz2
call :genlib  zlib1                     zlib
call :genlib  libcairo-2                cairo
call :genlib  libassimp                 assimp
call :genlib  libmpg123-0               mpg123
call :genlib  libintl-8                 libintl
call :genlib  libsndfile-1              sndfile
call :genlib  libusb-1.0                usb-1.0
call :genlib  libeay32                  libeay32
call :genlib  ssleay32                  ssleay32
call :genlib  OpenAL32                  OpenAL32
call :genlib  libpixman-1-0             pixman-1
call :genlib  libfreetype-6             freetype
call :genlib  libfontconfig-1           fontconfig
call :genlib  libopencv_ml2411          opencv_ml
call :genlib  libopencv_gpu2411         opencv_gpu
call :genlib  libopencv_ocl2411         opencv_ocl
call :genlib  libopencv_viz2411         opencv_viz
call :genlib  libopencv_core2411        opencv_core
call :genlib  libopencv_flann2411       opencv_flann
call :genlib  libopencv_photo2411       opencv_photo
call :genlib  libopencv_video2411       opencv_video
call :genlib  opencv_ffmpeg2411_64      opencv_ffmpeg
call :genlib  libopencv_legacy2411      opencv_legacy
call :genlib  libopencv_imgproc2411     opencv_imgproc
call :genlib  libopencv_nonfree2411     opencv_nonfree
call :genlib  libopencv_highgui2411     opencv_highgui
call :genlib  libopencv_calib3d2411     opencv_calib3d
call :genlib  libopencv_contrib2411     opencv_contrib
call :genlib  libopencv_superres2411    opencv_superres
call :genlib  libopencv_videostab2411   opencv_videostab
call :genlib  libopencv_objdetect2411   opencv_objdetect
call :genlib  libopencv_stitching2411   opencv_stitching
call :genlib  libopencv_features2d2411  opencv_features2d

:: ------------------------------

for %%i in (*.exp) do call rm %%i
for %%i in (*.def) do call rm %%i

popd
goto :eof

:genlib
    gendef %MSYS%/%1.dll
    lib /def:%1.def /machine:x64
    call ren %1.lib %2.lib
goto :eof
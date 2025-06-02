set(CMAKE_SYSTEM_NAME Linux)

set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)

# LLVM IR 생성 옵션
set(CMAKE_C_FLAGS "-O0 -emit-llvm -S")
set(CMAKE_CXX_FLAGS "-O0 -emit-llvm -S")

# 빌드 아웃풋을 .ll로 저장
set(CMAKE_OUTPUT_EXTENSION_REPLACE 1)

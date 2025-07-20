cd $HOME/GitRepos/zig/
rm -rf build
mkdir build
cd build
cmake .. -DCMAKE_PREFIX_PATH=$HOME/local/llvm19-assert
make install

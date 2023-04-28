# AlGO-RUST-BERT-DEMO


### Docker operation
```bash
docker build -t algo-rust-bert-demo:1 .

docker run -it algo-rust-bert-demo:1 /bin/sh

export LIBTORCH=$(python3 -c 'import torch; from pathlib import Path; print(Path(torch.__file__).parent)')
export DYLD_LIBRARY_PATH=${LIBTORCH}/lib
export LD_LIBRARY_PATH=${LIBTORCH}/lib:$LD_LIBRARY_PATH
export LIBTORCH_CXX11_ABI=0
```

### Docker for amd OS
```bash
docker build -t algo-rust-bert-demo:1 -f  ./Dockerfile.amd .
```

### Mac M2

```bash 
// install torch(v0.13.1)
pip install torch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1

// set env
export LIBTORCH=$(python3 -c 'import torch; from pathlib import Path; print(Path(torch.__file__).parent)')
export DYLD_LIBRARY_PATH=${LIBTORCH}/lib
export LD_LIBRARY_PATH=${LIBTORCH}/lib:$LD_LIBRARY_PATH
```
![m2-cargo-build-issue](/docs/m2-cargo-build-issue.png)

![torch-rs](/docs/torch-rs.png)

### Mac local rust bert model

**model address**
```bash
ls $HOME/Library/Caches/.rustbert
```

**git push large data to github**
```bash
 git lfs install

```

**Reference**

- [pytorch locally](https://pytorch.org/get-started/locally/)
- [tch-rs does not run on m1 mac](https://github.com/LaurentMazare/tch-rs/issues/629)
- [Docker最佳实践](https://dunwu.github.io/linux-tutorial/docker/docker-dockerfile.html#arg-%E6%9E%84%E5%BB%BA%E5%8F%82%E6%95%B0)
- [Rust cargo book](https://llever.com/cargo-book-zh/getting-started/installation.zh.html)
- [Failed to run custom build command for openssl-sys v0.9.80](https://github.com/sfackler/rust-openssl/issues/1853)
- [Rust编译Linux通用可执行文件](https://note.qidong.name/2023/03/rust-universal-bin/)
- [macos-cross-toolchains](https://github.com/messense/homebrew-macos-cross-toolchains)
- [rust-bert](https://github.com/guillaume-be/rust-bert)
- [Writing dockerfile in rust project](https://windsoilder.github.io/writing_dockerfile_in_rust_project.html)
- [medium-rust-dockerize](https://github.com/mr-pascal/medium-rust-dockerize/blob/master/Dockerfile)
- [Create an Optimized Rust Alpine Docker Image](https://levelup.gitconnected.com/create-an-optimized-rust-alpine-docker-image-1940db638a6c)

**mac m config**
- [Unable to compile torch-sys](https://github.com/LaurentMazare/tch-rs/issues/671)
- [tch crates](https://crates.io/crates/tch/0.10.3)
- [tch-rs does not run on m1 mac](https://github.com/LaurentMazare/tch-rs/issues/629)


**amd os**
- [Compile for arm64 raspberry pi](https://github.com/LaurentMazare/tch-rs/issues/498)
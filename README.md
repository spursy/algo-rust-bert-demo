# AlGO-RUST-BERT-DEMO

## Docker operation

```bash
docker build -t algo-rust-bert-demo:1 .
docker run -it algo-rust-bert-demo:1 /bin/sh

export LIBTORCH=$(python -c 'import torch; from pathlib import Path; print(Path(torch.__file__).parent)')
export DYLD_LIBRARY_PATH=${LIBTORCH}/lib
export LD_LIBRARY_PATH=${LIBTORCH}/lib:$LD_LIBRARY_PATH
export LIBTORCH_CXX11_ABI=0
```

### Docker for AMD OS

```bash
docker build -t algo-rust-bert-demo:1 -f  ./Dockerfile.amd .
```

### Docker for ARM OS

```bash
docker build -t algo-rust-bert-demo:1 -f  ./Dockerfile.arm .
```

### Mac M2

```bash
// create micro pythin env
micromamba env create -f environment.yml --platform osx-arm64

// install torch(v0.13.1)
pip install torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0

// set env
export LIBTORCH=$(python3 -c 'import torch; from pathlib import Path; print(Path(torch.__file__).parent)')
export DYLD_LIBRARY_PATH=${LIBTORCH}/lib
export LD_LIBRARY_PATH=${LIBTORCH}/lib:$LD_LIBRARY_PATH
export LIBTORCH_CXX11_ABI=0

// verify mac python architecture
python -c "import sysconfig;print(sysconfig.get_platform())"
// verify mac architecture
uname -m 

// verify torch package
python -c "import torch;print(torch.__version__);"
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
 
 git lfs track "./resources/all-MiniLM-L12-v2/rust_model.ot"

 // rollback large fs
 git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch ./resources/all-MiniLM-L12-v2/rust_model.ot'
 
 git add .gitattributes
  
 git commit -m "extend lfs conf"
 
 git push origin master
```

```bash
// install micromamba with homebrew
brew install micromamba

// create a new conda environment: 
micromamba env create -f environment.yml --platform osx-arm64

// activate the new environment
micromamba activate tch-rs-demo
```

```bash
import torch
 
# 查看torch版本
print('--- torch版本 ---')
print(torch.__version__)
 
# 查看cuda版本
print('--- cuda版本 ---')
print(torch.version.cuda)
 
# GPU是否可用
print('--- GPU是否可用 ---')
print(torch.cuda.is_available())
 
# 返回gpu数量
print('--- GPU数量 ---')
print(torch.cuda.device_count())
 
# 返回gpu名字，设备索引默认从0开始
print('--- GPU名称 ---')
n = 0
while n < torch.cuda.device_count():
    print(torch.cuda.get_device_name(n))
    n += 1
 
# 代码测试
print('--- PyTorch代码测试 ---')
print(torch.rand(3,3))
print('--- PyTorch代码测试（在GPU上测试PyTorch代码） ---')
print(torch.rand(3,3).cuda())
```

### OnnxRuntime
```bash
wget -O  onnxruntime-arm.tgz  https://github.com/microsoft/onnxruntime/releases/download/v1.18.1/onnxruntime-osx-arm64-1.18.1.tgz
tar -zxvf onnxruntime-arm.tgz
export ORT_DYLIB_PATH=......../onnxruntime-osx-arm64-1.18.1/lib/libonnxruntime.dylib
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
- [Demo of tch-rs on M1](https://github.com/ssoudan/tch-m1)

**mac m silicon config**

- [Unable to compile torch-sys](https://github.com/LaurentMazare/tch-rs/issues/671)
- [tch crates](https://crates.io/crates/tch/0.10.3)
- [tch-rs does not run on m1 mac](https://github.com/LaurentMazare/tch-rs/issues/629)

**amd os**

- [Compile for arm64 raspberry pi](https://github.com/LaurentMazare/tch-rs/issues/498)
- [Fixing the “GH001: Large files detected. You may want to try Git Large File Storage.”](https://marcosantonocito.medium.com/fixing-the-gh001-large-files-detected-you-may-want-to-try-git-large-file-storage-43336b983272)

**onnx runtime reference**
- [onnx runtime release list](https://github.com/microsoft/onnxruntime/releases?page=1)

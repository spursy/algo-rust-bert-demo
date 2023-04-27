# AlGO-RUST-BERT-DEMO



```bash
docker build -t algo-rust-bert-demo:1 .

docker run -it algo-rust-bert-demo:1 /bin/sh

export LIBTORCH=$(python3 -c 'import torch; from pathlib import Path; print(Path(torch.__file__).parent)')
export DYLD_LIBRARY_PATH=${LIBTORCH}/lib
export LD_LIBRARY_PATH=${LIBTORCH}/lib:$LD_LIBRARY_PATH
```

**Reference**

- [pytorch locally](https://pytorch.org/get-started/locally/)
- [tch-rs does not run on m1 mac](https://github.com/LaurentMazare/tch-rs/issues/629)
- [Docker最佳实践](https://dunwu.github.io/linux-tutorial/docker/docker-dockerfile.html#arg-%E6%9E%84%E5%BB%BA%E5%8F%82%E6%95%B0)
- [Rust cargo book](https://llever.com/cargo-book-zh/getting-started/installation.zh.html)
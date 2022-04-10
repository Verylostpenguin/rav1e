FROM fuzzers/cargo-fuzz:0.10.0

ADD . /rav1e
WORKDIR /rav1e
RUN rustup toolchain install nightly
WORKDIR /rav1e/fuzz
RUN apt-get update
RUN apt-get -y install alien libclang-dev clang
RUN curl --ssl-no-revoke -LO https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/linux/nasm-2.15.05-0.fc31.x86_64.rpm
RUN alien -i nasm-2.15.05-0.fc31.x86_64.rpm
RUN curl -LJO https://www.deb-multimedia.org/pool/main/d/dav1d-dmo/libdav1d5_0.9.0-dmo0~bpo10+1_amd64.deb
RUN dpkg -i libdav1d5_0.9.0-dmo0~bpo10+1_amd64.deb
RUN curl -LJO https://www.deb-multimedia.org/pool/main/d/dav1d-dmo/libdav1d-dev_0.9.0-dmo0~bpo10+1_amd64.deb
RUN dpkg -i libdav1d-dev_0.9.0-dmo0~bpo10+1_amd64.deb
RUN RUSTFLAGS="-Znew-llvm-pass-manager=no" cargo +nightly fuzz build

# Set to fuzz!
ENTRYPOINT []
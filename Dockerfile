FROM ubuntu:20.04
COPY --from=builder /usr/local /usr/local

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    wget \
    git \
    curl \
    make \
    cmake \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    python3 \
    python3-pip 
    
ENV SOFT /soft
RUN mkdir -p $SOFT

# Установка samtools + htslib + libdeflate
RUN git clone https://github.com/samtools/samtools.git $SOFT/samtools-br230401 && \
    cd $SOFT/samtools-br230401 && \
    git checkout 1.17 && \
    make -j$(nproc) && \
    make install

# Установка bcftools
RUN git clone https://github.com/samtools/bcftools.git $SOFT/bcftools-br230401 && \
    cd $SOFT/bcftools-br230401 && \
    git checkout 1.17 && \
    make -j$(nproc) && \
    make install

# Установка vcftools
RUN git clone https://github.com/vcftools/vcftools.git $SOFT/vcftools-br230401 && \
    cd $SOFT/vcftools-br230401 && \
    git checkout 0.1.17 && \
    make -j$(nproc) && \
    make install


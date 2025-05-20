FROM ubuntu:20.04
COPY --from=builder /usr/local /usr/local

ENV SOFT /soft
RUN mkdir -p $SOFT

RUN git clone https://github.com/samtools/samtools.git $SOFT/samtools-br230401 && \
    cd $SOFT/samtools-br230401 && \
    git checkout 1.17 && \
    make -j$(nproc) && \
    make install

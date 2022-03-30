ARG STACK_VERSION
FROM scalingo/scalingo-$STACK_VERSION:latest

ARG VIPS_PREFIX=/usr/local/vips
ARG VIPS_VERSION=8.12.2
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

WORKDIR /usr/local/src

RUN curl -sLO ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
  && tar xzf vips-${VIPS_VERSION}.tar.gz \
  && cd vips-${VIPS_VERSION} \
  && ./configure --prefix=$VIPS_PREFIX \
  && make V=0 \
  && make install

# Some cleaning:
RUN cd $VIPS_PREFIX \
  && strip lib/*.a lib/lib*.so*

ARG STACK_VERSION
RUN cd $VIPS_PREFIX \
  && rm -rf build \
  && mkdir build \
  && tar czf "build/scalingo-${STACK_VERSION}_vips-${VIPS_VERSION}.tar.gz" bin include lib

FROM ghcr.io/gleam-lang/gleam:v1.4.1-erlang-alpine

# Add project code
COPY . /build/

# Compile the project
RUN cd /build \
  && gleam export erlang-shipment \
  && mv build/erlang-shipment /app 

RUN mkdir /app/styles
RUN cd /build/src/pages && find . -name '*.css' -exec cp --parents \{\} /app/styles \;

RUN rm -r /build

# Run the server
WORKDIR /app
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["run"]
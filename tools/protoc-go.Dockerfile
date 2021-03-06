FROM golang:1.14

RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /protobuf

RUN wget -q -O protoc-temp.zip \
        https://github.com/protocolbuffers/protobuf/releases/download/v3.9.1/protoc-3.9.1-linux-x86_64.zip \
    && unzip -q protoc-temp.zip \
    && rm protoc-temp.zip

WORKDIR /code
RUN go mod init github.com/rez-go/crux-apis

RUN go get github.com/golang/protobuf/protoc-gen-go

RUN go get github.com/gogo/protobuf/protoc-gen-gogofaster

RUN go get github.com/uber/prototool/cmd/prototool

WORKDIR /go
RUN rm -rf /code

ENV PATH="/protobuf/bin:${PATH}"

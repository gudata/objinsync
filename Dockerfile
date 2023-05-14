FROM golang:1.20.3 as build
LABEL org.opencontainers.image.source https://github.com/scribd/objinsync
ADD . /app
WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags '-extldflags "-static"'

FROM alpine:3.10.1

# RUN addgroup --gid 0 root && \
RUN adduser --system --uid 50000 --ingroup root airflow

USER airflow

COPY --from=build /app/objinsync /bin/objinsync

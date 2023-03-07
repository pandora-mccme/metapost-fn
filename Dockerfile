FROM --platform=${TARGETPLATFORM:-linux/amd64} ghcr.io/openfaas/classic-watchdog:0.1.4 as watchdog

# FROM --platform=${TARGETPLATFORM:-linux/amd64} alpine:3.14
FROM ubuntu

RUN apt-get update && apt-get install -y \
    texlive-metapost \
    pdf2svg

RUN mkdir -p /home/app

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

# Add non root user
RUN adduser --system --group app
RUN chown app /home/app

WORKDIR /home/app

USER app

COPY function.sh /home/app/function.sh
ENV fprocess="bash /home/app/function.sh"

ENV write_debug="false"
ENV combine_output="false"

EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
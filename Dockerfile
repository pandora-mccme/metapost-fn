FROM ubuntu

RUN apt-get update && apt-get install -y \
    texlive-metapost \
    pdf2svg
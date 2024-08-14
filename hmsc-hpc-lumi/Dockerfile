FROM docker.io/rocm/tensorflow:rocm5.6-tf2.12-dev

# Pip install
ENV PIP_NO_CACHE_DIR=1
RUN python3 -m pip install \
        tensorflow_probability==0.20.0

RUN python3 -m pip install \
        numpy==1.22.4 \
        git+https://github.com/trossi/rdata.git@test-for-hmsc-v2

RUN python3 -m pip install --no-dependencies \
        git+https://github.com/trossi/hmsc-hpc.git@simplify-io

ENTRYPOINT ["python3"]
CMD ["--help"]

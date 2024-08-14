ARG CONDA_VERSION=py312_24.5.0-0

#########################################
# Conda environment
#########################################
FROM docker.io/ubuntu:20.04 AS conda

ENV DEBIAN_FRONTEND=noninteractive

# Install general utilities
RUN apt-get update -qy && \
    apt-get install -qy --no-install-recommends \
        less \
        tar gzip unzip \
        wget ca-certificates \
        && \
    apt-get clean

# Install conda
ARG CONDA_VERSION
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-$CONDA_VERSION-Linux-x86_64.sh -O conda.sh && \
    bash conda.sh -b -p /conda && \
    rm conda.sh && \
    /conda/bin/conda clean -afy

# Create base R environment
ARG R_VERSION
RUN . /conda/etc/profile.d/conda.sh && \
    conda create -p /conda/env -c conda-forge --override-channels --no-default-packages \
        r-base=$R_VERSION \
        && \
    /conda/bin/conda clean -afy

# Install common conda-available packages
RUN . /conda/etc/profile.d/conda.sh && \
    conda activate /conda/env && \
    conda install -c conda-forge --override-channels \
        r-devtools \
        r-remotes \
        r-rcpp \
        && \
    /conda/bin/conda clean -afy

# Install reticulate
RUN . /conda/etc/profile.d/conda.sh && \
    conda activate /conda/env && \
    conda install -c conda-forge --override-channels \
        r-reticulate \
        r-tensorflow \
        && \
    /conda/bin/conda clean -afy

# Install other conda-available packages
RUN . /conda/etc/profile.d/conda.sh && \
    conda activate /conda/env && \
    conda install -c conda-forge --override-channels \
        r-jsonify \
        r-vioplot \
        r-abind \
        r-MASS \
        r-survival \
        r-MatrixModels \
        r-Matrix \
        r-SparseM \
        r-colorspace \
        r-viridisLite \
        r-RColorBrewer \
        r-munsell \
        r-labeling \
        r-farver \
        r-nlme \
        r-dotCall64 \
        r-plyr \
        r-quantreg \
        r-mcmc \
        r-coda \
        r-scales \
        r-mgcv \
        r-isoband \
        r-gtable \
        r-maps \
        r-spam \
        r-truncnorm \
        r-statmod \
        r-sp \
        r-pROC \
        r-pracma \
        r-nnet \
        r-MCMCpack \
        r-ggplot2 \
        r-FNN \
        r-fields \
        r-BayesLogit \
        r-ape \
        && \
    /conda/bin/conda clean -afy

# Install non-conda-available packages
RUN . /conda/etc/profile.d/conda.sh && \
    conda activate /conda/env && \
    Rscript -e 'devtools::install_github("hmsc-r/HMSC")' && \
    /conda/bin/conda clean -afy

# Clean files not needed runtime
RUN find -L /conda/env/ -type f -name '*.a' -delete -print && \
    find -L /conda/env/ -type f -name '*.js.map' -delete -print


#########################################
# Final container image
#########################################
FROM docker.io/rocm/tensorflow:rocm5.6-tf2.12-dev

ENV DEBIAN_FRONTEND=noninteractive

# Install general utilities
RUN apt-get update -qy && \
    apt-get install -qy --no-install-recommends \
        less \
        tar gzip unzip \
        && \
    apt-get clean

# Pip install
ENV PIP_NO_CACHE_DIR=1
RUN python3 -m pip install \
        tensorflow_probability==0.20.0

RUN python3 -m pip install \
        numpy==1.22.4 \
        git+https://github.com/trossi/rdata.git@test-for-hmsc-v1

RUN python3 -m pip install --no-dependencies \
        git+https://github.com/trossi/hmsc-hpc.git@simplify-io

COPY --from=conda /conda/env/ /conda/env/

ENV PROJ_DATA=/conda/env/share/proj \
    PATH=/conda/env/bin:$PATH \
    LC_ALL=C.UTF-8

ENTRYPOINT ["python3"]
CMD ["--help"]

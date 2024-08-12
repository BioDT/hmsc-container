ARG CONDA_VERSION=py311_23.9.0-0

#########################################
# Base
#########################################
FROM docker.io/opensuse/leap:15.4 AS base

# Install general utilities:
#   - R depends on which
#   - R help needs less
#   - r-devtools needs tar etc
RUN zypper refresh && \
    zypper --non-interactive install \
        which less \
        tar gzip unzip \
        && \
    zypper clean --all


#########################################
# Conda environment
#########################################
FROM base AS conda

# Install conda
ARG CONDA_VERSION
RUN curl https://repo.anaconda.com/miniconda/Miniconda3-$CONDA_VERSION-Linux-x86_64.sh -o conda.sh && \
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
FROM base

COPY --from=conda /conda/env/ /conda/env/

ENV PROJ_DATA=/conda/env/share/proj \
    PATH=/conda/env/bin:$PATH \
    LC_ALL=C.UTF-8

ENTRYPOINT ["Rscript"]
CMD ["--help"]

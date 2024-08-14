# Example

## Using docker and separate containers

```bash
alias docker_run='docker run -it --rm -v "$PWD:$PWD:Z" -w "$PWD"'

docker_run ghcr.io/biodt/hmsc-r:0.1.2   01_prepare.R
mv Rplots.pdf Rplots_R.pdf

docker_run ghcr.io/biodt/hmsc-hpc:0.1.0 02_run.py

docker_run ghcr.io/biodt/hmsc-r:0.1.2   03_postprocess.R
mv Rplots.pdf Rplots_HPC.pdf
```

## Using docker and single container

```bash
alias docker_run='docker run -it --rm -v "$PWD:$PWD:Z" -w "$PWD"'

docker_run --entrypoint Rscript ghcr.io/biodt/hmsc-full:0.1.0 01_prepare.R
mv Rplots.pdf Rplots_R.pdf

docker_run --entrypoint python  ghcr.io/biodt/hmsc-full:0.1.0 02_run.py

docker_run --entrypoint Rscript ghcr.io/biodt/hmsc-full:0.1.0 03_postprocess.R
mv Rplots.pdf Rplots_HPC.pdf
```

## Using singularity and single container on LUMI-G

```bash
sbatch submit.lumi.sh
```

## Reticulate demo on LUMI-G

```bash
sbatch submit_reticulate.lumi.sh
```

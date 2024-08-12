# Example

Run the scripts with docker as follows:

```bash
alias docker_run='docker run -it --rm -v "$PWD:$PWD:Z" -w "$PWD"'

docker_run ghcr.io/biodt/hmsc-r:0.1.2   01_prepare.R
mv Rplots.pdf Rplots_R.pdf

docker_run ghcr.io/biodt/hmsc-hpc:0.1.0 02_run.py

docker_run ghcr.io/biodt/hmsc-r:0.1.2   03_postprocess.R
mv Rplots.pdf Rplots_HPC.pdf
```

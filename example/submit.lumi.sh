#!/bin/bash -l
#SBATCH -J hmsc-test
#SBATCH -o %x.out
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=00:15:00
#SBATCH --partition=dev-g

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export SINGULARITY_BIND="/pfs,/scratch,/projappl,/project,/flash,/appl"
# export TF_FORCE_GPU_ALLOW_GROWTH=true

singularity exec ../hmsc-full_0.1.0.sif Rscript 01_prepare.R
mv Rplots.pdf Rplots_R.pdf

singularity exec ../hmsc-full_0.1.0.sif python  02_run.py

singularity exec ../hmsc-full_0.1.0.sif Rscript 03_postprocess.R
mv Rplots.pdf Rplots_HPC.pdf

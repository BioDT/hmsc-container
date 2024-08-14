#!/bin/bash -l
#SBATCH -J reticulate-test
#SBATCH -o %x.out
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=00:15:00
#SBATCH --partition=dev-g

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export SINGULARITY_BIND="/pfs,/scratch,/projappl,/project,/flash,/appl"

singularity exec ../hmsc-full_0.1.0.sif Rscript reticulate.R

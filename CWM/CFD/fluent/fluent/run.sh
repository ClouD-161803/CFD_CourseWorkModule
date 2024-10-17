#!/bin/bash

#SBATCH --time=00:30:00
#SBATCH --job-name=project1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=htc

module purge
module load fluent/19.2
module load intel-compilers/2019
module load intel-mpi/2019

fluent 3ddp -g -mpi=intel -t1 -i rib.jou > fluent.out

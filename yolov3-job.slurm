#!/bin/bash
###############################################################################
### Batch script to run darknet at dkrz mistral
### Author: Frank Röder
###############################################################################
# Submit job: sbatch yolov3-job.slurm
#SBATCH --partition=gpu
#SBATCH --account=ku0598
#SBATCH --nodes=1
#SBATCH --time=12:00:00
#SBATCH --mail-type=END
#SBATCH --output=job_%j.out
#SBATCH --error=err_%j.out
#SBATCH --job-name=darknet-yolov3
srun hostname

# Setup environment
GCC_VERSION=7.1.0
export CUDA_VERSION=9.2.148
CUDNN_VERSERION=cudnn-7.4-for-cuda-9.2
module load gcc/$GCC_VERSION
export MODULEPATH=$MODULEPATH:/mnt/lustre01/work/ku0598/software/modulefiles
module load cuda/$CUDA_VERSION
module load cudnn/$CUDNN_VERSERION
export PATH="$HOME/bin:$PATH"

make
# srun darknet detector train cfg/obj.data cfg/objv3.cfg darknet53.conv.74
srun darknet detector train cfg/obj.data cfg/objv3.cfg backup/objv3.backup

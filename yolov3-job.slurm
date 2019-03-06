#!/bin/bash
###############################################################################
### Batch script to run darknet at dkrz mistral
### Author: Frank Röder
###############################################################################
# Submit job: sbatch yolov3-job.slurm
#SBATCH --partition=gpu
#SBATCH --account=ku0598
#SBATCH --nodes=1
#SBATCH --nodelist=mg102
#SBATCH --mem=8192
#SBATCH --time=12:00:00
#SBATCH --mail-type=ERR,END
#SBATCH --output=job_%j.out
#SBATCH --error=err_%j.out
#SBATCH --job-name=darknet-yolov3
srun hostname

# Setup environment
GCC_VERSION=7.1.0
export CUDA_VERSION=10.0.130
CUDNN_VERSERION=cudnn-7.4-for-cuda-10.0
module load gcc/$GCC_VERSION
export MODULEPATH=$MODULEPATH:/mnt/lustre01/work/ku0598/software/modulefiles
module load cuda/$CUDA_VERSION
module load cudnn/$CUDNN_VERSERION

make
srun nvidia-smi && \
  srun darknet detector valid cfg/obj.data cfg/objv3.cfg backup/objv3.backup
  # srun darknet detector train cfg/obj.data cfg/objv3.cfg backup/objv3.backup -gpus 0,1,2,3
  # srun darknet detector train cfg/obj.data cfg/objv3.cfg -gpus 0,1,2,3
  # srun darknet detector test cfg/obj.data cfg/objv3.cfg backup/objv3.backup test.png -gpu 0,1,2,3

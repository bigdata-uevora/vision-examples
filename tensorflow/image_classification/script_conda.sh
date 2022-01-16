#!/bin/bash
#SBATCH --job-name=img_class_conda     # create a short name for your job
#SBATCH --output="slurm-img_class-conda-%j.out"  	  # %j will be replaced by the slurm jobID
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=4        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --gres=gpu:2             # number of gpus per node


source /opt/conda/bin/activate
conda activate tf-gpu

python image_classification.py

deactivate

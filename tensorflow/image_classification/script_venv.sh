#!/bin/bash
#SBATCH --job-name=igm_class_venv     # create a short name for your job
#SBATCH --output="slurm-igm_class-venv-%j.out"  	  # %j will be replaced by the slurm jobID
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=4        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --gres=gpu:2             # number of gpus per node


source venv/bin/activate

python image_classification.py

deactivate

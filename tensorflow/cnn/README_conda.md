# Slurm and Conda
To submit a Python application that uses Conda for dependency management and project isolation as a Slurm job, you need to perform the following tasks:

1. Create the Conda environment
2. Install the project dependencies
3. Define the Slurm job script
4. Submit the Slurm job

## Creating the Conda environment
To submit this project in slurm using Conda, you should start activating conda:

```shell
$ source /opt/conda/etc/profile.d/conda.sh
```

then create the Conda environment:

```
(base) $ conda create -n tf-gpu tensorflow-gpu
```

After creating the Conda environment, you should activate it:

```shell
(base) $ conda activate tf-gpu
```

and install the project dependencies:

```shell
(tf-gpu) $ pip install tensorflow==2.7.0
(tf-gpu) $ pip install matplotlib
```

After installing all dependencies, you should deactivate the virtual environment:
```shell
(tf-gpu) $ conda deactivate
```

## Configure the Slurm job script

### Example
The following file ([script_conda.sh](script_conda.sh)) is of a Slurm job script to run this project:

```bash
#!/bin/bash
#SBATCH --job-name=cnn           # create a short name for your job
#SBATCH --output="slurm-cnn-conda-%j.out"	 # %j will be replaced by the slurm jobID
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=4        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --gres=gpu:2             # number of gpus per node

source /opt/conda/bin/activate
conda activate tf-gpu

python cnn.py

conda deactivate
```

In the first part of the script, we define the job name, the output file and the requested resources (4 CPUs and 2 GPUs). Then, in the second part, we define the tasks of the job. When using Python Virtual Environments, we should do the following:

1. Activate the Conda environment;
2. Excecute the code;
3. Deactivate Conda  environment;

## Submit the job
```bash
$ sbatch script_conda.sh
Submitted batch job 144
```

check the job status:
```bash
$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
               143     batch      cnn    drwho  R       0:33      1 vision2
```

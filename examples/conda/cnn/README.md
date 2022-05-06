This is an example on how to submit a Slurm job which uses Conda for dependency management. This example uses TensorFlow and is based on the official examples from TensorFlow: https://www.tensorflow.org/tutorials/images/cnn.

# Conda installation
Conda is available in all nodes of Vision (head and compute nodes) in ```/opt/conda/```. You can use this Conda version, or if you prefer, can install another version in your home folder: https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html.

In this example we use Conda installed in ```/opt/conda/```.

# Slurm and Conda



To submit a Python application that uses Conda for dependency management and project isolation as a Slurm job, you need to perform the following tasks:

1. Create the Conda environment with the project dependencies
2. Define the Slurm job script
3. Submit the Slurm job

## 1. Creating the Conda environment
To submit this script in Slurm using Conda for dependency management you should start by activating Conda:

```shell
$ source /opt/conda/etc/profile.d/conda.sh
```

and create the Conda environment. To create the Conda environment, you can use

 - create it manually
 - use an envirnment file

### Creating the Conda environment manually
To create the Conda environment manually, you should start by creating the Conda environment:

```shell
(base) $ conda create -n tf-gpu tensorflow-gpu
```

activate the Conda environment:

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

### Creating the Conda environment using an environment file:
To create the Conda environment from the environment file you should run the following command:

```shell
conda env create -f environment.yml
```

This will create a Conda envirnment with the name and dependencies defined in the file environment.yml

## Configure the Slurm job script

### Example
The following file ([script.sh](script.sh)) is of a Slurm job script to run this project:

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

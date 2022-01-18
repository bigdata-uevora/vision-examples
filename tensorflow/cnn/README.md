# Running a Tensorflow based application as a Slurm job

To run a Tensorflow based aplication as a Slurm job, you have two options to manage the project dependencies and isolation:

1. Using Python's Virtual Environment
2. Using Conda

The recommend method to install Tensorflow is to use pip packages. As such, we recommend to use Python's Virtual Environment instead of conda. If you decide to use Conda, you should use pip to install/upgrade Tensorflow inside the Conda environment

## Slurm and Python's Virtual Environment
To submit a Python application that uses Python's Virtual Environments for dependency management and project isolation as a Slurm job, you need to perform the following tasks:

1. Create the Python Virtual Environment with the project dependencies
2. Define the Slurm job script
3. Submit the Slurm job

### Creating the Python Virtual Environment
To submit this project in slurm using python virtualenv, you should start by creating the virtual env:

```shell
$ python3 -m venv --system-site-packages ./venv
```

After creating the virtual env, you should activate it:

```shell
$ source ./venv/bin/activate
```

upgrade pip:

```shell
(venv) $pip install --upgrade pip
```

and install the project dependencies:

```shell
(venv) $ pip install tensorflow==2.7.0
(venv) $ pip install matplotlib
```

After installing all dependencies, you should deactivate the virtual environment:
```shell
(venv) $ deactivate
```

### Configure the Slurm job script

#### Example
The following file ([script_venv.sh](script_venv.sh)) is of a Slurm job script to run this project:

```bash
#!/bin/bash
#SBATCH --job-name=cnn           # create a short name for your job
#SBATCH --output="slurm-cnn-venv-%j.out"	 # %j will be replaced by the slurm jobID
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=4        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --gres=gpu:2             # number of gpus per node

source venv/bin/activate

python cnn.py

deactivate
```

In the first part of the script, we define the job name, the output file and the requested resources (4 CPUs and 2 GPUs). Then, in the second part, we define the tasks of the job. When using Python Virtual Environments, we should do the following:

1. Activate the Python environment;
2. Excecute the code;
3. Deactivate the Python environment;

### Submit the job
```bash
$ sbatch script_venv.sh
Submitted batch job 143
```

check the job status:
```bash
$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
               143     batch      cnn    drwho  R       0:33      1 vision2
```


## Slurm and Conda
To submit a Python application that uses Conda for dependency management and project isolation as a Slurm job, you need to perform the following tasks:

1. Create the Conda environment with the project dependencies
2. Define the Slurm job script
3. Submit the Slurm job

### Creating the Conda environment
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

### Configure the Slurm job script

#### Example
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

### Submit the job
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

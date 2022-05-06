This is an example on how to submit a Slurm job which uses Python Virtual Environment for dependency management. This example uses TensorFlow and is based in one of the official examples from TensorFlow: https://www.tensorflow.org/tutorials/images/cnn.

# Slurm and Python's Virtual Environment
To submit a Python application that uses Python's Virtual Environments for dependency management and project isolation as a Slurm job, you need to perform the following tasks:

1. Create the Python Virtual Environment with the project dependencies
2. Define the Slurm job script
3. Submit the Slurm job

## 1. Creating the Python Virtual Environment
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
(venv) $ pip install --upgrade pip
```

### Install dependencies
You can install the project dependencies manually or using a requirements file.

#### Install dependencies manually
To install the dependencies manually, you should run:
```shell
(venv) $ pip install tensorflow==2.7.0
(venv) $ pip install matplotlib
```

#### Install dependencies using a dependency file
To install the dependencies using a requirements file, you should run:
```shell
(venv) pip install -r requirements.txt
```

After installing all dependencies, you should deactivate the virtual environment:
```shell
(venv) $ deactivate
```


## 2. Configure the Slurm job script

### Example
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

## 3. Submit the job
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

## Creating the Python Virtual Environment
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

## Configure the Slurm job script

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

## Submit the job
```bash
$ sbatch script_venv.sh
Submitted batch job 143
```

check if the job status:
```bash
$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
               143     batch      cnn    drwho  R       0:33      1 vision2
```


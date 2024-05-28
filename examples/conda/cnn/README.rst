Convolutional Neural Network (CNN)
==================================

This is an example on how to submit a Slurm job which uses Conda for dependency management. This example uses TensorFlow and is based on the official examples from TensorFlow: https://www.tensorflow.org/tutorials/images/cnn.

Conda is available in all nodes of Vision (head and compute nodes) in ``/opt/conda/``. You can use this Conda version, or if you prefer, can install another version in your home folder: https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html.

In this example we use Conda installed in ``/opt/conda/``.

To submit a Python application that uses Conda for dependency management and project isolation as a Slurm job, you need to perform the following tasks:

  #. Create the Conda environment with the project dependencies
  #. Define the Slurm job script
  #. Submit the Slurm job

1. Creating the Conda environment
---------------------------------

To submit this script in Slurm using Conda for dependency management you should start by activating Conda:

.. code-block:: console

  $ source /opt/conda/etc/profile.d/conda.sh

and then create the Conda environment. To create the Conda environment, you can use:

 - create it manually
 - use an envirnment file

Creating the Conda environment manually
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To create the Conda environment manually, you should start by creating the Conda environment:

.. code-block:: console

  (base) $ conda create -n tf-gpu tensorflow-gpu

activate the Conda environment:

.. code-block:: console

  (base) $ conda activate tf-gpu

and install the project dependencies:

.. code-block:: console

  (tf-gpu) $ pip install tensorflow==2.7.0
  (tf-gpu) $ pip install matplotlib

After installing all dependencies, you should deactivate the virtual environment:

.. code-block:: console

  (tf-gpu) $ conda deactivate

Creating the Conda environment using an environment file:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To create the Conda environment from the environment file you should run the following command::

.. code-block:: console

  conda env create -f environment.yml

This will create a Conda envirnment with the name and dependencies defined in the file environment.yml

2. Configure the Slurm job script
---------------------------------

To submit the job, you first have to create a slurm batch script where you have to specify the required resources that will be allocated to your job and specify the tasks that will be run.

The following is a Slurm job script to run this project:

.. code-block:: console

  #!/bin/bash
  #SBATCH --job-name=cnn           # create a short name for your job
  #SBATCH --output="slurm-cnn-conda-%j.out"	 # %j will be replaced by the slurm jobID
  #SBATCH --nodes=1                # node count
  #SBATCH --ntasks=1               # total number of tasks across all nodes
  #SBATCH --cpus-per-task=4        # cpu-cores per task (>1 if multi-threaded tasks)
  #SBATCH --gres=gpu:2             # number of gpus per node

  source /opt/conda/bin/activate
  conda activate tf-gpu

  python3 cnn.py

  conda deactivate

The script is made of two parts: 1) specification of the resources needed as well to run the job as some general job information; and 2) specification of the taks that will be run.

In the first part of the script, we define the job name, the output file and the requested resources (4 CPUs and 2 GPUs). Then, in the second part, we define the tasks of the job. When using Conda, we should run the following:

1. Activate the Conda environment;
2. Excecute the code;
3. Deactivate Conda  environment;

3. Submit the job
-----------------

To submit the job, you should run the following command:

.. code-block:: console

  $ sbatch script_conda.sh
  Submitted batch job 144

You can check the job status using the following command:

.. code-block:: console

  $ squeue
                JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
                143       batch      cnn     user  R       0:33      1 vision2

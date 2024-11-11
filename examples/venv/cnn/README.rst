Convolutional Neural Network (CNN)
==================================

This is an example on how to submit a Slurm job which uses Python Virtual Environment for dependency management. This example uses TensorFlow and is based in one of the official examples from TensorFlow: https://www.tensorflow.org/tutorials/images/cnn.

To submit a Python application that uses Python's Virtual Environments for dependency management and project isolation as a Slurm job, you need to perform the following tasks:

 #. Create the Python Virtual Environment with the project dependencies
 #. Define the Slurm job script
 #. Submit the Slurm job


1. Creating the Python Virtual Environment
------------------------------------------

To submit this project in slurm using python virtualenv, you should start by creating the virtual env:

.. code-block:: console

  $ python3 -m venv ./venv


After creating the virtual env, you should activate it:

.. code-block:: console

  $ source ./venv/bin/activate


upgrade pip:

.. code-block:: console

  (venv) $ pip install --upgrade pip


Install dependencies
^^^^^^^^^^^^^^^^^^^^

You can install the project dependencies manually or using a requirements file.

Install dependencies manually
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To install the dependencies manually, you should run:

.. code-block:: console

  (venv) $ pip install "numpy<2.0"
  (venv) $ pip install tensorflow[and-cuda]==2.14.0
  (venv) $ pip install matplotlib

Install dependencies using a dependency file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To install the dependencies using a requirements file, you should run:

.. code-block:: console

  (venv) $ pip install -r requirements.txt


After installing all dependencies, you should deactivate the virtual environment:

.. code-block:: console

  (venv) $ deactivate

2. Configure the Slurm job script
---------------------------------

To submit the job, you first have to create a slurm batch script where you have to specify the required resources that will be allocated to your job and specify the tasks that will be run.

The following is a Slurm job script to run this project:

.. code-block:: console

  #! /bin/bash
  #SBATCH --job-name=cnn                    # create a short name for your job
  #SBATCH --output="slurm-cnn-venv-%j.out"  # %j will be replaced by the slurm jobID
  #SBATCH --nodes=1                         # node count
  #SBATCH --ntasks=1                        # total number of tasks across all nodes
  #SBATCH --cpus-per-task=4                 # cpu-cores per task (>1 if multi-threaded tasks)
  #SBATCH --gres=gpu:2                      # number of gpus per node

  source venv/bin/activate

  python3 cnn.py

  deactivate

The script is made of two parts: 1) specification of the resources needed as well to run the job as some general job information; and 2) specification of the taks that will be run.

In the first part of the script, we define the job name, the output file and the requested resources (4 CPUs and 2 GPUs). Then, in the second part, we define the tasks of the job. When using Python Virtual Environments, we should run the following steps:

  #. Activate the Python environment;
  #. Excecute the code;
  #. Deactivate the Python environment;

3. Submit the job
-----------------

To submit the job, you should run the following command:

.. code-block:: console

  $ sbatch script.sh
  Submitted batch job 143


You can check the job status using the following command:

.. code-block:: console

  $ squeue
               JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
                 143     batch      cnn     user  R       0:33      1 vision2

This goal of this project is to introduce the Vision supercomputer and be a knowledge base on how to use its resources, in order to help its users submit jobs in the best possible way.

# Vision

The Vision supercomputer is made 2 compute nodes a management node. Each compute node is a NVIDIA DGX A100 systems with the following specifications:

 - CPU: Dual AMD Rome 7742,
128 cores total
 - System Memory: 1TB
 - GPUs: 8x NVIDIA A100 Tensor
Core GPUs (40GB per GPU)
 - GPU Memory: 320GB total

The two DGX A100 systems are interconneted by 8 x 200Gb/s HDR InfiniBand links.

## Storage
There are two main storage areas in Vision:
 - Home folder
 - External storage

### Home folder
The home folder for the users is located in /home/<username> and is shared betweem all nodes (management node and compute nodes).

This folder should be used to store personal files and source code for the applications of the user.

### External storage
The Vision supercomputer has an external storage for data with the capacity of 15TB. This storage is made avaialbe in the management node and in the compute nodes via NFS and mounted in /data. Each user has a folder in /data/\<username> and/or /data/\<project>/\<username>. The data stored in /data is shared between all nodes.

This folder should be used store data that will be processed by your applications. The data created by your applications should also be stored in this storage area.

## How to access Vision
In order to ease the use, the users can access Vision by:

 - SSH
 - Open OnDemand web application

 The credentials for SSH and Open OnDemand are the same.

### SSH

SSH allows the users to access the frontend(management node) of the Vision, access their data, submit jobs and check job status, using a remote console.

 #### Access via SSH
 To access Vision via SSH, you should use the following settings:

  - hostname: vision.xdi.uevora.pt
  - port: 22

### Open OnDemand

Open OnDemand is a web application that allows users to access their data, submit and manage jobs though a user friendly user interface: https://openondemand.org/

#### Access via Open OnDemand

To access Vision via the Open OnDemand web application, you should access the host "https://vision.xdi.uevora.pt" using your favorite web browser.

## Job management

Jobs in Vision are managed by the Slurm Workload Manager, a job scheduler which schedules
jobs according to the available computational resources and the needs of each job.

Slurm is used if you access Vision though SSH or Open OnDemand and the resources are the same.

To learn more about job management though SSH, please visit:

To learn more about job management though Open OnDemand in Vision, please visit the following page:

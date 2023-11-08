#!/bin/bash 
#SBATCH -C gpu 
#SBATCH -A m4298_g
#SBATCH --ntasks-per-node 4
#SBATCH --cpus-per-task 32
#SBATCH --gpus-per-node 4
#SBATCH --time=03:00:00
#SBATCH -N 1

#export FI_MR_CACHE_MONITOR=userfaultfd
IDENTIFIER=4_gpu_0.5_segnn_highE
CONFIGPATH=/pscratch/sd/w/wenxu/jobs/OCP/ocp/configs/oc22/s2ef_mag/segnn/dpp_segnn_highE.yml
LOGFILE=log_4gpu_0.5_segnn_highE
NODES=4

python -u -m torch.distributed.launch --nproc_per_node=$NODES main.py --distributed --num-gpus $NODES --mode train \
       --config-yml $CONFIGPATH > $LOGFILE --identifier $IDENTIFIER

#python -u -m torch.distributed.launch --master_addr="127.0.0.1" --master_port=29500 --nnodes=1 --node_rank=0 --nproc_per_node=4 \ 
#  main.py --distributed --num-gpus 4 --mode train --config-yml configs/s2ef/200k/schnet/schnet.yml > log_multi 



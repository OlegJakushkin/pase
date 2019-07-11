#!/bin/bash
#SBATCH -J aspp
#SBATCH -o log/aspp_32000
#SBATCH --mem=32GB
#SBATCH -t 5-00:00:00
#SBATCH -n 1
#SBATCH -c 8
#SBATCH -p gpu
#SBATCH --gres=gpu -C K80

nvidia-smi

python -u train.py --batch_size 15 --epoch 50 --num_workers 8 \
        --save_path /export/team-mic/zhong/test/aspp_res_dense  \
        --net_cfg cfg/workers_aspp.cfg \
        --fe_cfg cfg/PASE_aspp_res.cfg \
        --do_eval --data_cfg /export/corpora/LibriSpeech_50h/librispeech_data_50h.cfg --min_lr 0.0005 --fe_lr 0.0005 \
        --data_root /export/corpora/LibriSpeech_50h/wav_sel \
        --stats data/librispeech_50h_stats.pkl \
        --log_freq 100 \
	    --backprop_mode base \
	    --tensorboard True \
        --chunk_size 32000


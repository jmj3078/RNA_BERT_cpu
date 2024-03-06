#!/usr/bin/bash
#SBATCH -J RNABERT
#SBATCH -n 4
#SBATCH -N 1
#SBATCH -t 1-00:00
#SBATCH -p 36core
#SBATCH --mem=64G
#SBATCH -o ./log/RNABERT_%j.out
#SBATCH -e ./log/RNABERT_%j.err
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=jmj3078@g.skku.edu

# 매우 중요, libstdc++ 경로를 직접 설정해줘야합니다.
# RNABERT를 위한 가상환경이 설치된 path의 lib폴더로 지정하면 해결되는듯함
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/mjcho/.conda/envs/RNABERT/lib/

BATCH_SIZE=$1

export PRED_FILE=/data/project/mjcho/project2_ASO_ML/codes/DL_model/notebooks/Embedding/aso_sequences_combined.fasta
export PRE_WEIGHT=/data/project/mjcho/project2_ASO_ML/codes/DL_model/notebooks/Embedding/RNABERT/bert_mul_3.pth
export OUTPUT_FILE=/data/project/mjcho/project2_ASO_ML/codes/DL_model/notebooks/Embedding/ASO_embedded_$BATCH_SIZE.RNABERT.txt

python MLM_SFP.py \
    --pretraining ${PRE_WEIGHT} \
    --data_embedding ${PRED_FILE} \
    --embedding_output ${OUTPUT_FILE} \
    --batch $BATCH_SIZE

set -x

read -r -d '' training_commands <<EOF
openrlhf.cli.train_sft \
   --max_len 2048 \
   --dataset /mnt/workspace/o1_like/OpenRLHF/dataset/NDE/nde_prmlike_kn_train.json \
   --input_key question \
   --output_key process \
   --train_batch_size 256 \
   --micro_train_batch_size 2 \
   --max_samples 500000 \
   --pretrain deepseek-ai/DeepSeek-R1-Distill-Qwen-7B \
   --save_path ./checkpoint/deepseek-r1-qwen-7b-sft \
   --save_steps -1 \
   --logging_steps 1 \
   --eval_steps -1 \
   --zero_stage 2 \
   --max_epochs 1 \
   --bf16 \
   --flash_attn \
   --learning_rate 5e-6 \
   --load_checkpoint \
   --gradient_checkpointing
EOF
    # --wandb [WANDB_TOKENS]
    # --packing_samples

if [[ ${1} != "slurm" ]]; then
    deepspeed --module $training_commands
fi
set -x

read -r -d '' training_commands <<EOF
openrlhf.cli.train_prm \
   --save_path ./checkpoint/qwen-7b-prm \
   --save_steps 500 \
   --logging_steps 1 \
   --eval_steps 100 \
   --train_batch_size 256 \
   --micro_train_batch_size 8 \
   --pretrain LLM/Qwen/Qwen2.5-Math-7B-Instruct\
   --bf16 \
   --max_epochs 5 \
   --max_len 8192 \
   --zero_stage 3 \
   --learning_rate 1e-6 \
   --dataset /mnt/workspace/o1_like/OpenRLHF/dataset/NDE/train.json \
   --input_key question \
   --label_key label \
   --flash_attn \
   --load_checkpoint \
   --gradient_checkpointing \
   --packing_samples \
   --wandb_group prm \
   --placeholder_token ки \
   --reward_tokens + -
EOF
     # --use_wandb [WANDB_TOKENS] or True (use wandb login command)
     # --packing_samples


if [[ ${1} != "slurm" ]]; then
    deepspeed --module $training_commands
fi

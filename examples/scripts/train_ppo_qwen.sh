set -x

read -r -d '' training_commands <<EOF
openrlhf.cli.train_ppo \
   --pretrain deepseek-ai/DeepSeek-R1-Distill-Qwen-7B \
   --reward_pretrain /mnt/workspace/o1_like/OpenRLHF/checkpoint/qwen-7b-rm \
   --save_path ./checkpoint/deepseek_qwen_ppo \
   --save_steps -1 \
   --logging_steps 1 \
   --eval_steps -1 \
   --micro_train_batch_size 2 \
   --train_batch_size 128 \
   --micro_rollout_batch_size 4 \
   --rollout_batch_size 1024 \
   --max_epochs 1 \
   --prompt_max_len 1024 \
   --generate_max_len 1024 \
   --zero_stage 2 \
   --bf16 \
   --actor_learning_rate 5e-7 \
   --critic_learning_rate 9e-6 \
   --init_kl_coef 0.01 \
   --prompt_data mnt/workspace/o1_like/OpenRLHF/dataset/NDE/nde_prmlike_kn_train.json \
   --input_key context_messages \
   --apply_chat_template \
   --max_samples 100000 \
   --normalize_reward \
   --adam_offload \
   --flash_attn \
   --load_checkpoint \
   --gradient_checkpointing
EOF

    # --packing_samples
    # --use_wandb [WANDB_TOKENS] or True (use wandb login command)
    # --remote_rm_url http://localhost:5000/get_reward

if [[ ${1} != "slurm" ]]; then
    deepspeed --module $training_commands
fi

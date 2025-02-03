conda create -n openrlhf python=3.11​
conda activate openrlhf

export CUDA_HOME=/usr/local/cuda
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

# gcc配置
export GCC_HOME=/usr
export CC="/usr/bin/gcc"
export CXX="/usr/bin/g++"
export PATH=$GCC_HOME/bin:$PATH
export LD_LIBRARY_PATH="$GCC_HOME/lib64:$LD_LIBRARY_PATH"

# # 安装pytorch
conda install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia

# 可编辑模式安装 openrlhf

pip install  -e .
pip install vllm

# export CUDA_HOME=/mnt/petrelfs/share/cuda-12.1
# export PATH=$CUDA_HOME/bin:$PATH
# export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

# # gcc配置
# export GCC_HOME=/mnt/petrelfs/share/gcc-10.1.0
# export CC="/mnt/petrelfs/share/gcc-10.1.0/bin/gcc"
# export CXX="/mnt/petrelfs/share/gcc-10.1.0/bin/g++"
# export PATH=$GCC_HOME/bin:$PATH
# export LD_LIBRARY_PATH="$GCC_HOME/lib64:$LD_LIBRARY_PATH"

# # 安装pytorch
# conda install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia

# # 可编辑模式安装 openrlhf
# pip install -e .
# pip install vllm
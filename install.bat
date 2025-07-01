# reserved for when using local machine, copy into a .BAT script
# uses venv to make a virtual environment and isolate py installation
# see next cell for more info on a colab-friendly version
# MAKE SURE TO DOWNLOAD PYTHON 3.10 AND INSTALL AS FOLLOWS:
# do NOT install for all users
# add to path
# done and restart all terminals

# define a new virtual environment on py3.10
py -3.10 -m venv 2d3dgen
# activate virtual environment
call .\2d3dgen\Scripts\activate

# clone repos and install reqs
git clone https://github.com/NVlabs/PartPacker.git
cd PartPacker
pip install --upgrade pip
pip install -r requirements.txt
pip install -r requirements.lock.txt
pip install torch==2.5.1+cu121 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
pip install flash-attn --no-build-isolation
pip install meshiki
# can't install from requirements.txt so use link
pip install torch==2.5.1+cu121 torchvision==0.20.1+cu121 --index-url https://download.pytorch.org/whl/cu121 
pip install -r requirements.txt
pip install -r requirements.lock.txt

# windows CMD
mkdir pretrained
cd pretrained
curl -L "https://huggingface.co/nvidia/PartPacker/resolve/main/vae.pt" --output "vae.pt"
curl -L "https://huggingface.co/nvidia/PartPacker/resolve/main/flow.pt" --output "flow.pt"
# linux
# wget https://huggingface.co/nvidia/PartPacker/resolve/main/vae.pt
# wget https://huggingface.co/nvidia/PartPacker/resolve/main/flow.pt
cd ../../

git clone https://github.com/col14m/cadrille.git
cd cadrille

# replicate the pip installs from the Dockerfile from cadrille github:
pip install torch torchvision --index-url https://download.pytorch.org/whl/cu124
pip install git+https://github.com/facebookresearch/pytorch3d@06a76ef8ddd00b6c889768dfc990ae8cb07c6f2f
pip install git+https://github.com/CadQuery/cadquery@e99a15df3cf6a8
pip install accelerate==0.34.2 cadquery-ocp==7.7.2 casadi==3.6.7 einops==0.8.0 \
            transformers==4.50.3 qwen-vl-utils==0.0.10 flash-attn==2.7.2.post1 \
            manifold3d==3.0.0 trimesh==4.5.3 contourpy==1.3.1 scipy==1.14.1 \
            imageio==2.36.1 scikit-image==0.25.0 ipykernel==6.29.5 ipywidgets==8.1.5

# clear install cache and remove all wheels
pip cache purge
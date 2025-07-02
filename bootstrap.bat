@echo off

:: reserved for when using local machine, copy into a .BAT script
:: uses venv to make a virtual environment and isolate py installation
:: see next cell for more info on a colab-friendly version
:: MAKE SURE TO DOWNLOAD PYTHON 3.10 AND INSTALL AS FOLLOWS:
:: do NOT install for all users
:: add to path
:: done and restart all terminals

pip install --upgrade pip
:: for later use; packing the environment for cross-user repeatability
pip install venv-pack wheel

:: define a new virtual environment on py3.10
py -3.10 -m venv 2d3dgen
:: activate virtual environment
call .\2d3dgen\Scripts\activate

:: for debugging; comment later
@echo on
call
@echo off
echo Pausing to validate env start; should see (2d3dgen) prefixed to shell
pause

:: setting up cadquery
pip install cadquery==2.5.2
pip install CQ-editor
pause

:: clone repos and install reqs
git clone https://github.com/NVlabs/PartPacker.git
cd PartPacker
pip install -r requirements.txt
pip install -r requirements.lock.txt
pip install torch==2.5.1+cu121 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
pip install flash-attn --no-build-isolation
pip install meshiki
:: can't install from requirements.txt so use link
pip install torch==2.5.1+cu121 torchvision==0.20.1+cu121 --index-url https://download.pytorch.org/whl/cu121 
pip install -r requirements.txt
pip install -r requirements.lock.txt

:: windows CMD
mkdir pretrained
cd pretrained
curl -L "https://huggingface.co/nvidia/PartPacker/resolve/main/vae.pt" --output "vae.pt"
curl -L "https://huggingface.co/nvidia/PartPacker/resolve/main/flow.pt" --output "flow.pt"
:: linux
:: wget https://huggingface.co/nvidia/PartPacker/resolve/main/vae.pt
:: wget https://huggingface.co/nvidia/PartPacker/resolve/main/flow.pt

echo Check if folders created correctly
pause

echo Changing back to directory of this script
cd ../../
dir
:: replicate the pip installs from the Dockerfile from cadrille github:
pip install -r cadrille_requirements.txt
git clone https://github.com/col14m/cadrille.git

copy chat_cadrille.py cadrille\

:: clear install cache and remove all wheels
pip cache purge

:: provide a pause so user can read outputs
pause
# :gear:<img width="24" height="24" alt="heh" src="https://github.com/user-attachments/assets/f907926c-6dd3-4c75-b907-21ed3b0e9302" /> `2d3dgen`: Rapid Digital Twin Generation
The work presented here (and in the related repos) is a culmination of a summer internship with 345C at the NASA Jet Propulsion Lab. `2d3dgen` pipeline is built on Cadrille and PartPacker. All credits go to original developers.

## ⚠️ You are NOT required to `git clone` any of the above repos!
The `bootstrap.bat` Windows batch script will do all the installation for you :hugs:

# TODO: get the original environment used in development and add to this repo!
# TODO: create requirements.txt from work computer, and update bootstrap script

Just do:
`git clone http://github.com/2d1ff1cult/JPL-Su2025-2d3dgen.git`

# Some things to know
1. It is important to note that this repo requires Python 3.10. **Everything uses `py -3.10` when running Python scripts.
2. Additionally, the installation script here **does not** cause conflicts with existing Python installations (i.e. you can have Python 3.13 running as your primary Python while still being able to implement 2d3dgen.

# Instructions:
1. Run Command Prompt as admin and run:
`reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem /v LongPathsEnabled /t REG_DWORD /d 1 /f`
2. Run `bootstrap_inference.bat` if you don't plan to retrain. Else, run `bootstrap_train.py` 

The following repos are called by the bootstrap script above:
- https://github.com/2d1ff1cult/PartPacker
- https://github.com/2d1ff1cult/cadrille

3. To run PartPacker, execute `partpacker_run.bat`
4. When performing inference with Cadrille, open CMD and do:
   - `2d3dgen\Scripts\activate`
This starts the virtual environment

Changes were made to the original developers' code and stored in these forks. The original repos are incompatible with any of the work presented here.


## TODO
- make a new dataset from Neur11092.
  - Currently, it's just a bunch of CadQuery scripts in a folder
  - Need to make `train` and `val` split folders. **Currently, this needs to be done manually**

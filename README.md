# Instructions:
1. Run Command Prompt as admin and run:
`reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem /v LongPathsEnabled /t REG_DWORD /d 1 /f`
2. Run bootstrap.bat 

The following repos are called by the bootstrap script above:
https://github.com/2d1ff1cult/PartPacker
https://github.com/2d1ff1cult/cadrille

3. To run PartPacker, execute `partpacker_run.bat`

Changes were made to the original developers' code and stored in these forks

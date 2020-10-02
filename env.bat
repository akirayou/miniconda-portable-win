SET CONDA_PATH=%~dp0miniconda
cd %~dp0

SET PATH=%CONDA_PATH%;%CONDA_PATH%\Scripts;%CONDA_PATH%\Library\bin;%CONDA_PATH%\condabin;%PATH%
call conda_hook.bat
call conda.bat activate base

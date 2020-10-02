cd /d %~dp0
SET BASE_PATH=%~dp0
SET CONDA_PATH=%~dp0miniconda
set INSTALLER=%BASE_PATH%Miniconda3-latest-Windows-x86_64.exe

IF not EXIST %INSTALLER% (
	bitsadmin /TRANSFER miniconda  https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe %INSTALLER%
)

IF not EXIST %CONDA_PATH%\python.exe (
	mkdir %CONDA_PATH%
	%INSTALLER% /S /InstallationType=JustMe /AddToPath=0 /RegisterPython=0  /NoRegistry=1 /D=%CONDA_PATH%
)

call env.bat

call conda update -y -n base -c defaults conda
REM envを分けてインストールしたいときは以下をアンコメント
REM conda create -n stan
REM conda activate stan

REM jupyter labに ipythonwidgetとgitの基本構成の場合
call conda install -yc conda-forge jupyterlab-git  ipywidgets widgetsnbextension  jupyterlab pip

REM 上に加えて、stanで回帰とかするときに必要なもの全部入り
REM call conda install -yc conda-forge jupyterlab-git nodejs ipywidgets widgetsnbextension  holoviews bokeh  pystan arviz matplotlib pyviz_comms pandas plotly pycrypto mako scikit-learn jupyterlab


REM condaだけでは入れきれないモノをココで入れている

pip install compoundfiles ipython_blocking
jupyter lab clean
jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install @pyviz/jupyterlab_pyviz
jupyter lab build

REM できるだけ要らないファイルは消してしまう
jupyter lab clean
call conda clean -ya
pip cache  purge


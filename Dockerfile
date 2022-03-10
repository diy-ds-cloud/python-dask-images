####### dask worker

FROM jupyter/scipy-notebook:b6fdd5dae6cb AS dask-worker

####### jupyter notebook

FROM dask-worker AS dask-notebook

RUN mamba install --yes \
    dask-labextension>=5 \
    python-graphviz

# COPY --chown=1000:100 dask-config.yaml /home/jovyan/.config/dask/labextension-config.yaml
COPY --chown=1000:100 etc/dask-config.yaml /home/jovyan/.dask/labextension-config.yaml
COPY --chown=1000:100 etc/dask-dashboard.sh /usr/local/bin/start-notebook.d/dask-dashboard.sh
# COPY --chown=1000:100 dask-dashboard.sh /usr/local/bin/before-notebook.d/dask-dashboard.sh
COPY --chown=1000:100 etc/jupyterlab-workspace.json jupyterlab-workspace.json
COPY --chown=1000:100 etc/array.ipynb work/array.ipynb

# RUN jupyter lab workspaces import jupyterlab-workspace.json

# RUN echo 'c.ServerProxy.host_allowlist = ["localhost", "127.0.0.1", "dask-scheduler"]' >> /home/jovyan/.jupyter/jupyter_notebook_config.py
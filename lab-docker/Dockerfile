FROM public.ecr.aws/amazonlinux/amazonlinux:2023-minimal

ARG NB_USER="sagemaker-user"
ARG NB_UID="1000"
ARG NB_GID="100"
RUN dnf install --assumeyes python3 shadow-utils && \
    useradd --create-home --shell /bin/bash --gid "${NB_GID}" --uid ${NB_UID} ${NB_USER} && \
    dnf clean all && \
    python3 -m pip install jupyterlab

RUN python3 -m pip install xgboost urllib3==1.26.6 pandas

USER ${NB_UID}
CMD jupyter lab --ip 0.0.0.0 --port 8888 \
  --ServerApp.base_url="/jupyterlab/default" \
  --ServerApp.token='' \
  --ServerApp.allow_origin='*'

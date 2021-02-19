FROM harbor.iiis.co/library/orion-client-2.4.2:cu10.2_cudnn7_ubuntu18.04-base

RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \

    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \

    apt-get update 

# ==================================================================
# tools
# ------------------------------------------------------------------

RUN    APT_INSTALL="apt-get install -y --no-install-recommends" && \
DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        ca-certificates \
        cmake \
        wget \
        git \
        vim \     
	apt-utils \
	ffmpeg \
	libopenmpi-dev \ 
	tmux \
	htop \
	libosmesa6-dev \
	libgl1-mesa-glx \
	libglfw3 \
         imagemagick \
         libopencv-dev \
         python-opencv \
         curl \
         libjpeg-dev \
         libpng-dev \
         axel \
         zip \
         unzip 


# ==================================================================
# python
# ------------------------------------------------------------------

RUN  APT_INSTALL="apt-get install -y --no-install-recommends" && \  
DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        software-properties-common \
        && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python3.7 \
        python3.7-dev \
	python-setuptools \
	python3-distutils \
        && \
    wget -O ~/get-pip.py \
        https://bootstrap.pypa.io/get-pip.py && \
    wget https://www.roboti.us/download/mujoco200_linux.zip && \
    unzip mujoco200_linux.zip && \
    mkdir ~/.mujoco && \
    mv mujoco200_linux ~/.mujoco/mujoco200 && \
    python3.7 ~/get-pip.py && \
    ln -s /usr/bin/python3.7 /usr/local/bin/python3 && \
    rm -rf /usr/bin/python && \
    ln -s /usr/bin/python3.7 /usr/bin/python && \
    ln -s /usr/bin/python3.7 /usr/local/bin/python && \
    rm -rf /usr/local/bin/pip && \
    ln -s /usr/local/bin/pip3 /usr/local/bin/pip && \
    pip config set global.index-url http://mirrors.aliyun.com/pypi/simple \
	&& pip install pip -U \
	&& pip config set install.trusted-host mirrors.aliyun.com \
	&& pip install numpy \
	&& pip install pandas \
	&& pip install scipy  \
        && pip install torch==1.6.0 \
        && pip install scikit_learn \
	&& pip install opencv_python \
        && pip install matplotlib \
        && pip install Cython \
	&& pip install tensorboard \
	&& pip install tensorboardX \
	&& pip install pytest-runner \
	&& pip install ray \
	&& pip install cloudpickle==1.2.2 \
	&& pip install gym \
	&& pip install ipython \
	&& pip install ipdb \
	&& pip install tqdm \
	&& pip install ffmpeg \
	&& pip install mpi4py \
	&& pip install multiprocess \
	&& pip install atari_py \
	&& pip install memory_profiler \
	&& pip install line_profiler
	


# ==================================================================
# config & cleanup
# ------------------------------------------------------------------

RUN ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*




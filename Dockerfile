FROM ubuntu:bionic

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros1-latest.list

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO melodic


# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-ros-core=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*

#END ROS Defaults

EXPOSE 6833

RUN apt-get update && apt-get install -y --no-install-recommends xvfb x11vnc net-tools lxde supervisor vim ssh


# SSH experiment
RUN echo 'root:test' | chpasswd
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN /etc/init.d/ssh start
EXPOSE 22

# Supervisored
COPY ./supervisord.conf /etc/supervisord.conf

# setup ros entrypoint
COPY ./ros_entrypoint.sh /

# Setup carla 
RUN apt-get install python-pip -y
RUN pip install -U pip
RUN pip install carla
RUN pip install pygame
RUN sudo apt-get install software-properties-common -y
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1AF1527DE64CB8D9
RUN sudo add-apt-repository "deb [arch=amd64] http://dist.carla.org/carla $(lsb_release -sc) main"
RUN sudo apt-get update # Update the Debian package index
RUN sudo apt-get install carla-ros-bridge -y

# Helper script for starting rviz
COPY ./rviz.bash /rviz.bash


ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]




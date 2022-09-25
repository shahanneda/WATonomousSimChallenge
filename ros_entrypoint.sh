#!bin/bash

/usr/bin/supervisord

set -e
# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --
exec "$@"

roslaunch carla_ros_bridge carla_ros_bridge_with_example_ego_vehicle.launch host:=carla


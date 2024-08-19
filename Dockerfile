# hadolint global ignore=DL3008
#    DL3008 is "apt version pinning"
ARG ROS_DISTRO=rolling
FROM ros:$ROS_DISTRO-ros-base AS foxglove-bridge

RUN apt-get -q update \
    && apt-get -q -y upgrade \
    && apt-get -q install --no-install-recommends -y \
    "ros-${ROS_DISTRO}-foxglove-bridge" \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf "/var/lib/apt/lists/*"

CMD ["ros2", "launch", "foxglove_bridge", "foxglove_bridge_launch.xml"]

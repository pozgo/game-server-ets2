FROM cm2network/steamcmd:steam

ARG APP_ID=1948160
ARG SAVEGAME_LOCATION="/home/steam/.local/share/Euro Truck Simulator 2/"
ARG EXECUTABLE="/app/bin/linux_x64/eurotrucks2_server"
ARG DEFAULT_PACKAGES="default_packages/ets2"

# This mapping is needed to have the variables available at runtime. Args are only for build time
ENV SAVEGAME_LOCATION="${SAVEGAME_LOCATION}" \
    ETS_SERVER_CONFIG_FILE_PATH="${SAVEGAME_LOCATION}server_config.sii" \
    EXECUTABLE=${EXECUTABLE} \
    APP_ID=${APP_ID} \
    GAME_VER="ets2" \
    DEBIAN_FRONTEND=noninteractive

WORKDIR /app

USER root

RUN \
    apt-get update && \
    apt-get install -y python3 && \
    mkdir -p "${SAVEGAME_LOCATION}" && \
    chown steam:steam -R "${SAVEGAME_LOCATION}"

COPY container_files/ /

USER steam

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "bash", "-c", "${EXECUTABLE}" ]
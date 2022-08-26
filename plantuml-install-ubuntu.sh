#!/usr/bin/env bash
# Install PlantUML
set -e

PLANTUML_URL="https://github.com/plantuml/plantuml/releases/latest"

if [[ -f "/opt/plantuml/plantuml.jar" && -f "/usr/bin/plantuml" ]]; then
  echo '[plantuml] PlantUML already installed and will be reinstalled using latest version'
  echo '[plantuml] Removing installed version...'
  rm "/opt/plantuml/plantuml.jar"
  echo '[plantuml] Installed version removed'
fi

echo '[plantuml] Installing PlantUML...'
apt-get install -y default-jre graphviz
mkdir -p /opt/plantuml
curl -o /opt/plantuml/plantuml.jar -L "${PLANTUML_URL}" | grep "plantuml-*.jar" | cut -d : -f 2,3 | tr -d \" | wget -qi -
printf '#!/bin/sh\nexec java -Djava.awt.headless=true -jar /opt/plantuml/plantuml.jar "$@"' > /usr/bin/plantuml
chmod +x /usr/bin/plantuml

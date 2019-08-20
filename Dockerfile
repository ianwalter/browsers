FROM node:12.8

LABEL "com.github.actions.name"="Browsers Container"
LABEL "com.github.actions.description"="TODO"
LABEL "com.github.actions.icon"="globe"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/ianwalter/browsers"
LABEL "homepage"="http://github.com/ianwalter/browsers"
LABEL "maintainer"="Ian Walter <public@iankwalter.com>"

# Install Java, Firefox, and jq.
RUN apt-get update && apt-get install -y default-jdk firefox-esr jq

# Install Geckodriver.
RUN export GECKODRIVER_LATEST_RELEASE_URL=$(curl https://api.github.com/repos/mozilla/geckodriver/releases/latest | jq -r ".assets[] | select(.name | test(\"linux64\")) | .browser_download_url") \
  && curl --silent --show-error --location --fail --output ./geckodriver_linux64.tar.gz --retry 3 "$GECKODRIVER_LATEST_RELEASE_URL" \
  && tar xf geckodriver_linux64.tar.gz \
  && rm -rf geckodriver_linux64.tar.gz \
  && mv geckodriver /usr/local/bin/geckodriver \
  && chmod +x /usr/local/bin/geckodriver \
  && geckodriver --version

CMD ["/bin/bash"]

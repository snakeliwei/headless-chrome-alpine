FROM alpine:edge

RUN apk add --no-cache "freetype>2.8" "harfbuzz>1.6" udev ttf-freefont chromium nss xvfb
ADD xvfb-chromium /usr/bin/xvfb-chromium
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser

EXPOSE 9222

ENTRYPOINT ["xvfb-chromium"]

# flags from https://github.com/GoogleChrome/chrome-launcher/blob/master/src/flags.ts
CMD [ \
  # Disable various background network services, including extension updating,
  #   safe browsing service, upgrade detector, translate, UMA
  "--disable-background-networking", \
  # Disable installation of default apps on first run
  "--disable-default-apps", \
  # Disable all chrome extensions entirely
  "--disable-extensions", \
  # Disable the GPU hardware acceleration
  "--disable-gpu", \
  # Disable syncing to a Google account
  "--disable-sync", \
  # Disable built-in Google Translate service
  "--disable-translate", \
  # Run in headless mode
  "--headless", \
  # Hide scrollbars on generated images/PDFs
  "--hide-scrollbars", \
  # Disable reporting to UMA, but allows for collection
  "--metrics-recording-only", \
  # Mute audio
  "--mute-audio", \
  # Skip first run wizards
  "--no-first-run", \
  # Disable sandbox mode
  # TODO get this running without it
  "--no-sandbox", \
  # Expose port 9222 for remote debugging
  "--remote-debugging-port=9222", \
  # Disable fetching safebrowsing lists, likely redundant due to disable-background-networking
  "--safebrowsing-disable-auto-update", \
  "--disable-software-rasterizer", \
  "--disable-dev-shm-usage"\
]

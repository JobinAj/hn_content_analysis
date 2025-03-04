# Use the Rocker R base image with Shiny Server
FROM rocker/shiny:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /srv/shiny-server/

# Copy app files to the container
COPY . .

# Install required R packages
RUN R -e "install.packages(c('shiny', 'bs4Dash', 'tidyverse', 'highcharter', 'waiter', 'DT', 'tidytext', 'jsonlite', 'urltools'), dependencies=TRUE, repos='http://cran.rstudio.com/')"

# Expose the port Shiny Server runs on
EXPOSE 3838

# Run the Shiny app
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/app.R', host='0.0.0.0', port=3838)"]

# Use the official R-base image as the base image
FROM rocker/shiny:latest

# Install renv
RUN R -e "install.packages('renv')"

# Restore packages from renv.lock
COPY renv.lock /tmp/
RUN R -e "renv::restore('/tmp/renv.lock')"

# Copy the app files to the container
COPY app.R /srv/shiny-server/

# Expose port 3838 for the Shiny app
EXPOSE 3838

# Start the Shiny app when the container is run
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/app.R', host='0.0.0.0', port=3838)"]

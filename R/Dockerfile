FROM rocker/tidyverse

#update all packages
RUN apt-get update

#upgrade
RUN apt-get upgrade -y

#install additional packages
RUN apt install gpg-agent -y unixodbc apt-utils curl

#get msodbcsql17 and install it
 RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
 RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
 RUN apt-get update -y
 RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17 

#rename SQL Driver title in odbcinst file
RUN sed -i 's/ODBC Driver 17 for SQL Server/SQL Server/' etc/odbcinst.ini

#install packaes needed for running the app
RUN R -e "install.packages(c('odbc', 'dotenv'))"

#copy app to image
COPY /R/src/ /usr/src/
COPY .env /usr/

# Grant permissions to ensure files are executable
RUN chmod +x /usr/src/build-tables.R

CMD /bin/bash /usr/src/entrypoint.sh


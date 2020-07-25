FROM mcr.microsoft.com/mssql/server:2017-CU21-ubuntu-16.04

RUN ln -s /opt/mssql-tools/bin/* /usr/local/bin/

ENV SA_PASSWORD ${SA_PASSWORD}
ENV ACCEPT_EULA Y
ENV MSSQL_PID Express

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy scripts to load data
COPY ./ /usr/src/app

# Grant permissions to ensure files are executable
RUN chmod +x /usr/src/app/build-database.sh
RUN chmod +x /usr/src/app/entrypoint.sh

#define new entry point
CMD /bin/bash /usr/src/app/entrypoint.sh

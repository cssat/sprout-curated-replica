FROM mcr.microsoft.com/mssql/server:2017-CU21-ubuntu-16.04

RUN ln -s /opt/mssql-tools/bin/* /usr/local/bin/

ENV SA_PASSWORD ${SA_PASSWORD}
ENV ACCEPT_EULA Y
ENV MSSQL_PID Express

# Create worrking directory
WORKDIR /usr/src/

# Copy scripts to load data
COPY ./src/ /usr/src/

# Grant permissions to ensure files are executable
RUN chmod +x /usr/src/build-database.sh
RUN chmod +x /usr/src/entrypoint.sh

#define new entry point
CMD /bin/bash /usr/src/entrypoint.sh

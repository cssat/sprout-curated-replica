# Sprout Curated Replica Docker Setup

This repo contains a working file structure to facilitate the Dockerization of the Sprout curated replica for DCYF. [Docker](https://www.docker.com/), a system for transferring the dependencies and operating system configuration of code to another user. For this setup, we use an implementation of [Rocker](https://github.com/rocker-org/rocker/wiki), a collection of Docker configurations intended for use with R. The OS and R installation from Rocker will allow us to run some lightweight ETL scripts on data from the source replica. We also use [Container Registry](https://azure.microsoft.com/en-gb/services/container-registry/) from Microsoft, a registry of Docker and Open Container Initiative (OCI) images including the Linux distribution of MS-SQL Server 2017. 

## Getting Set Up With Docker

First things first: **install Docker**: on [Linux](https://docs.docker.com/linux/step_one/), [Mac](https://docs.docker.com/mac/step_one/), or [Windows](https://docs.docker.com/windows/step_one/). These install guides link to a bunch of introductory material after installation is complete; it's not necessary to complete those tutorials for this lesson, but they are an excellent introduction to basic Docker usage.

## Clone the Repo

Run `git clone` to get all of the files in this repository locally. 

```
git clone https://github.com/cssat/sprout-curated-replica
```

## Structure of the Repo

This repo is designed for development using `docker-compose`. A Docker product for managing multiple Docker images simultaneously. 

Once you clone the repo, you will need to add an `.env` file to the root of the project directory (e.g. `pico .env`). For now, only an `SA_PASSWORD` variable is required. Since this is still in the prototyping phase, any password may be used for now. 

## Building the Images

From the root, with your local Docker engine running, the R and SQL images in this repo can be built with the following command. 

```
docker-compose up -d
```
This command will 

1. build both images, 
2. run both images, and 
3. detach the images so that they run in the background. 

The effect of this process is to 

1. start an MS-SQL Server (2017) server database called `sql-container`, 
2. start a database called `dcyf_curated_replica` on `sql-container`, 
3. start a Linux server running the `tidyverse` image of `rocker`, 
4. run an R script on the Linux server which builds a table (`iris`) on `sql-container`.

Ideally, this structure can be used as a template for maintaining the full curated replica, and other database ETL needs. 

## Interactively Confirm Things are Working

If everything worked in your build of the images, you should be able to verify that `iris` exists on `dcyf_curated_replica`. This is accomplished by opening a shell for `sql-container` using the following command. 

```
docker exec -it sql-server "bash"
```

If the image is running, this should take you to a new prompt in your terminal which indicates your connection to `sql-container`. To interact with the databases on the container, you will need to access the MS-SQL CLI using the following command. 

```
sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master
```

If the above command worked, your terminal prompt should have changed again. It will now simply read `1>` indicating you have entered the MS-SQL CLI. Switch the database to ` dcyf_curated_replica` using 

```
USE dcyf_curated_replica
GO
```

followed by 

```
select count(*) from iris
GO
```

which should result in something like the following output.

```
-----------
        150

(1 rows affected)
```
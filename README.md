- [Setup](#setup)
  - [Admin](#admin)
  - [API](#api)
- [Dumps](#dumps)
  - [Requirements](#requirements)
  - [Steps](#steps)

# Setup

- Add a custom entry for docker in `/etc/hosts` pointing to `127.0.0.1`

  ```bash
  $ sudo echo -e "127.0.0.1\thost.docker.internal" >> /etc/hosts
  ```

- Run the containers with the following command:

  ```bash
  $ yarn up
  ```

## Admin

- Install `libmysqlclient` so rails are able to connect to the mysql DB

  ```bash
  $ sudo apt-get install libmysqlclient-dev
  ```

- At the `DATABASE_URL` entries in the file `.env`, swap all references of localhost for the custom host registered previously

  ```bash
  $ sed -i 's/root@localhost/root@host.docker.internal/'
  ```

## API

- Edit the variable named `DATABASE_HOST` with the value of the custom host registered previously

  ```bash
  $ echo "DATABASE_HOST='host.docker.internal'" >> .env
  ```

# Dumps

## Requirements

In order to restore a database dump it's necessary that the file is compressed with `zst` or `xz`

## Steps

- Copy the compressed file to `.docker/dumps`
- Enter the mysql container
  ```bash
  $ yarn exec:mysql bash
  ```
- Execute the usual restore command with `/dumps/<filename>` as the file path

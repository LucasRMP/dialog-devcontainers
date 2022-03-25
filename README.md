- [Setup](#setup)
  - [Admin](#admin)
  - [API](#api)
- [Dumps](#dumps)
  - [Requirements](#requirements)
  - [Steps](#steps)

**NOTE**: The first step is to clone the projects and set their respectively `.env` files, after that you can run this setup.

# Setup

- Add three environment variables with the names `DIALOG_ADMIN_DIR`, `DIALOG_API_DIR` and `DIALOG_PWA_DIR` pointing to the directory that you cloned the `dialog-admin`, `dialog-api` and `dialog-pwa` projects, respectively. The suggestion is to keep the export command in your `.bashrc` or `.zshrc` file.

  ```bash
  export DIALOG_ADMIN_DIR="$HOME/your/clone/directory/dialog-admin"
  export DIALOG_API_DIR="$HOME/your/clone/directory/dialog-api"
  export DIALOG_PWA_DIR="$HOME/your/clone/directory/dialog-pwa"
  ```

- Add a custom entry for docker in `/etc/hosts` pointing to `127.0.0.1`

  ```bash
  sudo echo -e "127.0.0.1\thost.docker.internal" >> /etc/hosts
  ```

- Run the containers with the following command:

  ```bash
  yarn up
  ```

## Admin

- Install `libmysqlclient` so rails are able to connect to the mysql DB (this command is **only** for Debian based distros, if you're using another, check your package installer).

  ```bash
  sudo apt-get install libmysqlclient-dev
  ```

- At the `DATABASE_URL` entries in the file `.env`, swap all references of localhost for docker bridge IP (generally it's 172.17.0.1, but if yours doesn't works, refer to the [how to find your docker bridge ip](#docker-bridge)) with the 3306 (mysql default port) port.

  ```bash
  sed -i 's/root@localhost/root@172.17.0.1:3306/'
  ```

## API

- Edit the variable named `DATABASE_HOST` with the value of the custom host registered previously

  ```bash
  echo "DATABASE_HOST='host.docker.internal'" >> .env
  ```

# Docker Bridge

To find your docker bridge IP you should execute the following command:

```bash
ip addr
```

and check out the option that has the name of `docker0` (or docker in it's name). If your distro doesn't have the ip command, check out how to list your network interfaces and search for the `docker0` interface.

# Dumps

## Requirements

In order to restore a database dump it's necessary that the file is compressed with `zst` or `xz`

## Steps

- Copy the compressed file to `.docker/dumps`
- Enter the mysql container
  ```bash
  yarn exec:mysql bash
  ```
- Execute the usual restore command with `/dumps/<filename>` as the file path

## Dockerized Utox-git ##

Run the git version of Utox inside an isolated [Docker](http://www.docker.io) container. This is achieved by sharing a socket for X11 and PulseAudio. This code is based on the terlar code for spotify [docker-spotify-pulseaudio](https://github.com/terlar/docker-spotify-pulseaudio). This version does not get/save the configuration of utox in the user home, everything stay inside the docker container.


## Instructions

1. Clone this repository and change to the directory:

  ```sh
	  git clone https://github.com/tobiasBora/docker-tox-git-pulseaudio.git && cd docker-tox-git-pulseaudio
  ```

2. (Optional) If you want to use only the nodes using port 443, please run

	```sh
	git checkout bootstrap_443
	```

3. Build the container:

  ```sh
  sudo docker build -t utox-git .
  ```

4. Run the provided script:

  ```sh
  ./scripts/utox
  ```

5. Use Utox.

6. (Optional) You may want to disable UDP in the Network parameters if you cannot connect to the Tox network.

If you get an error about impossible display, and if you run Fedora or any other distribution using SELinux, you may want to try to temporary disable SELinux by using:

   ```sh
   sudo setenforce 0
   ```

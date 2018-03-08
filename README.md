# FXServer Docker Container
A dockerized container of FXServer, FiveM's multiplayer server.

## Building the container
1. Clone this repository using `git clone`
2. Move into the repository directory with `cd`
3. Run `docker build -t fxserver .`  
   Optionally, you can specify the build ID using `--build-arg "FXS_BUILD=<ID>"`.  
   **Example:**  
   `docker build --build-arg="FXS_BUILD=401-7da138fa4851430482ff2fb4e196b871d5ea3efb" -t fxserver .`

## Running the container
By default, you can use `docker run -d -p "30120:30120" -p "30120:30120/udp" --name "fivem-server" -v "/var/docker/fxserver:/var/fxserver" --security-opt "seccomp=security_profile.json" fxserver`

**What does this command do?**
* Sets the container to run detached using `-d`.  
  Keep in mind that you can view the console output after using `docker logs <name> -f` or at the time of start by replacing `-d` with `--sig-proxy=false`.
* Binds the host port 30120 to the container for both TCP and UDP.
* Names your container instance to `fivem-server`.  
  If you wish to run more than one instance, you must change this
* Creates a bind mount between `/var/docker/fxserver` on the host to `/var/fxserver` within the container.  
  You must put your server.cfg and resources inside the mounted volume for the server to read!
* Uses the provided security profile in the current directory to allow the container to call `ptrace`. This is required for proot to function.  
  See [Seccomp security profiles for Docker](https://docs.docker.com/engine/security/seccomp/)  
  An alternative way is to run the container as privileged using `--privileged` or give it an unconfined security profile using `--security-opt seccomp=unconfined`. However, the safest and preferred method is to use the provided security profile.
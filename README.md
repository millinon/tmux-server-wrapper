# tmux-server-wrapper
A few scripts to provide a nice server wrapper using tmux.

---

I've used something like this a few times, so I figured it would be easier to set it up in the future with a simple template.

These little scripts are useful for setting up a wrapper for a process that you would like to have running continuously, and that you might like to be able to access directly from time to time. Minecraft is a great example.

---

## Setup

1. Clone the repo into your directory
2. Edit `.wrapper.conf` with your desired settings
3. Add the directory to your PATH variable (optional)

As an example, I might have a new Minecraft server set up in some directory:
```
/var/minecraft/
/var/minecraft/banned-ips.json
/var/minecraft/banned-players.json
/var/minecraft/eula.txt
/var/minecraft/minecraft-server.jar
/var/minecraft/ops.json
/var/minecraft/server.properties
/var/minecraft/usercache.json
/var/minecraft/world
/var/minecraft/world_nether
/var/minecraft/world_the_end
...
```

Cloning this this repo and adding the five files into the same directory will add the following files:
```
/var/minecraft/.wrapper.conf
/var/minecraft/server.sh
/var/minecraft/start.sh
/var/minecraft/stop.sh
/var/minecraft/view.sh
```

You can then edit `server.sh` to customize the server behavior. For Minecraft, I would use something like this:
```bash
#!/bin/bash

while :
do
	echo "Starting server..."
	java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui
	echo "Server died."
	sleep 5
done
```
Of course, you can replace `server.sh` with any other valid command in `.wrapper.conf`. The wrapper does not handle your command terminating prematurely, so it's up to you to handle potential server crashes.

You can edit the values in `.wrapper.conf`, which is really just a bash script that defines a vew variables, to change the wrapper behavior. I would use something like this:
```bash
srv_name="minecraft1"

srv_exe="server.sh"

srv_stop_cmd="stop ENTER"

srv_stop_time=5
```

Now, you should be able to execute `start.sh` to start the server, `view.sh` to view the server, and `stop.sh` to stop the server. You can rename the scripts without breaking anything; I would probably use `mc_start`, `mc_view`, and `mc_stop`.

## Sockets

I have found that by using a tmux socket, it can be very easy to share a server between multiple users. Consider the scenario of two users, user1 and user2, hosting a Minecraft server; both user1 and user2 need to be able to access the console to ban players from time to time. The typical solution would be to simply share an account on the machine being used to host Minecraft. However, by using a socket, and adjusting the permissions of the socket, you can make it so that user1 and user2 don't need to share an account. For instance, if `SOCKETPATH` in `.wrapper.conf` is changed to `minecraft.socket`, you could do the following:
```
# groupadd minecraft
# usermod -a -G minecraft user1
# usermod -a -G minecraft user2
# chown root:minecraft minecraft.socket
# chmod g+rw minecraft.socket
```
However, both user1 and user2 must be able to access all of the files required by Minecraft for `start.sh` to be runnable by either user.

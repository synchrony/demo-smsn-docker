This demonstrates one way to install and use SmSn.
Hopefully all it requires is Docker, but maybe it also requires Linux.
(If you test it on another system, please report back,
by leaving an issue in the issue tracker!)

# How to install

## Gremlin Server

Make an empty folder for your data.

Download and run the Docker image,
by evaluating this from a shell prompt
(replacing the capitalized text as appropriate):

```
docker run -it \
  -v /THE/FOLDER/YOU/MADE:/mnt/smsn-data \
  -p 8182:8182 -d -h 127.0.0.1 \
  jeffreybbrown/smsn-develop:gs_3.2.5
  smsn
```

Now the docker container should be running. Enter it:
```
docker exec -it smsn bash
```

and start the SmSn server:
```
./start-smsn.sh
```

(The reason you're encouraged to run that from inside the container, 
rather than the outside, 
is it permits you to see any error messages that might arise. 
Emacs will report errors too, but typically in much less detail.)

Before connecting Emacs, 
it seems nice to test that Gremlin in the container is talking to the host system. 
You can do that by running this:
```
host=localhost
port=8182
curl -i -N -vv -H "Connection: Upgrade" -H "Upgrade: websocket" -H "Host: $host" -H "Origin: http://$host" -k "http://$host:$port/gremlin"
```

The output should talk about a handshake.


## Emacs with smsn-mode

The `.emacs` file next door to the `README.md` 
file you're currently reading contains some code that you'll want to copy into your own `.emacs` file. 
(If your .emacs file already contains some of those lines, 
there's probably no need to repeat them, 
but neither will it probably do any harm.)

Next, clone the [smsn-mode repository](https://github.com/synchrony/smsn-mode) somewhere, 
by running
```
git clone https://github.com/synchrony/smsn-mode
```

Then create a symlink in your `.emacs.d/elisp` folder, 
called `smsn-mode-lisp`, pointing at that cloned repo, 
again replacing capitalized text as appropriate:
```
ln -s smsn-mode-lisp /WHERE/YOU/CLONED/SMSN-MODE
```

Start Emacs (or if it's already running, reload your `.emacs` file). 
Start smsn-mode by running `M-x smsn`. 
Start a new expression by typing `C-n`. 
You should now be in a SmSn-mode buffer titled 
"life, the universe and everything". 
You can change its name, populate it with other new nodes, 
search for stuff ... the graph is your oyster.

# The Docker container's life cycle

## It's pretty persistent

You can stop and restart your computer and it'll still be there, 
although it won't be running any more. 
You can restart it by running these commands:
```
docker start smsn
docker exec -it smsn bash
```

and then starting Gremlin Server with `./start-smsn.sh` as described earlier.

## Shutting it down

If you need to stop Gremlin Server, 
it's best to do that from *within* the container.
(You could instead kill the container, 
but neo4j might take revenge on your data.)
Just use `Ctrl-C` to stop Gremlin Server.

Once it's done stopping, you can kill the container however you like.
I think the easiest thing is to go to another shell window
(one with a view of your host system, not inside any Docker container)
and run `docker stop smsn && docker rm smsn`.

Your data will persist on your host system.

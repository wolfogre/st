# st
Shell tools.

## Environment

Tested on CentOS7 only for now.

## usage

Run:

```bash
. <(curl st.wolfogre.com)
```

You will get a command named `st` on your linux session, and you can do many things with st, run `st help` to see them.

For example, run `st count-conn 80` and see how many tcp connections in you port 80, and what the remote ip addresses are.

New tools will be added one by one.

## uninstall

Close you session and `st` disappear without anything left.

## st help

```


  clean           clean local functions cache
  help            show help infomations
  show            show function detail
  version         show st version

  adjust-time     adjust date time
  count-conn      count connections of specified port
  install-docker  install docker-ce and set mirror acceleration address
  install-go      install various version of golang
  install-svn     install svn 1.7, 1.8 or 1.9
  install-zmq     install zeromq 4.1.2
  locate-ip       locate ip region


```

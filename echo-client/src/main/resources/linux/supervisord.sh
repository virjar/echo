#!/bin/sh
##
## /etc/rc.d/init.d/supervisord
##
#supervisor is a client/server system that
# allows its users to monitor and control a
# number of processes on UNIX-like operating
# systems.
#
# chkconfig: - 64 36
# description: Supervisor Server
# processname: supervisord

# Source init functions
. /etc/rc.d/init.d/functions

prog="supervisord"
exec_prefix=${exec_prefix_stub}
PIDFILE="/var/run/supervisord.pid"
CONFIG="/etc/supervisord.conf"
prog_bin="${exec_prefix} -c $CONFIG "

function log_success_msg() {
        echo "$@" "[ OK ]"
}

function log_failure_msg() {
        echo "$@" "[ OK ]"
}

start()
{
       #echo -n $"Starting $prog: "
       #daemon $prog_bin --pidfile $PIDFILE
       #[ -f $PIDFILE ] && success $"$prog startup" || failure $"$prog failed"
       #echo
        if [ ! -r $CONFIG ]; then
                log_failure_msg "config file doesn't exist (or you don't have permission to view)"
                exit 4
        fi

        if [ -e $PIDFILE ]; then
                PID="$(pgrep -f $PIDFILE)"
                if test -n "$PID" && kill -0 "$PID" &>/dev/null; then
                        # If the status is SUCCESS then don't need to start again.
                        log_failure_msg "$NAME process is running"
                        exit 0
                fi
        fi

        log_success_msg "Starting the process" "$prog"
        daemon $prog_bin --pidfile $PIDFILE
        log_success_msg "$prog process was started"

}
stop()
{
       echo -n $"Shutting down $prog: "
       [ -f $PIDFILE ] && killproc $prog || success $"$prog shutdown"
       echo
}

case "$1" in

 start)
   start
 ;;

 stop)
   stop
 ;;

 status)
       status $prog
 ;;

 restart)
   stop
   start
 ;;

 *)
   echo "Usage: $0 {start|stop|restart|status}"
 ;;

esac
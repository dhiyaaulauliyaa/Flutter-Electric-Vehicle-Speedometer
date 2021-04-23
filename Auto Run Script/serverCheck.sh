#!/bin/bash
ps -C python3 >/dev/null && echo "Server already alive | $(date)" || ~/Run_Server/serverRun.sh
echo "Server check: server already alive | $(date)" >> ~/Run_Server/checkserver.log


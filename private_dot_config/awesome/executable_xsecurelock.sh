#!/bin/sh
XSECURELOCK_AUTH_TIMEOUT=5 \
XSECURELOCK_BLANK_TIMEOUT=900 \
XSECURELOCK_PASSWORD_PROMPT=time_hex \
XSECURELOCK_SAVER_RESET_ON_AUTH_CLOSE=1 \
XSECURELOCK_SHOW_DATETIME=1 \
XSECURELOCK_SAVER=saver_mpv \
XSECURELOCK_LIST_VIDEOS_COMMAND='find ~/Videos -type f -name "a-hands-drawn*"' \
xsecurelock

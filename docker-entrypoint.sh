#!/bin/bash
set -e

if [ "$1" = 'utox' ]; then
	USER_UID=${USER_UID:-1000}
	USER_GID=${USER_GID:-1000}

	# create user group
	if ! getent group utox >/dev/null; then
		groupadd -f -g ${USER_GID} utox
	fi

	# create user with uid and gid matching that of the host user
	if ! getent passwd utox >/dev/null; then
		adduser --uid ${USER_UID} --gid ${USER_GID} \
			--disabled-login \
			--gecos 'Utox' utox
	fi

	exec su utox -c "$@"
fi

exec "$@"

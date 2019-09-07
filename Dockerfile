ARG BASE_TAG
FROM nginx:${BASE_TAG}

ENV SUPERVISORD_CONFDIR /etc

RUN set -x \
 && apt-get update -qq \
 && apt-get upgrade -y \
 && apt-get install --no-install-recommends -y \
	supervisor

RUN { \
		echo '[supervisord]'; \
		echo 'nodaemon=true'; \
		echo; \
		echo '[program:nginx]'; \
		echo 'command=nginx -g "daemon off;"'; \
		echo 'autostart=true'; \
		echo 'autorestart=true'; \
	} | tee "$SUPERVISORD_CONFDIR/supervisord.conf"

CMD ["supervisord", "-c", "$SUPERVISORD_CONFDIR/supervisord.conf"]

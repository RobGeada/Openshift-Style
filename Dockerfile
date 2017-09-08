FROM rgeada/style:base
MAINTAINER Rob Geada

USER root
ADD images /home/neural-style/images

ADD style.sh /home/neural-style/
ADD ocEmail.py /home/neural-style/
ADD output.jpg /home/neural-style/output.jpg

RUN	chown stylist /home/neural-style/style.sh; \
	chown stylist /home/neural-style/ocEmail.py; \
	chown stylist /home/neural-style/output.jpg; \
	chmod +x /home/neural-style/style.sh
USER stylist

# Start the main process
CMD ["/bin/bash", "/home/neural-style/style.sh"]
FROM httpd:2.4

RUN	apt-get update && apt-get install -y \
		libyaml-dev \
		python-dev \
		python-pip && \
	pip install --upgrade \
		boto3 \
		pyyaml && \
	apt-get clean all

COPY SandboxApache.conf /etc/apache/conf.d/
COPY entry.py secrets.yml /opt/

CMD ["/opt/entry.py"]

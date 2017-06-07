FROM httpd:2.4

ARG AWS_REGION=us-east-1

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

ENV AWS_REGION ${AWS_REGION}
ENV AWS_DEFAULT_REGION ${AWS_REGION}

CMD ["/opt/entry.py"]

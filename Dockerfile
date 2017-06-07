FROM httpd:2.4

ARG AWS_REGION=us-east-1
ARG APP_HOST_NAME=dev.sandboxapp.cs.cucloud.net

ENV AWS_REGION ${AWS_REGION}
ENV AWS_DEFAULT_REGION ${AWS_REGION}
ENV APP_HOST_NAME ${APP_HOST_NAME}

RUN	apt-get update && apt-get install -y \
		python-pip \
		python-yaml && \
	pip install --upgrade \
		boto3 && \
	apt-get clean all

COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY entry.py secrets.yml /opt/

CMD ["/opt/entry.py"]

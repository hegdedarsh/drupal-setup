FROM ubuntu:16.04
ADD test.sh  /
ENTRYPOINT ["/bin/bash", "/test.sh"]
EXPOSE 80 3306

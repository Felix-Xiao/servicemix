docker run -i -t -p 5000:8181 servicemix

ENTRYPOINT bash -c "ifconfig && cd /opt/servicemix/bin && ./servicemix"

ENTRYPOINT为容器启动点，注意网上一些配置与此不同，6.X版本必须如此。
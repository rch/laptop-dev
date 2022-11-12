# Minimal(-ish) Developer Environment

## k8s

- [knative](https://knative.dev/docs/install/operator/knative-with-operators/)
- [kourier](https://developers.redhat.com/blog/2020/06/30/kourier-a-lightweight-knative-serving-ingress)

## asf

- [ozone](https://github.com/apache/ozone)
- [iceberg](https://github.com/apache/iceberg)
- [kafka](https://github.com/apache/kafka)
- [flink](https://github.com/apache/flink)
- [nifi](https://github.com/apache/nifi)

### [kafka quickstart](https://kafka.apache.org/quickstart)

```
KAFKA_CLUSTER_ID="$(bin/kafka-storage.sh random-uuid)"
bin/kafka-storage.sh format -t $KAFKA_CLUSTER_ID -c config/kraft/server.properties
bin/kafka-server-start.sh config/kraft/server.properties
```


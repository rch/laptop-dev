# Minimal(-ish) Developer Environment

## k8s

- [minikube](https://search.nixos.org/packages?channel=22.05&show=minikube)
- [kubectl](https://search.nixos.org/packages?channel=22.05&show=kubectl)
- [kubernetes-helm](https://search.nixos.org/packages?channel=22.05&show=kubernetes-helm)
- [kubetail](https://search.nixos.org/packages?channel=22.05&show=kubetail)
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


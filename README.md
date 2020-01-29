# Skydive Helm Chart

Skydive is an open source real-time network topology and protocols analyzer found here:

* <http://github.com/skydive-project/skydive>

## Pre Requisites

- Helm version 2.5.0 and higher

- Kubernetes version 1.10.0 and higher

- Persistent volume is needed only if you want to "look back in time" with skydive (that is, if you are interested in the monitoring history); if you don't , then it is not required (an elastic search container will not be created). You can create a persistent volume via the IBM Cloud Private interface or through a yaml file. For example:

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: <persistent volume name>
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: <PATH>
```

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release stable/skydive
```

The command deploys skydive on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The chart can be customized using the following configuration parameters:

| Parameter                                                             | Description                                       | Default                                   |
| -------------------------------------------------------------------   | -----------------------------------------------   | ---------------------------------------   |
| `deployment.agent`                                                    | Enable Skydive agent deployment                   | `true`                                    |
| `deployment.analyzer`                                                 | Enable Skydive analyzer deployment                | `true`                                    |
| `skydive-analyzer.nameOverride`                                       | Override `skydive-analyzer` subchart's name       | `skydive`                                 |                 
| `skydive-analyzer.image.repository`                                   | Skydive image repository                          | `ibmcom/skydive`                          |
| `skydive-analyzer.image.tag`                                          | Image tag                                         | `0.22.0`                                  |
| `skydive-analyzer.image.secretName`                                   | Image secret for private repository               | `nil`                                     |
| `skydive-analyzer.image.imagePullPolicy`                              | Image pull policy                                 | `IfNotPresent`                            |
| `skydive-analyzer.resources`                                          | CPU/Memory resource requests/limits               | Memory: `8192Mi`, CPU: `2000m`            |
| `skydive-analyzer.service.name`                                       | service name                                      | `skydive`                                 |
| `skydive-analyzer.service.type`                                       | k8s service type (e.g. NodePort, LoadBalancer)    | `NodePort`                                |
| `skydive-analyzer.service.port`                                       | TCP port                                          | `8082`                                    |
| `skydive-analyzer.service.nodePort`                                   | Exposed TCP port                                  | `nil`                                     |
| `skydive-analyzer.etcd.port`                                          | TCP port                                          | `12379`                                   |
| `skydive-analyzer.etcd.expose`                                        | Control for setting up a service for ETCD         | `false`                                   |
| `skydive-analyzer.etcd.nodePort`                                      | Exposed TCP port                                  | `nil`                                     |
| `skydive-analyzer.analyzer.topology.fabric`                           | Fabric connecting k8s nodes                       | `TOR1->*[Type=host]/eth0`                 |
| `skydive-analyzer.analyzer.topology.probes`                           | Deployed analyzer probes                          | `nil`                                     |
| `skydive-analyzer.persistence.enabled`                                | Use a PVC to persist data                         | `false`                                   |
| `skydive-analyzer.persistence.useDynamicProvisioning`                 | Specify a storageclass or leave empty             | `false`                                   |
| `skydive-analyzer.persistence.dataVolume.name`                        | Name of the PVC to be created                     | `datavolume`                              |
| `skydive-analyzer.persistence.dataVolume.existingClaimName`           | Provide an existing PersistentVolumeClaim         | `nil`                                     |
| `skydive-analyzer.persistence.dataVolume.storageClassName`            | Storage class of backing PVC                      | `nil`                                     |
| `skydive-analyzer.persistence.dataVolume.size`                        | Size of data volume                               | `10Gi`                                    |
| `skydive-analyzer.persistence.storage.elasticsearch.host`             | ElasticSearch host                                | `127.0.0.1`                               |
| `skydive-analyzer.persistence.storage.elasticsearch.port`             | ElasticSearch port                                | `9200`                                    |
| `skydive-analyzer.persistence.storage.flows.indicesToKeep`            | Number of flow indices to keep in storage         | `10`                                      |
| `skydive-analyzer.persistence.storage.flows.indexEntriesLimit`        | Number of flow records to keep per index          | `10000`                                   |
| `skydive-analyzer.persistence.storage.topology.indicesToKeep`         | Number of topology indices to keep in storage     | `10`                                      |
| `skydive-analyzer.persistence.storage.topology.indexEntriesLimit`     | Number of topology records to keep per index      | `10000`                                   |
| `skydive-analyzer.elasticsearch.deployment`                           | Enable deployment of an elastic search            | `false`                                   |
| `skydive-analyzer.elasticsearch.image.repository`                     | Elasticsearch image repository                    | `elastic/elasticsearch`                   |                                                           |
| `skydive-analyzer.elasticsearch.image.tag`                            | Image tag                                         | `7.5.1`                                   |
| `skydive-analyzer.elasticsearch.env`                                  | Elasticsearch environment variables               | ...                                       |
| `skydive-analyzer.ui.deployment`                                      | Enable deployment of the Skydive new UI           | `true`                                    |
| `skydive-analyzer.ui.image.repository`                                | Skydive UI image repository                       | `skydive/skydive-ui`                      |                                     |
| `skydive-analyzer.ui.image.tag`                                       | Image tag                                         | `latest`                                  |
| `skydive-analyzer.ui.port`                                            | TCP port                                          | `8080`                                    |
| `skydive-analyzer.ui.nodePort`                                        | Exposed TCP port                                  | `nil`                                   |
| `skydive-agent.nameOverride`                                          | Override `skydive-agent` subchart's name          | `skydive`                                 |
| `skydive-agent.image.repository`                                      | Skydive image repository                          | `skydive/skydive`                         |
| `skydive-agent.image.tag`                                             | Image tag                                         | `0.26.0`                                  |
| `skydive-agent.image.secretName`                                      | Image secret for private repository               | `nil`                                     |
| `skydive-agent.image.imagePullPolicy`                                 | Image pull policy                                 | `IfNotPresent`                            |
| `skydive-agent.resources`                                             | CPU/Memory resource requests/limits               | Memory: `8192Mi`, CPU: `2000m`            |
| `skydive-agent.service.port`                                          | TCP port                                          | `8082`                                    |
| `skydive-agent.topology.probes`                                       | Skydive agent probes                              | `ovsdb docker runc`                       |
| `env`

Specify parameters using `--set key=value[,key=value]` argument to `helm install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

```bash
helm install --name my-release -f values.yaml stable/skydive
```

### Env

The chart allows definition of extended environment variables to be used by Skydive components. The list of configuration parameters is available on [https://github.com/skydive-project/skydive/blob/master/etc/skydive.yml.default](https://github.com/skydive-project/skydive/blob/master/etc/skydive.yml.default). Use upper-case/underline semantics of a configuration parameter prefixed by `SKYDIVE_` to use as an environment variable. For example, to enable debug add to the deployment .yml file:  
```
env:
  # Enable debug
  - name: SKYDIVE_LOGGING_LEVEL
    value: "DEBUG"
```
Environment variables for SkyDive can also be defined using UI. The Env field should be changed, for example:
```
  [{"name":"SKYDIVE_LOGGING_LEVEL","value":"DEBUG"}]
```

### Topology fabric

The chart allows definition of static interfaces and links to be added to skydive topology view by setting the `analyzer.topology.fabric` parameter. This is useful to define external fabric resources like : TOR, Router, etc.
Details on this parameter field are available under the analyzer.topology.Fabric section in the following link: 
[https://github.com/skydive-project/skydive/blob/master/etc/skydive.yml.default](https://github.com/skydive-project/skydive/blob/master/etc/skydive.yml.default)

### Persistence Volume

Skydive analyzer uses elasticsearch to store data at the `/usr/share/elasticsearch/data` path of the Analyzer container.

The chart mounts a [Persistent Volume](http://kubernetes.io/docs/user-guide/persistent-volumes/) at this location. User needs to create a PV before chart deployed, or enable dynamic volume provisioning in chart configuration.

To make Elasticsearch work properly the user needs to set kernel setting vm.max_map_count to at least 262144 on each worker node. Please check
[https://www.elastic.co/guide/en/elasticsearch/reference/5.5/docker.html](https://www.elastic.co/guide/en/elasticsearch/reference/5.5/docker.html)

## Documentation

Skydive documentation can be found here:

* [http://skydive-project.github.io/skydive](http://skydive-project.github.io/skydive)

## Contact and Support

* IRC: #skydive-project on [irc.freenode.net](https://webchat.freenode.net/)
* Mailing list: [https://www.redhat.com/mailman/listinfo/skydive-dev](https://www.redhat.com/mailman/listinfo/skydive-dev)
* Issues: [https://github.com/skydive-project/skydive/issues](https://github.com/skydive-project/skydive/issues)

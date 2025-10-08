
# Create namespace
resource "kubernetes_namespace" "logging" {
  metadata {
    name = var.namespace
  }
}

# Elasticsearch Helm release
resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  namespace  = kubernetes_namespace.logging.metadata[0].name
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  version    = "8.11.0"

  set = [
    {
      name  = "replicas"
      value = tostring(var.es_replicas)
    },
    {
      name  = "volumeClaimTemplate.resources.requests.storage"
      value = var.es_storage_size
    },
    {
      name  = "service.type"
      value = "ClusterIP"
    }
  ]
}

# Kibana Helm release
resource "helm_release" "kibana" {
  name       = "kibana"
  namespace  = kubernetes_namespace.logging.metadata[0].name
  repository = "https://helm.elastic.co"
  chart      = "kibana"
  version    = "8.11.0"

  set = [
    {
      name  = "replicas"
      value = tostring(var.kibana_replicas)
    },
    {
      name  = "elasticsearchHosts"
      value = "http://elasticsearch-master:9200"
    },
    {
      name  = "service.type"
      value = "LoadBalancer"
    }
  ]
}

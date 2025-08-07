provider "docker" {}

# Docker Images
resource "docker_image" "zookeeper" {
  name = "bitnami/zookeeper:latest"
}

resource "docker_image" "kafka" {
  name = "confluentinc/cp-kafka:7.5.0"
}

resource "docker_image" "kafka_ui" {
  name = "provectuslabs/kafka-ui:latest"
}

# Zookeeper Container
resource "docker_container" "zookeeper" {
  name  = "zookeeper"
  image = docker_image.zookeeper.name

  env = [
    "ALLOW_ANONYMOUS_LOGIN=yes"
  ]

  ports {
    internal = 2181
    external = 2181
  }

  networks_advanced {
    name = docker_network.kafka.name
  }
}

# Kafka Broker Container (Confluent)
resource "docker_container" "kafka" {
  name  = "kafka"
  image = docker_image.kafka.name

  env = [
    "KAFKA_BROKER_ID=1",
    "KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181",
    "KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092",
    "KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1"
  ]

  depends_on = [docker_container.zookeeper]

  ports {
    internal = 9092
    external = 9092
  }

  networks_advanced {
    name = docker_network.kafka.name
  }
}

# Kafka UI Dashboard Container
resource "docker_container" "kafka_ui" {
  name  = "kafka-ui"
  image = docker_image.kafka_ui.name

  env = [
    "KAFKA_CLUSTERS_0_NAME=local",
    "KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=kafka:9092"
  ]

  depends_on = [docker_container.kafka]

  ports {
    internal = 8080
    external = 8080
  }

  networks_advanced {
    name = docker_network.kafka.name
  }
}


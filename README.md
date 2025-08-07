# 🧱 Kafka + Kafka UI Dashboard Stack (Terraform + Docker)

Provision a fully functional Apache Kafka cluster using **Terraform** and **Docker**, complete with a browser-based Kafka UI Dashboard.

---

## 📦 Stack Overview

| Component   | Image                              | Purpose                        |
|------------|-------------------------------------|--------------------------------|
| Zookeeper  | `bitnami/zookeeper:latest`          | Kafka metadata manager         |
| Kafka      | `bitnami/kafka:latest`              | Message broker                 |
| Kafka UI   | `provectuslabs/kafka-ui:latest`     | Web-based Kafka management     |

---

## 🛠️ Features

- Zero manual setup: use Terraform to provision everything
- View Kafka topics, messages, configs in browser
- Lightweight and runs locally with Docker
- Reusable and extensible Terraform code

---

## 🚀 Getting Started

### 🔧 Prerequisites

Make sure the following are installed:

- [Docker](https://docs.docker.com/get-docker/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)

---

### 📁 Directory Structure

```
kafka-stack/
├── main.tf               # Main Terraform configuration
├── network.tf            # Defines Docker network
├── variables.tf          # (Optional) variables
├── terraform.tfvars      # (Optional) variable values
├── README.md             # This file
```

---

## ⚙️ Setup & Deployment

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Review the Plan (Optional)

```bash
terraform plan
```

### 3. Apply the Stack

```bash
terraform apply -auto-approve
```

This will:

- Create a Docker network `kafka-network`
- Start Zookeeper container on port `2181`
- Start Kafka container on port `9092`
- Start Kafka UI dashboard on port `8080`

---

## 🌐 Access the Dashboard

Open your browser:

🔗 http://localhost:8080

You will see the **Kafka UI** with one pre-configured cluster named **`local`**.

---

## ✅ What You Can Do in the Kafka UI

- View Kafka topics, consumer groups, partitions
- Create/delete topics
- Produce and consume messages via UI
- Monitor brokers and their configurations

---

## 📤 Exposed Ports

| Service       | Internal | External |
|---------------|----------|----------|
| Zookeeper     | 2181     | 2181     |
| Kafka Broker  | 9092     | 9092     |
| Kafka UI      | 8080     | 8080     |

---

## 🧹 Tear Down

When you're done, clean up everything with:

```bash
terraform destroy -auto-approve
```

---

## 🧠 Notes

- Kafka and Kafka UI communicate over a shared **Docker bridge network** (`kafka-network`)
- Zookeeper is required by Kafka and must be started first
- Kafka UI uses the env variable `KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=kafka:9092` to talk to the Kafka broker
- All components are pulled from public Docker Hub images

---

## 🚀 Bonus: Create a Topic via Kafka UI

1. Visit http://localhost:8080
2. Click **"Create Topic"**
3. Name it something like `test-topic`
4. Choose default partition/replication and click **"Create"**

---

## 📚 Learn More

- [Kafka Documentation](https://kafka.apache.org/documentation/)
- [Kafka UI (Provectus)](https://github.com/provectus/kafka-ui)
- [Zookeeper Overview](https://zookeeper.apache.org/)
- [Terraform Docker Provider](https://registry.terraform.io/providers/kreuzwerker/docker/latest)

---

## 🙌 Author

This Terraform stack was built for DevOps practice to understand containerized messaging infrastructure with Kafka.

Enjoy streaming! 🎉

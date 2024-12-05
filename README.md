# OpenCTI Docker Compose Workplace

This repository provides a streamlined Docker Compose architecture to quickly set up and manage an instance of [OpenCTI](https://www.filigran.io/). The setup includes several useful and commonly used connectors to enhance OpenCTI's functionality. The provided `Makefile` automates installation, setup, and management tasks.

---

## What is OpenCTI?

[OpenCTI](https://www.filigran.io/) (Open Cyber Threat Intelligence) is an open-source platform designed to collect, analyze, and share cyber threat intelligence. It enables organizations to centralize intelligence feeds, analyze data relationships, and enhance threat detection and response capabilities.

---

## Project Structure

The project is structured to separate services, connectors, and environment files for easier management:

- **`services/`**: Contains Docker Compose YAML files for core OpenCTI services (e.g., Elasticsearch, MinIO, Redis, etc.).
- **`connectors/`**: Contains Docker Compose YAML files for various OpenCTI connectors.
- **`envs/`**: Stores `.env` files to configure services and connectors.

---

## Setup and Usage

### Prerequisites
- Docker and Docker Compose installed on your system.
- Basic understanding of Makefiles and Docker Compose.
- Sufficient disk space for persistent volumes and databases.

### Commands Overview

The `Makefile` contains commands to simplify the management of the OpenCTI instance. Below is an explanation of each command:

1. **Install OpenCTI**  
   Initializes persistent volumes and generates necessary UUIDs for configuration files.  
   ```bash
   make opencti-install
   ```

2. **Up OpenCTI**  
   Builds the `.env` file from `envs/` and starts OpenCTI services and connectors in Docker.  
   ```bash
   make opencti-up
   ```

3. **Down OpenCTI**  
   Stops all running containers and removes volumes.  
   ```bash
   make opencti-down
   ```

4. **View Logs**  
   Displays the logs of all running containers.  
   ```bash
   make opencti-logs
   ```

5. **Remove OpenCTI**  
   Stops all containers, removes persistent volumes, and performs a complete Docker system prune.  
   ```bash
   make opencti-docker-prune
   ```

---

## Description of Connectors

The connectors enable OpenCTI to integrate with external threat intelligence feeds and tools. Below is a list of available connectors and their purposes:

1. **AlienVault**  
   Integrates AlienVault OTX threat intelligence feeds into OpenCTI.

2. **CISA Known Exploited Vulnerabilities**  
   Ingests data from CISA's catalog of actively exploited vulnerabilities.

3. **CVE Connector**  
   Fetches and imports CVE (Common Vulnerabilities and Exposures) data.

4. **Hygiene**  
   Analyzes and enriches threat data based on common hygiene principles.

5. **MalwareBazaar**  
   Integrates malware samples and hashes from MalwareBazaar.

6. **MITRE Datasets**  
   Imports threat intelligence datasets from MITRE.

7. **MITRE Atlas**  
   Enriches OpenCTI with MITRE Atlas adversary simulation and emulation plans.

8. **OpenCTI Defaults**  
   Provides a baseline setup and configuration for OpenCTI.

9. **OpenCTI Datasets**  
   Imports pre-defined datasets for testing or initial setup.

10. **Ransomware Live**  
    Tracks live ransomware campaigns and related threat intelligence.

11. **Shodan InternetDB**  
    Integrates Shodan's InternetDB data for threat insights.

12. **VXVault**  
    Provides malware URL and IP data from VXVault.

13. **YARA**  
    Enriches data using YARA rules for malware analysis.

---

## Services Overview

Core services required for OpenCTI to function:

- **Elasticsearch**: Search engine and analytics backend for OpenCTI.
- **MinIO**: Object storage for OpenCTI data.
- **Redis**: In-memory data structure store used for caching.
- **RabbitMQ**: Message broker for inter-service communication.
- **OpenCTI Core**: The main application backend.
- **OpenCTI Worker**: Worker processes for handling tasks.
- **Nginx**: Reverse proxy to serve the OpenCTI application.

---

## Persistent Volumes

All databases and services use a persistent storage directory located in `./opencti_persistent_volumes`. This directory ensures data durability across container restarts.

- **S3 Data**: Persistent storage for MinIO.
- **Redis Data**: Cache persistence.
- **AMQP Data**: RabbitMQ queue persistence.
- **ES Data**: Elasticsearch data store.

---

## How to Contribute

Contributions are welcome! If you'd like to improve the project or add new connectors:
1. Fork this repository.
2. Create a new branch for your changes.
3. Submit a pull request with detailed explanations.

---

## License

This project is licensed under the [MIT License](LICENSE).

---

Feel free to reach out for questions or suggestions. Enjoy using OpenCTI! 🚀

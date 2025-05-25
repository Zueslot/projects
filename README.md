
# Projects Repository

This repository serves as a centralized collection of various DevOps, infrastructure, and application deployment resources. It encompasses scripts, configuration files, and templates designed to streamline deployment pipelines, container orchestration, and cloud-native application management.

## 📁 Repository Structure

- `ASC_script/`: Scripts related to Azure Security Center configurations.
- `VPN_setup/`: Resources for setting up VPN connections.
- `stateful-apps/`: Configurations and manifests for deploying stateful applications.
- `kubernetes/`: Kubernetes manifests and related deployment files.
- `src/main/webapp/`: Source code for web applications.
- `Dockerfile`: Instructions to build Docker images for the applications.
- `docker-compose.yaml`: Defines multi-container Docker applications.
- `Jenkinsfile`: Pipeline script for Jenkins CI/CD processes.
- `azure-pipeline.yaml`: Azure DevOps pipeline configuration.
- `pom.xml`: Maven project configuration file.
- `settings.xml`: Maven settings for repository configurations.
- `context.xml`: Apache Tomcat context configuration.
- `tomcat-users.xml`: User roles and credentials for Tomcat server.

## 🛠️ Technologies Used

- **Containerization**: Docker, Docker Compose
- **Orchestration**: Kubernetes
- **CI/CD**: Jenkins, Azure DevOps
- **Build Tools**: Maven
- **Web Server**: Apache Tomcat
- **Scripting**: PowerShell, Shell

## 🚀 Getting Started

### Prerequisites

- Docker and Docker Compose installed
- Kubernetes cluster access (e.g., Minikube, AKS)
- Jenkins server for CI/CD pipelines
- Azure DevOps account for pipeline execution
- Maven installed for building Java applications

### Setup Instructions

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/Zueslot/projects.git
   cd projects
   ```

2. **Build Docker Images**:

   ```bash
   docker build -t your-image-name -f Dockerfile .
   ```

3. **Deploy with Docker Compose**:

   ```bash
   docker-compose up -d
   ```

4. **Apply Kubernetes Manifests**:

   ```bash
   kubectl apply -f kubernetes/
   ```

5. **Set Up Jenkins Pipeline**:

   - Configure Jenkins with the provided `Jenkinsfile`.
   - Ensure necessary plugins are installed.

6. **Configure Azure Pipeline**:

   - Import `azure-pipeline.yaml` into your Azure DevOps project.
   - Set up necessary service connections and variables.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any enhancements or bug fixes.

## 📬 Contact

For questions or support, please open an issue in the repository.

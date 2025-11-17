# AWS EC2 + SSM – Zero-Touch Gigafactory  
**WDS → AWS Migration at Scale**  
**David Njoku – IT Infrastructure Engineer**

> **"From WDS PPE to AWS SSM in 1 line. 10,000+ workstations. Zero-touch."**

---
WDS = Windows Deployment Services
→ Outil on-premise, PXE, DHCP, TFTP
→ Parfait pour déploiement en masse dans un réseau local
→ Limité au monde Windows, pas scalable dans le cloud

SSM (AWS Systems Manager) = WDS du futur
→ Cloud-native, fonctionne sans VPN, sans PXE
→ Run Command = exécute des scripts PowerShell sur 10 000+ EC2 en 1 clic
→ Zero-touch total : pas de clé USB, pas de réseau local
→ Intégré à EC2, CloudWatch, IAM, Free Tier

---

## Live Resources (eu-west-3)
| Resource | ID |
|--------|----|
| EC2 Windows | `i-04be4bd311aa72f92` |
| KeyPair | `MyKeyPair` |
| AMI | `ami-0a4c17001f82f3bc09` |
| SSM Document | `Tesla-Imaging` (**Active**) |
| CLI Version | `aws-cli/2.31.37` |

---

## Scripts Inclus
- **`aws/cli-install-verification.sh`** → Installation AWS CLI v2  
- **`aws/create-tesla-imaging.sh`** → Création SSM Document  
- **`aws/launch-tesla-workstation.sh`** → Lancement EC2 + KeyPair + AMI auto

---
**Tesla Scale Ready**  
**Contact** : [LinkedIn](https://linkedin.com/in/david-njoku)

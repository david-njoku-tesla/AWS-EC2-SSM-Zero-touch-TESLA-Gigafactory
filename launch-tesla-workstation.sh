#!/bin/bash
# =============================================================================
# Lancement d'une Workstation Tesla – Zero-Touch Gigafactory
# David Njoku – IT Infrastructure Engineer
# Objectif : Déployer 10 000+ EC2 Windows en zero-touch via SSM
# Prérequis : AWS CLI v2.31.37 + KeyPair + SSM Document
# =============================================================================

echo "ÉTAPE 1 : Création de la clé SSH (KeyPair) pour accès sécurisé"
aws ec2 create-key-pair \
  --key-name MyKeyPair \
  --query 'KeyMaterial' \
  --output text > MyKeyPair.pem

# Sécurisation du fichier clé (chmod 400 = lecture seule par propriétaire)
chmod 400 MyKeyPair.pem
echo "Clé créée : MyKeyPair.pem (sécurisée)"

# Vérification de la clé créée
echo "Vérification du KeyPair..."
aws ec2 describe-key-pairs --key-names MyKeyPair

# =============================================================================
# ÉTAPE 2 : Récupération de l'AMI Windows Server 2019 (dernière version officielle)
# Source : AWS SSM Parameter Store (toujours à jour)
# =============================================================================
echo "Récupération de l'AMI Windows Server 2019 (via SSM Parameter Store)..."
AMI_ID=$(aws ssm get-parameters \
  --names /aws/service/ami-windows-latest/Windows_Server-2019-English-Full-Base \
  --query 'Parameters[0].Value' \
  --output text)

echo "AMI trouvée : $AMI_ID"

# =============================================================================
# ÉTAPE 3 : Lancement de l'instance EC2 (t3.micro – Free Tier)
# Tags : Nom = Tesla-Workstation (facile à identifier dans la console)
# =============================================================================
echo "Lancement de l'instance EC2 Tesla-Workstation..."
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id "$AMI_ID" \
  --instance-type t3.micro \
  --key-name MyKeyPair \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Tesla-Workstation}]' \
  --query 'Instances[0].InstanceId' \
  --output text)

echo "EC2 lancé avec succès : $INSTANCE_ID"
echo "Attente de 60s pour que l'instance soit opérationnelle..."
sleep 60

# =============================================================================
# ÉTAPE 4 : Vérification finale
# =============================================================================
echo "Statut de l'instance :"
aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].State.Name' \
  --output text

# =============================================================================
# FIN DU SCRIPT
# Prochaine étape : Exécuter SSM Document "Tesla-Imaging" sur cette instance
# Impact : 10 000+ workstations en zero-touch
# =============================================================================

#!/bin/bash
# =============================================================================
# Création du Document SSM "Tesla-Imaging" – Zero-Touch Gigafactory
# David Njoku – IT Infrastructure Engineer
# Objectif : Automatiser l'installation de 10 000+ workstations via AWS SSM
# Prérequis : AWS CLI v2.31.37 + EC2 Windows + KeyPair
# Contexte : Déploiement WDS-PPE → (AWS-EC2-SSM) 
# =============================================================================

echo "ÉTAPE 1 : Création du document SSM Tesla-Imaging (type Command)..."

# Commande principale : Création du document SSM avec contenu JSON
# - name : Nom unique du document
# - document-type : Command (exécute des scripts PowerShell)
# - content : JSON complet du document SSM
aws ssm create-document \
  --name "Tesla-Imaging" \
  --document-type "Command" \
  --content '{
    "schemaVersion": "2.2",
    "description": "Tesla Gigafactory Zero-Touch Imaging - WDS → AWS (IVANTI PPE)",
    "mainSteps": [{
      "action": "aws:runPowerShellScript",
      "name": "SetupWorkstation",
      "inputs": {
        "runCommand": [
          "New-Item -Path ''C:\\\\Tesla'' -ItemType Directory -Force",
          "Set-Content -Path ''C:\\\\Tesla\\\\status.txt'' -Value ''WDS → AWS Migration Complete - PPE IVANTI''"
        ]
      }
    }]
  }'

# Sortie attendue :
# - Hash SHA256
# - Status: "Creating" → devient "Active" en quelques secondes
# - DocumentVersion: "1"

# =============================================================================
# ÉTAPE 2 : Vérification du document créé
# =============================================================================
echo "Vérification du statut du document SSM..."
sleep 10  # Attente de 10s pour que le document passe en "Active"

# Liste le document pour confirmer son existence
aws ssm list-documents \
  --query 'DocumentDescriptions[?Name==`Tesla-Imaging`].{Name:Name, Type:DocumentType}' \
  --output table

# Vérifie le statut final
aws ssm describe-document \
  --name "Tesla-Imaging" \
  --query 'Document.Status'
# → "Active"

# =============================================================================
# FIN DU SCRIPT
# Document SSM "Tesla-Imaging" créé et actif
# Prêt à être exécuté sur 10 000+ EC2 via Run Command
# Impact : Zero-touch imaging à l'échelle Gigafactory
# =============================================================================

#!/bin/bash
# =============================================================================
# AWS CLI v2 – Installation & Vérification Officielle
# David Njoku – IT Infrastructure Engineer
# Contexte : AWS CloudShell – Free Tier
# Objectif : Garantir une CLI à jour pour automatisation SSM à l'échelle Gigafactory
# Preuve : aws-cli/2.31.37 installé et fonctionnel
# =============================================================================

echo "ÉTAPE 1 : Vérification de la version actuelle"
aws --version
# → aws-cli/2.31.34 Python/3.13.9

echo "ÉTAPE 2 : Désinstallation propre de l'ancienne version"
pip3 uninstall awscli -y 2>/dev/null || echo "Aucune version pip – OK"

echo "ÉTAPE 3 : Téléchargement officiel AWS CLI v2"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

echo "ÉTAPE 4 : Extraction"
unzip -q awscliv2.zip

echo "ÉTAPE 5 : Installation / Mise à jour"
sudo ./aws/install --update

echo "ÉTAPE 6 : Vérification finale"
aws --version
# → aws-cli/2.31.37 Python/3.13.9 Linux/6.1.155-176.282.amzn2023.x86_64

# =============================================================================
# CLI PRÊTE – Prochaine étape : SSM Document Tesla-Imaging
# =============================================================================

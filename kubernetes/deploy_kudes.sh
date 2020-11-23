# !/bin/bash
sudo kubectl apply -f deployment.yaml 
sudo kubectl apply -f configmap.yaml
sudo kubectl apply -f frontend.yaml
sudo kubectl apply -f backend.yaml
sudo kubectl apply -f mysql.yaml
sudo kubectl apply -f nginxservice.yaml

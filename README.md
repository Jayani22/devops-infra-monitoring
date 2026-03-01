# DevOps Infrastructure & Monitoring Project
## Project Overview
This project demonstrates end-to-end DevOps implementation including:
- Terraform infrastructure provisioning
- Ansible configuration management
- Docker Swarm setup
- Database setup and data seeding
- Prometheus + Grafana monitoring stack
- Bastion-based secure architecture

## Technologies Used
- Terraform
- Ansible
- Docker & Docker Swarm
- MySQL
- PostgreSQL
- Prometheus
- Grafana
- Ubuntu

## Terraform Setup
Infrastructure includes:
- VPC
- Public & Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Bastion EC2
- Private EC2
- Security Groups
- Key Pair

### Environments:
dev.tfvars
prod.tfvars

Environment differences handled via tfvars.

## Ansible Configuration
Playbooks created to:
- Install Nginx
- Install MySQL
- Install PostgreSQL
- Install Docker
- Initialize Docker Swarm
- Create DB users
- Seed sample data

## Database Seeding

### MySQL:

1. Created application database
2. Created app user
3. Inserted sample employee records

### PostgreSQL:
1. Created database
2. Created user
3. Created employees table
4. Inserted sample data

## Monitoring Stack

Monitoring implemented using:
- Prometheus
- Grafana
- Node Exporter
- MySQL Exporter
- PostgreSQL Exporter

Accessed securely using SSH port forwarding.
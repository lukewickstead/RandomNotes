# Azure Blueprints

[toc]

## Overview

- Creates templates for standard and repeatable Azure  environments that comply with an organization’s compliance requirements  and operational standards.
- It supports the following resources as artifacts:
  - Role Assignments
  - Policy Assignments
  - Azure Resource Manager (ARM) templates
  - Resource Groups
- It provides **resource locking** to prevent unwanted changes.
- A Blueprint may have its own parameters, but these can only be created if a Blueprint is developed from the REST API rather than Azure Portal.
- Blueprints role: Owner, Contributor, Blueprint Contributor, Blueprint Operator
- With Blueprints, you have a centralized location for environment management, including deployment, versioning, and update.
- If your subscriptions are in the same Azure Blueprint, you can upgrade multiple subscriptions at once.
- You can also use Blueprints to set up resource groups within subscriptions.
- Set up multiple environments within the same shared environment, when you assign a Blueprint to a subscription.

## Sources

- https://docs.microsoft.com/en-us/azure/governance/blueprints/overview   
- https://azure.microsoft.com/en-us/services/blueprints/
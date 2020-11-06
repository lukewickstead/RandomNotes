# Azure Policy

[toc]

## Overview

- Ensure resources are compliant with a set of rules.
- Manage your policies in a centralized location where you can  track their compliance status and verify the non-compliant resources.
- Select between **built-in policies** and **custom policies**.
- Implement proper guardrails and assess compliance across the organization
- JSON format is used to create a policy.
- You can manage the evaluation and outcome with **resource provider**, and the results are reported to Azure Policy.
- Policy order of evaluation: Disabled, Append/Modify, Deny and Audit
- Azure Policy effects:
  - Append – add additional fields to the requested resource.
  - Audit – a warning event for a non-compliant resource.
  - AuditIfNotExists – audit the resources when the condition is met.
  - Deny – prevents the request before being sent to the Resource Provider.
  - DeployIfNotExists – if the condition is met, it allows you to execute a template deployment.
  - Disabled – allows you to disable a single assignment, rather than disabling all assignments under that policy.
  - Modify – manage tags of resources.
- Determine the assigned resources with **policy assignments**.

## Sources

- https://azure.microsoft.com/en-us/services/azure-policy
- https://docs.microsoft.com/en-us/azure/governance/policy/overview
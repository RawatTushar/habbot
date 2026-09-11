# HabotConnect DevOps

This repository contains the infrastructure, security workflow, Django serializer, onboarding schema asset, and architecture documentation for HabotConnect.

## Project structure

```text
habotconnect-devops/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── versions.tf
├── .github/
│   └── workflows/
│       └── security-gate.yml
├── django/
│   └── serializers.py
├── schema/
│   └── student_onboarding.xlsx
├── docs/
│   └── architecture.md
└── README.md
```

See [docs/architecture.md](docs/architecture.md) for the component relationships and deployment flow.

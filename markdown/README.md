# Lellis

Lellis is a secure, high-performance backend platform designed for healthcare professionals.  
It focuses on the management of sensitive medical data, collaborative workspaces, and fine-grained access control, while strictly adhering to **Clean Architecture** principles and enabling a progressive evolution toward **microservices**.

The project prioritizes **domain isolation**, **security**, and **scalability**, making it suitable for medical contexts with strong regulatory constraints.

---

## Project Overview

Lellis provides healthcare professionals (nurses, medical practices, care teams) with a modern and modular platform to:

- centralize patient data,
- organize medical visits and rounds,
- collaborate securely within structured workspaces,
- enforce strict access control on sensitive medical information.

Rather than delivering a rigid or prematurely complex system, Lellis is designed to evolve incrementally, with a strong emphasis on **domain clarity**, **explicit security boundaries**, and **controlled architectural growth**.

---

## Development Strategy

Lellis follows a **two-stage architectural strategy**, balancing delivery speed with long-term scalability.

### Stage 1 — Modular Monolith (Initial Phase)

The initial implementation is a **modular monolith**:

- Single backend deployment.
- Strict domain modularization using Clean Architecture.
- One **PostgreSQL database per module** (Identity, Workspace, Medical, Documents, Audit).
- In-process communication between modules.
- Domain Events for cross-module interactions.
- Simplified deployment, debugging, and development.

This approach is particularly well-suited for a side project or small team, while maintaining strong isolation and future extensibility.

### Stage 2 — Microservices (Future Evolution)

Once the system matures, selected modules may be extracted into independent services:

- One service per bounded context.
- One database per service.
- Communication via HTTP or asynchronous events.
- Independent scaling and deployment.

This evolution is optional and incremental, not a mandatory redesign.

---

## Core Concepts

### Users and Workspaces

- A **User** represents an individual account at the platform level.
- A **Workspace** represents a collaborative environment (medical practice, care team, or organization).
- A user participates in a workspace through a **Workspace Member** context, which defines:
  - local roles,
  - permissions,
  - responsibilities.

This separation allows a single user to belong to multiple workspaces with different access levels and responsibilities.

---

## Security Architecture

Security is a **first-class concern** in Lellis due to the highly sensitive nature of medical data.

To avoid premature complexity, the authorization model is introduced progressively.

---

## Phase 1 — Foundational Security Core (Implemented)

The first phase delivers a **robust, auditable, and deterministic security foundation**.

### Objectives

- Strong isolation between users and workspaces.
- Clear and explicit Role-Based Access Control (RBAC).
- Support for real-world collaboration scenarios.
- Predictable and easily auditable authorization logic.

### Characteristics

- Role-Based Access Control (RBAC).
- Explicit permission codes modeled as value objects.
- Separation between global roles and workspace roles.
- Deterministic permission evaluation.
- Centralized audit logging.
- No contextual or attribute-based rules at this stage.

This phase intentionally avoids advanced policy engines to ensure correctness, maintainability, and fast iteration.

---

## Phase 1 — Security Core Domain Model

![Security Core – Phase 1](docs/security-core-phase-1.png)

### Design Overview

#### Security Core

- `Role` is an abstract domain concept.
- Permissions are aggregated through `RolePermission`.
- Permissions are expressed as explicit `PermissionCode` value objects.
- Roles evaluate permissions deterministically via `can(permissionCode)`.

#### Identity Management

- Users can be assigned **global roles**.
- Sessions represent authenticated contexts.
- Global permissions apply outside any workspace scope.

#### Workspace Management

- Workspaces define collaboration boundaries.
- Users interact with workspaces through `WorkspaceMember`.
- Workspace-specific roles allow local delegation without affecting global privileges.

#### Audit and Notifications

- All sensitive actions are auditable.
- Audit logs preserve actor identity and optional workspace context.
- Notifications provide feedback without exposing sensitive data.

---

## Phase 2 — Advanced Authorization (Planned)

The second phase introduces **context-aware authorization**, built on top of the existing RBAC foundation.

Planned extensions include:

- Attribute-Based Access Control (ABAC).
- Contextual permissions (time, assignment, emergency access).
- Medical-specific access rules (e.g. assigned caregiver).
- Policy composition and evaluation strategies.
- Temporary and delegated permissions.

Phase 2 will extend the model without breaking existing domain contracts.

---

## Architecture Overview

Lellis strictly follows **Clean Architecture**, enforcing separation between:

- domain logic,
- application services,
- infrastructure concerns,
- delivery mechanisms.

### Deployment Architectures

#### Modular Monolith (Initial Architecture)

- Single backend deployment.
- Domain-isolated modules.
- One database per module.
- In-process communication with domain events.

![Modular Monolith Deployment](docs/deployment-monolith.png)

#### Microservices (Future Architecture)

- One service per bounded context.
- Independent databases.
- Inter-service communication via APIs or events.
- Horizontal scalability and organizational scalability.

![Microservices Deployment](docs/deployment-microservices.png)

---

## Domain Model Overview

![Domain Class Diagram](docs/class-diagram.png)

The medical domain is modeled independently from security and infrastructure concerns and includes:

- patients and medical records,
- visits, rounds, and care activities,
- medical documents and artifacts,
- collaborative structures.

---

## Use Case Overview

The system distinguishes between **platform-level operations** and **workspace-level medical workflows**.

![Use Case Diagram](docs/usecase.png)

### Global Scope

- authentication and identity management,
- platform administration,
- workspace lifecycle management,
- security supervision and auditing.

### Workspace Scope

- patient record access,
- visit and round planning,
- document management,
- internal collaboration.

---

## Technology Stack

### Backend

- TypeScript
- Bun
- HonoJS / ElysiaJS
- PostgreSQL (one database per module)
- Prisma
- Docker

### Clients

- Desktop (Tauri)
- Web (planned)
- Mobile (planned)

---

## Project Status and Roadmap

### Phase 1 — MVP

- identity and workspace management,
- foundational Security Core (RBAC),
- stable backend API,
- desktop client,
- basic patient records,
- basic planning features.

Phase 2 will introduce advanced authorization, richer medical workflows, and optional microservices extraction.

---

## License

This project is under active development.  
License information will be defined at a later stage.

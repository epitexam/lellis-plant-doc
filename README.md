# Lellis – Architecture & Design Artifacts

This repository contains the **architecture and design documentation** for the Lellis project. It centralizes all **PlantUML diagrams** and **Markdown documents** used to describe the system's domain model, security model, and deployment architectures.

The goal is to provide a **clear, versioned, and reproducible source of truth** for architectural decisions and technical documentation.

---

## Repository Structure

```
.
├── uml/
│   ├── *.puml          # PlantUML source files
│   └── out/            # Generated diagrams (PNG, etc.)
├── markdown/
│   └── *.md            # Architecture and design documents
└── Makefile            # Diagram generation utilities
```

- **`uml/`**  
  Contains all PlantUML source files describing:
  - Domain models
  - Security models
  - Deployment architectures (modular monolith and microservices)

- **`uml/out/`**  
  Contains generated diagram files (e.g., PNG) produced from the PlantUML sources.

- **`markdown/`**  
  Contains complementary documentation files written in Markdown.

- **`Makefile/`**  
  Provides a simple and reproducible way to generate all diagrams.

---

## Generating Diagrams

### Prerequisites

Ensure the following tools are installed:

- `java`
- `plantuml`
- `graphviz` (dot)

### Usage

- Generate all diagrams:

  ```sh
  make
  ```

- Check dependencies only:

  ```sh
  make check
  ```

- Remove generated files:

  ```sh
  make clean
  ```

- Display help:

  ```sh
  make help
  ```

All generated diagrams will be placed in:

```
uml/out/
```

---

## Scope

This repository is **documentation-only** and does not contain application code. It is intended to:

- Support architectural discussions
- Document design decisions
- Provide a stable reference for implementation

---

## License

This repository follows the same licensing terms as the main Lellis project.

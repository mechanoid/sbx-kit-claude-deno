---
name: deno-init
description: A handy skill to bootstrap a new deno js project. It offers some options via the used scripts and can be extended over time to support basic deno project stacks. 
---

# Create a new Deno project

## When to apply

Use this skill when the user wants to create a new Deno project.

## Argument

- **Project name**: The user provides the project name (e.g., "Create a new Deno project called my-api"). Use this name as the directory name. If no name is provided, ask for one.

## Steps

Execute the following steps **in order**, using `<project-name>` as a placeholder for the project name provided by the user.

### 1. Initialize Deno project

Run always the `init-deno-project.sh` shell script for that.

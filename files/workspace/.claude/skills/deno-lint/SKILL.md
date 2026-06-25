---
name: deno-lint
description: A simple skill to directly use `deno lint` as a tool call
---

# Deno Linting

## When to apply

Use this skill when:

- Code needs to be checked for errors or issues
- After creating or modifying `.ts`, `.tsx`, `.js`, `.jsx` files
- The user explicitly asks for linting
- Before a commit or PR

## Instructions

**Always** use `deno lint` to lint code in this project. **Never** use `eslint`, `biome`, or any other linter.

### Lint the entire project

```sh
deno lint
```

### Lint individual files

```sh
deno lint path/to/file.ts
```

### Lint a specific directory

```sh
deno lint src/
```

## Configuration

Lint rules are configured in `deno.json` under `"lint"`. Example:

```jsonc
{
  "lint": {
    "include": ["src/"],
    "exclude": ["src/vendor/"],
    "rules": {
      "tags": ["recommended"],
      "include": ["no-unused-vars"],
      "exclude": ["no-explicit-any"]
    }
  }
}
```

## Handling lint errors

1. Fix the error in the code – this is always the preferred solution.
2. Only if suppression is truly justified, use an inline comment:
   ```ts
   // deno-lint-ignore no-explicit-any
   const data: any = response.json();
   ```
3. **Never** blanket-disable entire rules in the configuration without consulting the user first.

## Important

- Always fix lint errors, never ignore them.
- Run `deno lint` on affected files after every code change.
- When both `deno lint` and `deno fmt` are needed: lint first, then format.

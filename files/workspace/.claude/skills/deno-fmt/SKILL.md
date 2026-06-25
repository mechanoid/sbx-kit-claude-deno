---
name: deno-fmt
description: A simple skill to directly access `deno fmt` as a tool call
---

# Deno Formatting

## When to apply

Use this skill when:

- Code needs to be formatted
- After creating or modifying `.ts`, `.tsx`, `.js`, `.jsx`, `.json`, or `.md` files
- The user explicitly asks for formatting

## Instructions

**Always** use `deno fmt` to format code in this project. **Never** use `prettier`, `biome`, or any other formatter.

### Format the entire project

```sh
deno fmt
```

### Format individual files

```sh
deno fmt path/to/file.ts
```

### Check formatting (without making changes)

```sh
deno fmt --check
```

## Configuration

Formatting rules are configured in `deno.json` under `"fmt"`. Example:

```jsonc
{
  "fmt": {
    "useTabs": false,
    "lineWidth": 80,
    "indentWidth": 2,
    "semiColons": true,
    "singleQuote": false,
    "proseWrap": "preserve"
  }
}
```

## Important

- Do not format code manually – let `deno fmt` do the work.
- Run `deno fmt` on affected files after every code change.

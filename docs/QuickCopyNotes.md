# Quick Copy Notes

Quick Copy Notes stores reusable plain text in a fixed three-level hierarchy:

1. **Folder** — a broad user-defined area such as Work or Personal.
2. **Collection** — a user-defined group such as Homebrew Commands.
3. **Note** — a titled, optionally described, copyable text value.

The visible term "Collection" is deliberately separate from the persisted Swift type names. Product wording can therefore change later without migrating saved data.

## Persistence

The records live in `Features/QuickCopyNotes/Data`. Relationships use cascade deletion: deleting a folder deletes its collections and notes, and deleting a collection deletes its notes. Models avoid unique constraints and provide defaults so they remain compatible with SwiftData's CloudKit store.

Only the Quick Copy Notes schema uses CloudKit. Other SwiftData records remain in a separate local configuration. When adding another model, decide explicitly which configuration owns it in `PersistenceContainer`; do not add diagnostic or sensitive data to the synchronized configuration by accident.

CloudKit is optional at runtime. `PersistenceContainer` first requests the synchronized configuration and falls back to an identically partitioned local configuration if CloudKit cannot be opened. Never replace this fallback with a startup `fatalError`; a missing development entitlement or temporary iCloud outage must not make unrelated tools unavailable.

Note content must be saved verbatim. Do not trim, normalize, split, or rejoin the saved value because leading whitespace and blank lines can be meaningful in shell scripts, YAML, and templates. Validation may inspect a trimmed copy without replacing the original.

## Platform behavior

- macOS and iOS can copy a complete note to the system clipboard.
- watchOS can browse and edit the synchronized hierarchy, but does not show a clipboard action.
- Editors use local draft state and only change a record when Save is selected, so Cancel never partially edits a stored note.

## Future extensions

Good additions that preserve the model include tags, favorites filtering, search, and placeholder expansion such as `{{application}}`. A password or secret mode should not reuse the CloudKit plain-text content field; it needs a separate Keychain-backed design.

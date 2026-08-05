# Adding a tool

ToolPouch treats each tool as a compile-time plugin. Plugins are shipped inside the signed application; users can reorder or hide catalog entries, but the app does not download executable code.

## 1. Create the feature

Use this structure when all four parts are needed:

```text
toolpouch/Features/ExampleTool/
├── Domain/
├── Data/
├── Plugin/
└── Presentation/
```

- `Domain` contains plain models, errors, and service protocols.
- `Data` implements those protocols with Foundation, an Apple framework, or a Rust wrapper.
- `Plugin` describes the tool and creates its root view.
- `Presentation` contains the view model and SwiftUI views.

Small, fully local tools may omit an unnecessary layer. Do not create files solely to match the folder template.

## 2. Define the plugin

Conform to `ToolPlugin`, provide a `ToolDefinition`, and build the destination through the supplied `AppDependencies`. The definition controls the title, description, icon, section, supported platforms, and execution backend.

Use a stable identifier in `ToolDefinition.ID`. Identifiers are stored in Quick Access preferences, so changing one later makes existing user choices impossible to restore.

## 3. Register it

Add the plugin to `ToolRegistry.livePlugins`. Use compile-time platform conditions when the source depends on an unavailable framework. The registry also filters the tool by `supportedPlatforms`, which prevents unsupported destinations from appearing in navigation.

## 4. Add it to the catalog

Update `toolpouch/Resources/ToolCatalog.json` with the tool identifier in the appropriate section order. Make the equivalent update to the fallback configuration in `ToolCatalogConfiguration.swift`; the fallback keeps the app usable if the bundled file is missing or cannot be decoded.

Do not create a new section for a single tool unless users would naturally look for it under a distinct purpose. Section names and tool titles should make sense to non-technical users wherever possible.

## 5. Confirm target membership

Update `project.yml` when a platform needs source or resource exclusions, then regenerate the Xcode project. Platform-specific code must not be compiled into a target that cannot provide its frameworks.

## 6. Test the boundaries

At minimum, test the domain behavior and registry visibility. Add service tests for parsing, filesystem operations, or network responses, and verify that every declared platform can build the destination.

If the tool reads personal data, contacts an external service, or requests a permission, update [Privacy and data](PrivacyAndData.md) and explain the behavior in the interface before access is requested.


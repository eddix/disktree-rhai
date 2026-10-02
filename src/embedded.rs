//! Embedded sources for the built-in default skin.
//!
//! The `ui/` directory is the editable source of truth; this module freezes it
//! into the binary so a stock `disktree-rhai` run needs no files on disk.
//! `--export-skin` writes these same sources out for user modification.

use std::collections::BTreeMap;

use gpui_rhai::{AppManifest, EmbeddedScriptSource, ModuleId};

pub const THEME: &str = include_str!("../ui/theme.rhai");
pub const FLEXOKI_LIGHT: &str = include_str!("../ui/themes/flexoki_light.rhai");
pub const MAIN: &str = include_str!("../ui/main.rhai");
pub const CORE: &str = include_str!("../ui/core.rhai");
pub const WIDGETS: &str = include_str!("../ui/components/widgets.rhai");
pub const APP_MANIFEST_TOML: &str = include_str!("../ui/app.toml");

/// Every file that makes up the default skin, as `(relative path, contents)`.
/// `--export-skin` writes exactly this set.
pub const SKIN_FILES: &[(&str, &str)] = &[
    ("app.toml", APP_MANIFEST_TOML),
    ("main.rhai", MAIN),
    ("core.rhai", CORE),
    ("components/widgets.rhai", WIDGETS),
    ("theme.rhai", THEME),
    ("themes/flexoki_light.rhai", FLEXOKI_LIGHT),
];

pub fn entry() -> ModuleId {
    ModuleId::parse("main").expect("static module id")
}

pub fn sources() -> EmbeddedScriptSource {
    EmbeddedScriptSource::new(BTreeMap::from([
        (ModuleId::parse("main").expect("static module id"), MAIN.to_owned()),
        (ModuleId::parse("core").expect("static module id"), CORE.to_owned()),
        (
            ModuleId::parse("components/widgets").expect("static module id"),
            WIDGETS.to_owned(),
        ),
    ]))
}

pub fn manifest() -> AppManifest {
    AppManifest::new(entry())
        .with_capability("disktree.scan", "*")
        .expect("static capability requirement")
        .with_capability("disktree.tree", "*")
        .expect("static capability requirement")
        .with_capability("disktree.open", "*")
        .expect("static capability requirement")
        .with_capability("disktree.args", "*")
        .expect("static capability requirement")
}

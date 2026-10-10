//! Prepare every shipped skin through gpui-rhai's real loaders and print the
//! verdict, or the exact error. Runs the same validation a launch does —
//! module resolution, component schemas, runtime_api, token and asset
//! coverage — without opening a window. `cargo run --example skin_check`.

use std::path::PathBuf;

use disktree_rhai::{capability::DisktreeExtension, embedded};
use gpui_rhai::{EmbeddedScriptView, FileScriptView};

/// The skin's deep view functions exceed the runtime's 32-deep function
/// default; this mirrors src/main.rs.
const EXPRESSION_DEPTH_LIMITS: (usize, usize) = (64, 128);

fn extension() -> DisktreeExtension {
    DisktreeExtension::new().with_args(PathBuf::from("/tmp"), false, false, 3, "size", "dark")
}

fn report(name: &str, result: Result<(), gpui_rhai::ScriptViewError>) -> bool {
    match result {
        Ok(()) => {
            println!("ok       {name}");
            true
        }
        Err(error) => {
            println!("FAILED   {name}: {error}");
            false
        }
    }
}

fn main() {
    let mut all_ok = true;

    // The default skin as files (what --dev and --skin load).
    all_ok &= report(
        "ui (file)",
        FileScriptView::new("ui/main.rhai")
            .extension(extension())
            .expression_depth_limits(EXPRESSION_DEPTH_LIMITS.0, EXPRESSION_DEPTH_LIMITS.1)
            .prepare()
            .map(|_| ()),
    );

    // The minimal example skin as files.
    all_ok &= report(
        "skins/minimal (file)",
        FileScriptView::new("skins/minimal/main.rhai")
            .extension(extension())
            .expression_depth_limits(EXPRESSION_DEPTH_LIMITS.0, EXPRESSION_DEPTH_LIMITS.1)
            .prepare()
            .map(|_| ()),
    );

    // The embedded packaging path: frozen sources + token base + assets, the
    // exact assembly src/main.rs ships.
    all_ok &= report(
        "embedded (binary)",
        EmbeddedScriptView::new(embedded::entry(), embedded::sources(), embedded::THEME)
            .token_base(gpui_rhai_registry::TOKEN_BASE_SOURCE)
            .asset_sources(embedded::assets())
            .extension(extension())
            .expression_depth_limits(EXPRESSION_DEPTH_LIMITS.0, EXPRESSION_DEPTH_LIMITS.1)
            .prepare()
            .map(|_| ()),
    );

    if !all_ok {
        std::process::exit(1);
    }
}

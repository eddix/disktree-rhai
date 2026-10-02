// Small bespoke widgets for the disktree-rhai default skin.
//
// The skin is self-contained on purpose: everything it renders lives in
// this directory, so `--export-skin` hands the user a complete, editable
// UI with no hidden dependencies.

// ---------------------------------------------------------------------------
// Button — the only interactive widget; a formal component so it can own
// hover feedback without re-running the whole skin.
// ---------------------------------------------------------------------------

define_component(#{
    metadata: #{
        id: "skin/button",
        "export": "Button",
        version: "0.1.0",
        runtime_api: #{ min_inclusive: 2, max_exclusive: 3 },
        dependencies: [],
        capabilities: #{},
    },
    schema: #{
        props: #{
            label: #{
                schema: #{ type: "string" },
                required: true,
                sensitive: false,
            },
            variant: #{
                schema: #{ type: "string", allowed: ["primary", "outline", "ghost"] },
                required: false,
                sensitive: false,
                "default": #{ type: "string", value: "outline" },
            },
            on_click: #{
                schema: #{ type: "optional", value: #{ type: "callback" } },
                required: false,
                sensitive: false,
            },
        },
        state: #{ fields: #{} },
        events: #{},
        slots: #{},
        parts: ["root", "label"],
    },
    render: Fn("render_Button"),
});

fn Button(props) {
    render_component("skin/button", props)
}

fn render_Button(ctx, props) {
    let variant = props.variant;
    let base = style()
        .padding_x(px(14.0)).padding_y(px(8.0))
        .font_size(px(13.0))
        .cursor_pointer()
        .overflow_hidden();
    let styled = if variant == "primary" {
        base.background(theme_color("warning"))
            .text_color(theme_color("on_warning"))
            .font_weight(600)
    } else if variant == "ghost" {
        base.text_color(theme_color("text_muted"))
    } else {
        base.border(px(1.0))
            .border_color(theme_color("border"))
            .text_color(theme_color("text_primary"))
    };
    // A subtle lighten on hover for every variant, like tobi's flat buttons.
    let hover_style = if variant == "primary" {
        style().background(theme_color("accent"))
    } else {
        style().background(theme_color("surface_hover"))
    };
    let button = box([text(props.label).with_key("label")])
        .with_key("button")
        .with_style(styled.hover(hover_style));
    if "on_click" in props && props.on_click != () {
        button.on_click(props.on_click)
    } else {
        button
    }
}

// ---------------------------------------------------------------------------
// Pure layout helpers — plain functions returning nodes.
// ---------------------------------------------------------------------------

/// One stat cell of the scan panel: caption above, value below.
fn stat_cell(caption, value, warning) {
    let color = if warning {
        theme_color("warning")
    } else {
        theme_color("text_primary")
    };
    column([
        text(caption).with_style(
            style()
                .font_size(px(11.0))
                .text_color(theme_color("text_muted"))
        ),
        text(value).with_style(style().font_size(px(20.0)).font_weight(650).text_color(color)),
    ])
    .with_style(
        style()
            .padding_x(px(18.0)).padding_y(px(14.0))
            .background(theme_color("surface_raised"))
            .flex_col()
            .gap(px(4.0))
            .flex_grow()
    )
}

/// A progress track with a filled portion.
fn progress_track(fraction) {
    box([
        box([])
            .with_style(
                style()
                    .width(relative(fraction))
                    .height(px(4.0))
                    .background(theme_color("warning"))
            ),
    ])
    .with_style(
        style()
            .width(relative(1.0))
            .height(px(4.0))
            .background(theme_color("surface_hover"))
            .overflow_hidden()
    )
}

/// A key hint chip for the bottom bar.
fn keycap(label) {
    text(label).with_style(
        style()
            .font_size(px(10.0))
            .padding_x(px(5.0)).padding_y(px(2.0))
            .border(px(1.0))
            .border_color(theme_color("border"))
            .text_color(theme_color("text_muted"))
    )
}

/// Caption-value line for panels.
fn field(caption, value) {
    row([
        text(caption).with_style(
            style().font_size(px(12.0)).text_color(theme_color("text_muted"))
        ),
        text(value).with_style(
            style().font_size(px(12.0)).text_color(theme_color("text_primary"))
        ),
    ])
    .with_style(
        style()
            .flex_row()
            .justify_between()
            .padding_y(px(2.0))
    )
}

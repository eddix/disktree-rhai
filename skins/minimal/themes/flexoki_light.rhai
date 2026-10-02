// disktree-rhai light theme — Flexoki Light (Steph Ango's Flexoki, light
// mode). The dark default lives in ../theme.rhai; both are variants of the
// one "Disktree" family, so the app can switch without re-mounting.
fn theme() {
    #{
        family: "Disktree",
        name: "Flexoki Light",
        mode: "light",
        tokens: #{
            colors: #{
                surface: 0xfffcf0ff,
                surface_raised: 0xf2f0e5ff,
                surface_hover: 0xe6e4d9ff,
                text_primary: 0x100f0fff,
                text_muted: 0x6f6a63ff,
                accent: 0x4385beff,
                accent_hover: 0x36679bff,
                on_accent: 0xfffcf0ff,
                danger: 0xaf3029ff,
                on_danger: 0xfffcf0ff,
                warning: 0xbc5215ff,
                on_warning: 0xfffcf0ff,
                success: 0x66800bff,
                on_success: 0xfffcf0ff,
                border: 0xe0ddd0ff,
                focus_ring: 0x248a9aff,
                selection: 0xe6e4d9ff,
                disabled: 0x87837dff,
                scrim: 0x100f0f33,
            },
            spacing: #{
                xxs: #{ unit: "pixels", value: 2.0 },
                xs: #{ unit: "pixels", value: 4.0 },
                sm: #{ unit: "pixels", value: 8.0 },
                md: #{ unit: "pixels", value: 12.0 },
                lg: #{ unit: "pixels", value: 16.0 },
            },
            radii: #{
                sm: #{ unit: "pixels", value: 0.0 },
                md: #{ unit: "pixels", value: 0.0 },
                lg: #{ unit: "pixels", value: 0.0 },
            },
            typography: #{
                roles: #{
                    caption: #{ size: #{ unit: "pixels", value: 11.0 },
                        line_height: #{ unit: "pixels", value: 16.0 }, weight: 400 },
                    body_small: #{ size: #{ unit: "pixels", value: 12.0 },
                        line_height: #{ unit: "pixels", value: 16.0 }, weight: 400 },
                    body: #{ size: #{ unit: "pixels", value: 13.0 },
                        line_height: #{ unit: "pixels", value: 18.0 }, weight: 400 },
                    subtitle: #{ size: #{ unit: "pixels", value: 14.0 },
                        line_height: #{ unit: "pixels", value: 20.0 }, weight: 400 },
                    title: #{ size: #{ unit: "pixels", value: 16.0 },
                        line_height: #{ unit: "pixels", value: 22.0 }, weight: 700 },
                    heading: #{ size: #{ unit: "pixels", value: 18.0 },
                        line_height: #{ unit: "pixels", value: 24.0 }, weight: 700 },
                    display: #{ size: #{ unit: "pixels", value: 24.0 },
                        line_height: #{ unit: "pixels", value: 32.0 }, weight: 700 },
                    display_large: #{ size: #{ unit: "pixels", value: 28.0 },
                        line_height: #{ unit: "pixels", value: 36.0 }, weight: 700 },
                },
            },
        },
    }
}

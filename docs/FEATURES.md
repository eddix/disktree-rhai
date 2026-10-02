# disktree-rhai feature matrix

Scope reference: tobi/disktree defines visual & interaction fidelity,
remorses/gpuix (disktree clone) defines the v1 feature set. ✅ shipped ·
🟡 partial · ❌ intentionally out of v1 (see DESIGN.md).

## Scanning

| Feature | tobi | gpuix | disktree-rhai |
|---|---|---|---|
| du-faithful allocated sizes (st_blocks×512) | ✅ | ✅ | ✅ du parity test |
| apparent-size mode (`d`) | ✅ | ✅ | ✅ |
| hard links counted once ((dev,ino) dedup) | ✅ | ✅ | ✅ |
| symlinks not followed | ✅ | ✅ | ✅ |
| single filesystem (mount-source aware, btrfs subvolumes) | ✅ | ✅ | ✅ |
| hidden files toggle (`i`) | ✅ | ✅ | ✅ |
| parallel walk with progress + cancel (esc) | ✅ | ✅ | ✅ rayon, throttled progress |
| unreadable entries counted, not fatal | ✅ | ✅ | ✅ |

## Layout & rendering

| Feature | tobi | gpuix | disktree-rhai |
|---|---|---|---|
| squarified treemap, tobi's algorithm & options | ✅ | ✅ | ✅ core.rhai |
| 96-child window + Others merge | ✅ | ✅ | ✅ |
| header bands (20/15px), min-tile 5px | ✅ | ✅ | ✅ |
| depth 1–6 (`[` `]`) | ✅ | ✅ | ✅ |
| canvas tiling, ≤150 labels by area | ✅ | ✅ | ✅ |
| category colours / age colours (`t`) | ✅ | ❌ | ✅ |
| zoom/pan without re-layout (view transform) | ✅ | ❌ | ✅ |
| growth animation on enter/ascend | ✅ | ❌ | ❌ v1.5 |
| **tiling algorithm swappable per skin** | n/a | n/a | ✅ minimal skin ships slice-and-dice |

## Navigation & interaction

| Feature | tobi | gpuix | disktree-rhai |
|---|---|---|---|
| enter descends (file → parent) | ✅ | ✅ | ✅ |
| u/⌫ ascends | ✅ | ✅ | ✅ |
| hjkl/arrows geometric neighbour move | ✅ | ❌ | ✅ tobi scoring |
| tab next sibling by rank | ✅ | ❌ | ✅ |
| esc cascade: filter → selection → ascend | ✅ | ❌ | ✅ |
| breadcrumbs, click to jump | ✅ | ✅ | ✅ |
| history alt←→ + side buttons + `<`/`>` | ✅ | ❌ | ✅ |
| anchored wheel zoom, enter at ceiling, ascend at floor | ✅ | ❌ | ✅ |
| shift-wheel pan | ✅ | ❌ | ✅ |
| `-` `=` `0` centred zoom | ✅ | ❌ | ✅ |
| click select · re-click enter · double-click | ✅ | ✅ | ✅ |
| `/`/`s` typeahead filter (Whole/Partial keeps) | ✅ | ❌ | ✅ |
| `o` reveal in file manager | ✅ | ✅ | ✅ xdg-open |
| `q` quit | ✅ | ❌ | ✅ |
| `?` help overlay | ✅ | ❌ | ✅ |
| `p` sidebar toggle | ✅ | ✅ | ✅ |

## Panels & chrome

| Feature | tobi | gpuix | disktree-rhai |
|---|---|---|---|
| scan panel (progress, stats, cancel/retry) | ✅ | ✅ | ✅ |
| hover tooltip card | ✅ | ✅ | ✅ |
| sidebar: Selection | ✅ | ✅ | ✅ |
| sidebar: Worth a look (insights) | ✅ | ✅ | ✅ 3 finding kinds |
| sidebar: Disk (free space) | ✅ | ✅ | ✅ |
| mode segmented / checkboxes / depth stepper | ✅ | ✅ | ✅ |
| key bar footer | ✅ | ✅ | ✅ |

## Not in v1 (v1.5 / by design)

Deletion system (marks, review, trash) — excluded by design (gpuix scope).
Volumes `v`, whole-disk `g`, cross-fs options, growth animation, rem
scaling — v1.5.

## The plus: skins

| Capability | tobi | gpuix | disktree-rhai |
|---|---|---|---|
| UI defined in a scripting layer | n/a | TSX | ✅ rhai skin |
| `--export-skin` built-in skin to XDG config dir | n/a | n/a | ✅ |
| `--skin <name\|path>` load user skin | n/a | n/a | ✅ |
| `--skin-dev` live hot reload while editing | n/a | n/a | ✅ ≤3 s round trip |
| skin swaps tiling algorithm, not just colours | n/a | n/a | ✅ minimal skin |
| two theme variants in one family (`--theme`) | ✅ follows system | ❌ | ✅ Tokyo Night / Flexoki Light |
| Omarchy theme follow (degradable) | ✅ | ❌ | ✅ reads `theme/colors.toml` |

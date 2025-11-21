# Repository Guidelines

## Project Structure & Module Organization
- `content/` holds all articles in `index.md` format with TOML front matter; raw assets live under `content/**/raw/` and are converted into `static/**` during builds.
- `templates/` contains Zola/Tera layouts, snippets in `templates/snippets/`, and shortcodes in `templates/shortcodes/`.
- `helpers/img/` ships the Rust-based image pipeline; it expects ImageMagick's `magick` binary on your PATH.
- `scripts/` provides utility shell scripts such as `delete_years.sh`; top-level files include `config.toml`, `Makefile`, `lychee.toml`, and GitHub workflows.

## Build, Test, and Development Commands
- `make serve` (alias `make dev`) runs `zola serve --fast` for live previews.
- `make images` converts `content/**/raw/*` assets into optimized JPG/AVIF pairs under `static/`.
- `make build` performs the full publish pipeline (Zola build, Tinysearch index, JS minification).
- `make build-quick` skips the search/JS steps for faster iteration; run `make clean*` targets to purge build or image artifacts as needed.

## Coding Style & Naming Conventions
- Markdown front matter must include `title`, `date`, `draft`, and `[taxonomies] tags=[...]`; use stable slugs such as `content/2024/example-post/index.md`.
- Tera templates use two-space indentation; prefer snippets/macros over verbose inline logic.
- Keep CSS in `static/css/` and JavaScript in `static/*.js|.mjs`; never edit generated assets in `static/` manually.
- Rust code in `helpers/img/` targets edition 2024—format with `cargo fmt` and lint with `cargo clippy` before committing.

## Testing Guidelines
- Run `make build` (or `make build-quick` for drafts) before opening a PR; this catches content and template regressions.
- Optional: execute `lychee --config lychee.toml .` for link validation when touching outbound URLs.
- Surface visual updates with before/after screenshots captured from `make dev`.

## Commit & Pull Request Guidelines
- Write imperative, concise commit subjects (e.g., `Add post: repeat-yourself`).
- PRs should include a clear summary, linked issues, validation steps, and any relevant screenshots.
- Confirm `make build` passes and exclude generated directories like `public/` or large binaries from commits.

## Security & Configuration Tips
- Update `config.toml` → `base_url` when working from a fork or alternate domain.
- Deployment relies on GitHub Actions and Cloudflare Pages; ensure `CF_API_TOKEN` and `GITHUB_TOKEN` secrets are configured privately.
- Never commit API keys or credentials inside content, templates, or configuration files.

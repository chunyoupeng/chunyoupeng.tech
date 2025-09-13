# Repository Guidelines

## 项目结构与模块组织
- `content/`：Markdown 文章与页面，使用 `index.md` + TOML 头信息（`+++`）。原始图片放 `content/**/raw/`，构建后输出到 `static/**`。
- `templates/`：Zola/Tera 模板；局部在 `templates/snippets/`，短代码在 `templates/shortcodes/`。
- `static/`：静态资源与生成图片；请勿手动修改生成文件。
- `helpers/img/`：Rust 图片处理工具（依赖 ImageMagick `magick`），将图片转为 JPG/AVIF。
- `scripts/`：辅助脚本（如 `delete_years.sh`）。
- 根目录：`config.toml`（站点配置）、`Makefile`（构建入口）、`.github/workflows/`（CI）、`lychee.toml`（链接检查）。

## 构建、测试与本地开发命令
- `make dev`/`make serve`：`zola serve --fast` 本地预览。
- `make images`：从 `content/**/raw/*` 生成优化图片到 `static/**`。
- `make build`：完整构建（Zola 内容 + Tinysearch 索引 + JS 压缩）。
- `make build-quick`：仅 Zola 快速构建。
- `make clean` / `make clean-img` / `make clean-pub`：清理构建产物与生成图片。
- `make versions`：打印依赖工具版本。
- 依赖：`zola`、`tinysearch`、`terser`、`wasm-opt`、ImageMagick。

## 代码风格与命名约定
- Markdown：TOML 头信息包含 `title`、`date`、`draft`、`[taxonomies] tags=[...]`。
- 路径：推荐 `content/YYYY/slug/index.md`；标题可用中文，保持 slug 稳定。
- 模板：Tera，2 空格缩进；复用 snippets/macros，避免复杂逻辑。
- 资源：CSS 放 `static/css/`，JS 放 `static/*.js|.mjs`；不要提交 `public/`。
- Rust（`helpers/img`）：Edition 2024；提交前执行 `cargo fmt`、`cargo clippy`。

## 测试指南
- 基本校验：`make build` 或 `make build-quick` 应通过。
- 链接检查：CI 运行 Lychee；本地可 `lychee --config lychee.toml .`（可选）。
- UI 变更：PR 附上 `make dev` 截图（前/后对比）。

## 提交与 Pull Request 规范
- 提交信息：祈使句 + 简洁主题，例如 “Add post: repeat-yourself”、“Update template: article preview”。
- PR 要求：清晰描述、关联 issue、必要截图、给出本地验证步骤。
- 合并前确保 `make build` 通过；不要提交 `public/` 或大体积二进制。

## 安全与配置提示
- fork 后更新 `config.toml` 的 `base_url`。
- 部署经 GitHub Actions + Cloudflare Pages；需配置机密 `CF_API_TOKEN`、`GITHUB_TOKEN`。
- 不要在内容或模板中硬编码密钥。

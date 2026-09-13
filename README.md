# incept.md

A minimal Hugo site with handwritten HTML templates, CSS, and a small clipboard
script. No theme, Node dependencies, or CSS framework. Tested with Hugo 0.123.7.

## Edit

- `INCEPT.md`: Markdown displayed literally in the homepage editor.
  The homepage reads it directly; no Hugo front matter is needed.
  `content/incept.md` is a relative symlink for convenience. Hugo ignores this
  symlink, so it does not create a separate page or a blog listing entry.
- `content/blog/`: blog posts written in Markdown.
- `layouts/`: shared page shell, homepage, blog listing, and post templates.
- `assets/css/style.css`: all styling.
- `hugo.toml` → `[params.contact]`: email, LinkedIn, and GitHub footer links.
- `assets/js/copy.js`: Copy button and Ctrl/Cmd+C while the editor is focused
  (selected text keeps its normal copy behavior).
- `public/`: generated site served by nginx; ignored by Git. Do not edit here.

Create a post:

```sh
hugo new content blog/01-post-title.md
```

The post appears at `/blog/01-post-title/` and is listed automatically on `/blog/`.
New posts start with `draft = true`. Set it to `false` when ready to publish.
The authenticated preview includes draft posts; a normal `hugo` build excludes them.

## Preview locally

Install Hugo (on Ubuntu: `sudo apt install hugo`), then run:

```sh
hugo server --buildDrafts
```

## Server deployments

| Branch | Checkout | Site |
| --- | --- | --- |
| `main` | `/srv/incept.md/main` | `https://incept.md/` |
| `draft` | `/srv/incept.md/draft` | `https://draft.incept.md/` (basic auth) |

nginx serves each checkout's `public/` folder. The preview password file lives
outside this repo. Production excludes posts marked `draft = true`; preview
includes them.

After editing files on this server, rebuild:

```sh
cd /srv/incept.md/draft
./scripts/build.sh
```

Both server checkouts have `git config core.hooksPath .githooks` set locally.
The build script selects the correct URL and draft visibility from the checked-out
branch. Deploy remote changes with the command for the site you want to update:

```sh
git -C /srv/incept.md/draft pull --ff-only
git -C /srv/incept.md/main pull --ff-only
```

The server build script also requires `rsync` (installed on this server).
It builds into a temporary directory first, then syncs the successful output
to `public/`, removing stale generated pages and assets.

The post-merge hook builds Hugo when the pull brings in commits. A pull that is
already up to date does not rebuild; use the build script for local edits or to
retry a failed build. Build errors leave the currently served output intact.
No nginx reload is needed for content or template changes.

For a fresh server checkout, enable the hook once and run the build script:

```sh
git config core.hooksPath .githooks
./scripts/build.sh
```

## Production

Merge reviewed changes from `draft` into `main`, push them, and pull the main
checkout. Set a post's `draft` field to `false` when it is ready to go public.
Use `./scripts/build.sh main` to build explicitly for production, or
`./scripts/build-draft.sh` for preview. Never use a preview build in the main
checkout, since nginx serves its output immediately.

nginx configuration templates are in `deploy/nginx/`; pulling them does not
replace the installed files in `/etc/nginx/sites-available/`. Both sites use the
wildcard certificate at `/etc/letsencrypt/live/incept.md-wildcard/`.

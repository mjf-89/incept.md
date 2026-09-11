# incept.md

A minimal Hugo site with handwritten HTML templates and CSS. No theme,
JavaScript, Node dependencies, or CSS framework. Tested with Hugo 0.123.7.

## Edit

- `content/incept.md`: Markdown displayed literally in the homepage terminal.
  Its build settings keep it out of listings and prevent a separate `/incept/` page.
- `content/blog/`: blog posts written in Markdown.
- `layouts/`: shared page shell, homepage, blog listing, and post templates.
- `assets/css/style.css`: all styling.
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

## Deploy the draft server

nginx serves `/srv/incept.md/draft/public` at `https://draft.incept.md/`,
protected by HTTPS and basic auth. The password file lives outside this repo.

After editing files on this server, rebuild:

```sh
cd /srv/incept.md/draft
./scripts/build-draft.sh
```

This checkout has `git config core.hooksPath .githooks` set locally. Once the
local `draft` branch is published with `git push -u origin draft`, deploying
remote changes remains:

```sh
git -C /srv/incept.md/draft pull --ff-only
```

The server build script also requires `rsync` (installed on this server).
It builds into a temporary directory first, then syncs the successful output
to `public/`, removing stale generated pages and assets.

The post-merge hook builds Hugo when the pull brings in commits. A pull that is
already up to date does not rebuild; use the build script for local edits or to
retry a failed build. Build errors leave the currently served output intact.
No nginx reload is needed for content or template changes.

For a fresh draft checkout, enable the hook once and run the build script:

```sh
git config core.hooksPath .githooks
./scripts/build-draft.sh
```

## Production

`/srv/incept.md/main` still serves the original static site. This conversion is
local to the `draft` branch and has not been pushed. Before promoting Hugo to
production, configure a production build using `hugo --cleanDestinationDir`
(without `--buildDrafts` and using the `incept.md` base URL from `hugo.toml`).
The draft hook is only enabled in the draft checkout.

nginx configuration templates are in `deploy/nginx/`; pulling them does not
replace the installed files in `/etc/nginx/sites-available/`. Both sites use the
wildcard certificate at `/etc/letsencrypt/live/incept.md-wildcard/`.

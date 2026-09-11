# incept.md

A static site served directly by nginx. Edit files in `public/`; no build step.

## Server layout

| Site | Checkout | Branch | nginx document root |
| --- | --- | --- | --- |
| incept.md | /srv/incept.md/main | main | /srv/incept.md/main/public |
| draft.incept.md | /srv/incept.md/draft | draft | /srv/incept.md/draft/public |

`/root/incept.md` links to the main checkout. The previous standalone site is
preserved at `/var/www/incept.md` as a fallback.

The draft nginx config is installed in `sites-available` but is disabled until
DNS, a certificate, and basic-auth credentials are configured.

## One-time publication

The site import is committed locally. No branches have been pushed by this
setup. Review the commit, then publish the two branches with GitHub write access:

```sh
git -C /srv/incept.md/main push -u origin main
git -C /srv/incept.md/draft push -u origin draft
```

## Deploy

Commit and push changes from your working machine, then update the appropriate
server checkout:

```sh
git -C /srv/incept.md/main pull --ff-only
git -C /srv/incept.md/draft pull --ff-only
```

Run just the command for the site you want to update. HTML/CSS changes are live
immediately; nginx needs no reload. These checkouts use fast-forward-only pulls
and should stay free of server-only edits. GitHub reads use the public HTTPS URL;
no token is stored in either checkout.

To publish a preview, merge `draft` into `main` on GitHub or your working machine,
then pull the main checkout.

## Content

- Home: `public/index.html`
- Styles: `public/style.css`
- Blog listing: `public/blog/index.html` (add post links manually)
- Post: `public/blog/xx-post-title.html`, served at `/blog/xx-post-title`

## nginx

Templates are in `deploy/nginx/`. nginx uses installed copies under
`/etc/nginx/sites-available/`; pulling template edits does not apply them.
Install configuration changes explicitly, run `nginx -t`, and reload nginx.
The initial production configuration is backed up at
`/srv/incept.md/nginx-before-repo.conf`.

To enable the draft site later:

1. Point `draft.incept.md` DNS to this server (`217.217.233.149` for IPv4).
2. Obtain a certificate at `/etc/letsencrypt/live/draft.incept.md/` (or adjust
   the template to the actual certificate path).
3. Create `/etc/nginx/draft.incept.md.htpasswd` using `htpasswd` (provided by
   `apache2-utils`), with a username of your choice. Keep it outside the repo,
   owned by `root:www-data`, with permissions `640`.
4. Enable `/etc/nginx/sites-available/draft.incept.md` with a symlink in
   `/etc/nginx/sites-enabled/`, run `nginx -t`, then reload nginx.

The preview redirects HTTP to HTTPS and requires basic auth for all HTTPS
content, including styles and posts. Do not enable its HTTPS config before the
certificate and password file exist. TLS issuance and renewal are separate
from this local filesystem setup.

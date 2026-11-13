#!/usr/bin/env -S uv run --quiet --script
# /// script
# requires-python = ">=3.9"
# dependencies = ["markdown-it-py[linkify]>=3", "mdit-py-plugins>=0.4"]
# ///
"""Render GitHub-flavored Markdown on stdin to an HTML fragment on stdout.

Used as `markdown-command' by markdown-mode (see v2/packages.el).  Besides
plain GFM it adds a few touches so the result looks like GitHub when shown
in eww, which ignores CSS: a rule under h1/h2 and colored alert titles.

--base DIR   resolve relative image paths against DIR (the Markdown file's
             directory), so previews written elsewhere (e.g. /tmp) still
             find them.
--dark       inside <picture>, show the prefers-color-scheme: dark source.
             For eww, which ignores <source> and always shows the <img>.
"""
import argparse
import re
import sys
from pathlib import Path
from urllib.parse import urljoin

from markdown_it import MarkdownIt
from mdit_py_plugins.footnote import footnote_plugin
from mdit_py_plugins.tasklists import tasklists_plugin

md = (
    MarkdownIt("gfm-like", {"html": True})
    .use(tasklists_plugin)
    .use(footnote_plugin)
)

parser = argparse.ArgumentParser()
parser.add_argument("--base")
parser.add_argument("--dark", action="store_true")
args = parser.parse_args()

html = md.render(sys.stdin.read())

if args.dark:
    def dark_picture(m):
        pic = m.group(0)
        src = re.search(
            r'<source[^>]*media="\(prefers-color-scheme:\s*dark\)"[^>]*srcset="([^"\s]+)',
            pic,
        )
        if not src:
            return pic
        return re.sub(r'(<img[^>]*\ssrc=")[^"]*', lambda i: i.group(1) + src.group(1), pic)

    html = re.sub(r"<picture>.*?</picture>", dark_picture, html, flags=re.S)

if args.base:
    base = Path(args.base).resolve().as_uri() + "/"
    # Leave absolute URLs (scheme:, //host, /path) and fragments alone.
    absolute = re.compile(r"^(?:[a-zA-Z][a-zA-Z0-9+.-]*:|/|#)")

    def resolve(url):
        return url if absolute.match(url) else urljoin(base, url)

    def resolve_attr(m):
        name, value = m.group(1), m.group(2)
        if name == "srcset":
            parts = []
            for item in value.split(","):
                url, *rest = item.strip().split(None, 1)
                parts.append(" ".join([resolve(url), *rest]))
            value = ", ".join(parts)
        else:
            value = resolve(value)
        return f'{name}="{value}"'

    html = re.sub(r'\b(src|srcset)="([^"]*)"', resolve_attr, html)

# GitHub draws a rule under h1 and h2.
html = re.sub(r"(</h[12]>)", r"\1\n<hr>", html)

# GitHub alerts: > [!NOTE], > [!TIP], > [!IMPORTANT], > [!WARNING], > [!CAUTION]
ALERTS = {
    "NOTE": ("ⓘ Note", "#4493f8"),
    "TIP": ("💡 Tip", "#3fb950"),
    "IMPORTANT": ("❗ Important", "#ab7df8"),
    "WARNING": ("⚠ Warning", "#d29922"),
    "CAUTION": ("⛔ Caution", "#f85149"),
}


def alert(m):
    title, color = ALERTS[m.group(1)]
    return f'<blockquote>\n<p><strong style="color:{color}">{title}</strong><br>\n'


html = re.sub(
    r"<blockquote>\s*<p>\[!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\]\s*", alert, html
)

sys.stdout.write(html)

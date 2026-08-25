# mattous.co.uk

This is the code that makes my blog/website work. You can see the website here: [mattous.co.uk](https://mattous.co.uk)

It's using the [Hugo](https://gohugo.io/) framework. 

The current theme is [Terminal](https://github.com/panr/hugo-theme-terminal)

It runs on [Cloudflare pages](https://pages.cloudflare.com/)

## Running locally 

### mac

`brew install hugo`

`git clone https://github.com/mattous/hugo.git`

`cd mattous.co.uk`

`hugo server`

[http://localhost:1313]

## Updating hugo

Check the latest version of [Hugo](https://github.com/gohugoio/hugo/releases) 

In cloudflare pages, deployments, settings, environment variables. Update the HUGO_VERSION variable. 

## Updating terminal theme 

Get the latest release from the [Terminal](https://github.com/panr/hugo-theme-terminal) repo.

`cd themes/terminal`

`git fetch`

`git checkout TAG`

Comit & push changes to repo
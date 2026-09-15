+++
title = "Restoring its-all-g00d.co.uk"
date = "2026-09-15T20:00:00Z"
author = "mattous"
authorTwitter = "mattous" #do not include @
cover = ""
tags = ["blog", "tech"]
keywords = ["", ""]
description = ""
showFullContent = false
readingTime = true
hideComments = false
color = "" #color from the theme settings
draft = false
+++
Before Facebook, Discord servers, and WhatsApp group chats, there was a time when everyone just had their own little corner of the web. Between 2001 and 2006, mine was `its-all-g00d.co.uk`. 

It started out when we were in sixth form as a place to share inside jokes, post photos, and keep in touch as we all headed off to different universities across the UK. Over five years it grew into a proper archive of that time in our lives. There were thousands of forum posts, party and festival photos, exam results, guestbook messages, and personal blog posts. Eventually, university finished, life moved on, the hosting expired, and the site quietly disappeared. All that was left was a folder on an old backup drive labeled "its-all-g00d backups"—a collection of `.rar` files, raw `.sql` dumps, and old scripts from twenty years ago.

Recently, I stumbled across these backups on an old hard drive and decided to see if I could bring it all back to life. What started as a bit of nostalgia turned into a surprisingly fun project with some help from AI: getting ancient Perl and PHP running in Docker, fixing broken databases, scrubbing old personal data, and turning dynamic twenty-year-old web apps into static HTML sites.

---

## its-all-g00d.co.uk: 3 remaining versions of the site

Looking through the old files, what remained were 3 versions of the site. I do remember an older version of the site but it didn't survive it seems. Not even the internet archive shows this version, the [oldest record there](https://web.archive.org/web/20011216154136/http://www.its-all-g00d.co.uk/) is from 16/12/2001.

The first version (2001–2002) was built entirely on Perl CGI scripts and flat files. There was no database at all. It used an EncoreLite `c-board` message board where every post was just appended to a `.dat` text file on disk, NewsPro for news updates, and Image Arcadia for pictures. It had all the hallmarks of the era: neon text, animated GIFs, and a simple guestbook. The internet archive here helped restore the splash & index pages which weren't in my backups.

The second version (2002–2003) was PHP-Nuke 6.0 running against MySQL 3.23. This was the classic early-2000s portal style with the DeepBlue theme, multi-column blocks, polls, and an early version of phpBB integrated into it.

The third version (2004–2006) was the peak university years. By then I'd moved it to a standalone phpBB 2.0.10 forum in the iconic subSilver theme, alongside a 4images photo gallery and a personal PHP blog. There were over 4,700 posts across 178 topics, and hundreds of photos from proms, student nights, and festivals.

## Containerisation with Docker!

We have something now that we didn't have 20 years ago - Docker! Getting these old sites running locally in a container was the most logical way forward. Also, you can't just run PHP 4 code in modern PHP 8, it will crash spectacularly!

### Version 1

Perl's backwards compatibility meant that scripts from 2001 still run today without having to touch the original application code. The original site ran on a Windows server so there was some work to do replacing line ending characters with ones that Linux likes. Path references also needed to be updated to work with Linux. In 2017 modern Perl removed the current working directory (`.`) so there was some work to get things working there, also apache needed configuring to enable CGI execution. 

Looking at the backups of version 1 of the site, the script does end with:

```
Server: Microsoft-IIS/5.0
Date: Thu, 26 Sep 2002 11:11:45 GMT
Connection: close
Content-Length: 186
Content-Type: text/html

<head><title>CGI Application Timeout</title></head>
<body><h1>CGI Timeout</h1>The specified CGI application exceeded the allowed time for processing.  The server has deleted the process.
```

So I assume the backup I have isn't everything from the original site, 247 messages were backed up then the server timed out. I guess 19 year old me didn't notice or care at the time.

### Version 2

Getting Version 2 (PHP-Nuke 6) running was mostly a battle against ancient PHP features that modern runtimes got rid of years ago—things like register_globals and `$HTTP_*_VARS`. In the end, I used a php:5.6-apache container with old MySQL drivers compiled in, and wrote a quick globals_compat.php script to fake the old globals and silence the thousands of deprecation warnings that would otherwise flood the screen.

On the database side, MySQL 8 wouldn't touch a 2003 dump, so I paired it with a mariadb:10.1 container which is much happier with retro MySQL syntax like TYPE=MyISAM. A simple startup script pulled all the scattered bits together—the PHP-Nuke core, the photo gallery module, and a few symlinks for missing theme assets so the pages wouldn't crash.

### Version 3

By Version 3 (phpBB 2.0.10 and 4images), things had moved on from PHP-Nuke's all-in-one portal into separate apps. phpBB didn't need the messy register_globals hack anymore, but it still relied on old `mysql_*` and GD libraries to handle thumbnails and user sessions.

The database side was trickier here because this was our biggest dataset, and the backups were a bit of a mess with mixed table prefixes (`phpbb_` vs `phpbb2_`). Modern database defaults also hated phpBB's vintage queries—strict GROUP BY rules and invalid zero-dates (0000-00-00) kept killing the queries. Spinning up MariaDB with `--sql-mode=""` and `--default-storage-engine=MyISAM` was the magic fix that finally got the 179 topics and forum rankings loading without errors.

---

Once everything was running happily on `localhost`, the next question was how to actually host it. Exposing twenty-year-old PHP-Nuke and phpBB installations to the public internet would be asking for trouble—they're full of vulnerabilities that have been known about for decades, and bots would compromise them in minutes. 

## Going Static

The sensible solution was to turn everything into static sites. I kept the dynamic stacks running safely inside local Docker containers, then wrote a Python crawler to scrape every page, topic, user profile, and gallery album into flat HTML, CSS, and images. The scraper rewrote all links to relative paths, so the whole archive can run on any static web host (like CloudFlare Pages) or even directly off a USB stick with zero server maintenance and zero security worries.

## Privacy

One thing that quickly became apparent was privacy. Back in 2002, none of us thought twice about posting personal email addresses, phone numbers, or even university halls room addresses on a public forum. Before putting anything live, I made sure the Python script scrubbed the HTML: stripping `mailto:` links, removing email addresses, redacting physical addresses, and converting full names of school mates into first names and last initials (like *Emma T* or *Ben S*). That way, the conversations still read naturally, but without sharing full names twenty years later.

This is the main reason for keeping the source code and scripts private as well. I want to keep those private details private. 

## GDPR & The Data Protection Act 

Now it's one thing for me to look at this data locally in a Docker container, but quite another to put these forum posts from 20 years ago back on the public internet for anyone to see. While full names and addresses have been removed from the data you could still figure out who made many of these posts, particularly the ones I posted for example. Users of those forums back then consented to post that information online but they didn't give permission for it to be re-posted 20 years later.

Many of these messages reveal quite a bit about people's lives, or at least what their lives were like back then. They probably wouldn't be too happy to have all that info made public now that they are in their 40's.

Legally and morally speaking I'm not comfortable putting all this data out where search engines and AI bots will index it within days. So I'm putting the archived sites behind CloudFlare Access so the data won't be on the public internet but I can grant access to old friends and forum users if they request it.

## The results

I'm very happy with the results. Reading through the posts brought back a lot of memories. Thankfully the domain was still available so I snapped it up, looking back through my emails it expired in November 2007 and as far as I can tell it's been available ever since. 

- **Main Portal:** [its-all-g00d.co.uk](https://its-all-g00d.co.uk) – the landing page with the original branding, introducing the site and linking to each preserved version (requires access). 

## What I Learned

Resurrecting this corner of the internet taught me a few valuable lessons:

- Docker is a great tool for this kind of project, you can run anything locally and iterate over and over until you get it working. 
- Static sites work perfectly for this kind of project because they will never change, they cost nothing to host.
- Locking these archives down was the right thing to do, this data is interesting to me because of the memories but I can't go sharing this online again without consent. Data Protection law is a good thing!

Browsing through 20-year-old threads reminded me of what made the early web so endearing. There were no engagement algorithms, no influencer metrics, and no corporate branding—just a group of friends building something together because it was fun.

It really was all good.

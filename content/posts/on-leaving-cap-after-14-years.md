+++
title = "On Leaving CAP after 14 years"
date = "2024-04-30T23:59:59Z"
author = "mattous"
authorTwitter = "mattous" #do not include @
cover = ""
tags = ["blog"]
keywords = ["", ""]
description = ""
showFullContent = false
readingTime = true
hideComments = false
color = "" #color from the theme settings
draft = false
+++
You don't work somewhere for 14 years without it having a big impact on you. Christians Against Poverty (CAP) has been my employer for 14 years, that's 35% of my life. 

Looking back on 14 years at CAP. I’ve learned a lot… I started out as a 1st line IT support technician, then became a PHP systems developer somehow. I then went back to Operations as a Senior IT Specialist, which eventually put me at the top of a pretty shot list of IT operations staff, having to find the answer to all the questions no one else could. Then being moved into a Senior DevOps role, which was essentially the same as before except I was in a different team but with maybe more of a dev focus doing auto deployments/docker etc. 

When I started at CAP, we were still using windows XP, which dates things somewhat. One of the earliest things I remember doing is automating the formatting / installing of XP, or at least improving on it. We did this using bootable CD’s, which seems pretty outdated now when compared to zero touch deployment. It was great though, broken PC? Just whack in a CD, reboot then watch it wipe and reinstall.  A year or so later we’d decided to move everyone onto Mac minis which was well mostly. We ran our core infrastructure on 3 apple xserves, email, LDAP, DNS etc. This turned out to be a pretty bad decision as Apple stopped making them, they essentially became ticking time bombs of unreliability. We spent years moving to open source alternatives and eventually smashed the Xserves to bits in the car park. 

One of the highlights for me has to be moving our unreliable self hosted mail solution to gmail. Our IT director put called it a “solved problem”, why are we hosting our own email when Google will do a much better job of it essentially for free (because we were a charity). That saying has really stuck with me, yes we can host these things ourselves, and part of me likes the challenge that was, but it takes a lot of time and effort. I remember having to go into the office on Saturdays on occasion to physically reboot servers because email was down on a key fundraising day, no-one wants to do that. 

Another highlight was project 1D, or One Directory. As I said we have apple xserves that ran or LDAP and when they went end of life we had a problem because everything was integrated with them. This lead to a multi year project where we slowly migrated to a new LDAP, running on openldap, with a schema of our own making. We wanted to remove most of the apple schema, though we needed some of it still. We built this new openldap and synchronised with the apple LDAP, and slowly migrated all our systems over openldap before eventually turning off the xserves. Running duel systems like this is never great as it adds complexity but doing a big bang switch from the old LDAP to the new would likely have not gone well either. It presented a real technical challenge, keeping everything in sync, while migrating systems over gradually, there was a lot of moving parts. We did eventually get there, and we really did smash the xserves up in the car park. LDAP and identity management is also another “solved problem”, we could of likely just purchased a solution here and I expect CAP will do that at some point, what they have now though is “free” and identity as a service can cost quite a bit. 

There’s a lot more I could say but my journey at CAP has been a blast. I’m looking forward to the next chapter in my career as I go to join the civil service as a DevOps. During my time at CAP I had 7 different managers, 3 IT directors and CAP had 3 CEO’s, there’s been a lot of change. I’m exceptionally grateful for all of my time there, I learnt so much, made some great friends and had a lot of fun. So thank you CAP for all that you allowed me to do, I hope the work I’ve done there will continue to have an impact for many years to come. 
# Christen

Christen a proto–Internet with domain names and certficates.

Runs a DNS server with a Rails frontend which can also sign SSL certs.

## Usage

```sh
$ bin/rake db:setup
$ bin/christen
```

You can get to the web interface on http://localhost:2080 and dig the DNS at dns://localhost:2053.

Christen will generate a root key and certificate for you in `db/certs`.

More coming soon.

## Rationale

Every [Railscamp Australia](http://railscamps.com/) we remove outselves from the Internet to encourage creativity and discussion offline within the camp. To continue writing Ruby, we still need rubygems, and a bit of homebrew, and a few other bits (like [a pretend Twitter server](https://github.com/benhoskings/twetter)), so we have a mirror of some of the Internet that pretends to be those sites. A captive portal directs campers to try these sites and continue working on cool things.

This year, since Rubygems and Bundler have [gone SSL by default](http://andre.arko.net/2013/03/29/rubygems-openssl-and-you/), we had to direct people to change the [source within their Gemfiles](http://gembundler.com/v1.3/man/gemfile.5.html#SOURCES-source-). Instead, wouldn't it be nice to have it just work? But that's playing with fire — we don't want everyone to blindly trust a weird SSL certificate or fiddle with Bundler's interals. So we can create a root certificate just for railscamp, expiring at the end, with strict [PKI](http://en.wikipedia.org/wiki/Public-key_infrastructure) controls, get everyone to install it, then sign our fake rubygems.org with it.

Enter Christen. We can add DNS records to pretend to be rubygems.org, and distribute a root certificate and make HTTPS work transparently.

## Caveats

This is an incredibly naiive implementation. Real-world usage would involve running an actual DNS server which sensibly caches the records out of rails with triggered cache invalidation. Maybe I'll hook something up with powerdns and the HTTP backend at some point. The SSL implementation is also horrendously exploitable. The root key should never be on the machine serving this app, and there should be an intermediate certificate signing with a strong revocation list setup. Which is still horrendous. But, fun!

## TODO

* MX records (add a form).
* CNAME records.
* ALIAS records (proxy A records).
* ALIAS6 records (proxy AAAA records).
* Limit freely-registerable domains to `.railscamp` TLD.
* Add moderation queue for other TLDs.
* Add catch-all DNS for captive portal.
* API.

## Real-world

If you'd like a service like this that's production–ready I can't endorse [DNSimple](https://dnsimple.com) enough. My only affiliation with them is that of a very satisfied customer. If you'd like to try them out, helping me out at the same time, and getting a month of DNS hosting free, use [my referral link](https://dnsimple.com/r/805577b5f8ff18).

## License

Copyright © 2013 Samuel Cochran (sj26@sj26.com). Released under the MIT License, see LICENSE for details.

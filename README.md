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

## License

Copyright © 2013 Samuel Cochran (sj26@sj26.com). Released under the MIT License, see LICENSE for details.

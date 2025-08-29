## [Unreleased]

## [0.1.0] - 2025-08-29
- Added the ability to get `tailscale status --json` as a Ruby Hash object
- Added the ability to run `tailscale up --auth-key=#{ENV["TAILSCALE_AUTH_KEY"]} --hostname=#{::Rails.env}-app"`
- Added the ability to run `tailscaled --tun=userspace-networking --socks5-server=localhost:1055`
- Stubbed a Railtie
- Stubbed Configurations
- Stubbed CLI Flag options
- Implemented CLI interactions via the Terrapin gem 
```console 
   NOTE: need to consider the Terrapin gem dependency vs Open3
```

# **digger** Proxy #

## Installation ##
1. Install [Git](http://git-scm.com/download).
1. Install [Ruby](http://www.ruby-lang.org/en/downloads/) and [RubyGems](http://rubygems.org/pages/download).
1. Install [Bundler](http://gembundler.com/).
1. Clone the repository: `git clone git://github.com/benmanns/digger.git`.
1. Enter the digger directory: `cd digger`.
1. Install dependencies with `bundle install`.
1. Run: `bin/digger.rb [server-ip] [server-port] [proxy-ip] [proxy-port]` (defaults localhost 25565 localhost 25564).
1. Connect [Minecraft](http://www.minecraft.net) to your proxy address (default localhost:25564).

## Read the Paper ##
1. Install [Git](http://git-scm.com/download).
1. Clone the repository: `git clone git://github.com/benmanns/digger.git`.
1. Enter the digger directory: `cd digger`.
1. Generate the dvi: `latex --output-directory doc README.tex`.
1. Generate the ps: `dvips -f doc/README.dvi -o doc/README.ps`.
1. Generate the pdf: `ps2pdf doc/README.ps doc/README.pdf`.
1. Open doc/README.pdf.

## For those without Git ##
Github is also a SVN host, so this repository can be accessed without installing git via `svn checkout https://svn.github.com/benmanns/digger.git digger`.

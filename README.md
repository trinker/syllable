syllable
============


[![Project Status: Wip - Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](http://www.repostatus.org/badges/0.1.0/wip.svg)](http://www.repostatus.org/#wip)
[![Build
Status](https://travis-ci.org/trinker/syllable.svg?branch=master)](https://travis-ci.org/trinker/syllable)
[![Coverage
Status](https://coveralls.io/repos/trinker/syllable/badge.svg?branch=master)](https://coveralls.io/r/trinker/syllable?branch=master)
<a href="https://img.shields.io/badge/Version-0.0.1-orange.svg"><img src="https://img.shields.io/badge/Version-0.0.1-orange.svg" alt="Version"/></a>
</p>
<img src="inst/syllable_logo/r_syllable.png" width="200" alt="qdapRegex Logo">

**syllable** is a small collection of tools for counting syllables and
polysyllables. The tools rely primarily on
[**data.table**](https://cran.r-project.org/web/packages/data.table/index.html)
hash table lookups, resulting in fast syllable counting.


Table of Contents
============

-   [Installation](#installation)
-   [Contact](#contact)

Installation
============


To download the development version of **syllable**:

Download the [zip
ball](https://github.com/trinker/syllable/zipball/master) or [tar
ball](https://github.com/trinker/syllable/tarball/master), decompress
and run `R CMD INSTALL` on it, or use the **pacman** package to install
the development version:

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load_gh("trinker/syllable")

Contact
=======

You are welcome to: 
* submit suggestions and bug-reports at: <https://github.com/trinker/syllable/issues> 
* send a pull request on: <https://github.com/trinker/syllable/> 
* compose a friendly e-mail to: <tyler.rinker@gmail.com>

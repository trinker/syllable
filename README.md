syllable
============


[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)
[![Build
Status](https://travis-ci.org/trinker/syllable.svg?branch=master)](https://travis-ci.org/trinker/syllable)
[![Coverage
Status](https://coveralls.io/repos/trinker/syllable/badge.svg?branch=master)](https://coveralls.io/r/trinker/syllable?branch=master)
[![DOI](https://zenodo.org/badge/5398/trinker/syllable.svg)](https://zenodo.org/badge/latestdoi/5398/trinker/syllable)<a href="https://img.shields.io/badge/Version-0.1.0-orange.svg"><img src="https://img.shields.io/badge/Version-0.1.0-orange.svg" alt="Version"/></a>
</p>
<img src="inst/syllable_logo/r_syllable.png" width="200" alt="qdapRegex Logo">

**syllable** is a small collection of tools for counting syllables and
polysyllables. The tools rely primarily on
[**data.table**](https://cran.r-project.org/web/packages/data.table/index.html)
hash table lookups, resulting in fast syllable counting.

The main functions follow the format of `action_object`.


Table of Contents
============

-   [Actions](#actions)
-   [Objects](#objects)
-   [Putting It Together](#putting-it-together)
-   [Installation](#installation)
-   [Contact](#contact)
-   [Examples](#examples)

Actions
============


The following table outlines the actions. Example Output correspond to
this string: `"I like chicken sandwiches."`.

<table>
<thead>
<tr class="header">
<th align="left">Action</th>
<th align="left">Description</th>
<th align="left">Returns</th>
<th align="left">Example Output</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left"><code>count</code></td>
<td align="left">One integer per word</td>
<td align="left">A vector per string</td>
<td align="left">1, 1, 2, 3</td>
</tr>
<tr class="even">
<td align="left"><code>sum</code></td>
<td align="left">Sum of syllable counts</td>
<td align="left">An integer per string</td>
<td align="left">7</td>
</tr>
<tr class="odd">
<td align="left"><code>tally</code>*</td>
<td align="left">Sum of syllable attributes</td>
<td align="left">An integer per string</td>
<td align="left">pollysyllable tallies = 1</td>
</tr>
</tbody>
</table>

\* The addition of `_mono`, `_di`, `_poly` `_short` (monosyllabic +
disyllabic), or `_both` (short & pollysyllabic) to `tally` allows the
user specify what syllable attribute is being tallied.

Objects
-------

The following table outlines the objects acted upon:

<table>
<thead>
<tr class="header">
<th align="left">Object</th>
<th align="left">Description</th>
<th align="left">Example</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left"><code>string</code></td>
<td align="left">A character string</td>
<td align="left"><code>&quot;I like chicken sandwiches.&quot;</code></td>
</tr>
<tr class="even">
<td align="left"><code>vector</code>*</td>
<td align="left">A vector of character strings</td>
<td align="left"><code>c(&quot;I like it.&quot;, &quot;Look out!&quot;)</code></td>
</tr>
</tbody>
</table>

\* The addition of `_by` to `vector` allows the user to aggregate by one
or more vectors of grouping variables.

Putting It Together
-------------------

The function `count_vector` will provide a vector of integer counts for
each word in a string. For this reason `count_vector` will return a
`list` of integer vector counts.

    count_vector(c("I like it.", "Look out!"))

    ## $`1`
    ## [1] 1 1 1
    ## 
    ## $`2`
    ## [1] 1 1

Each of the main functions is optimized to do its task efficiently.
While one could use `sum(count_vector(x))` and achieve the same results
as `sum_vector(x)` it would be less efficeint.

The available syllable functions that follow the format of
`action_object` are:

<!-- html table generated in R 3.3.0 by xtable 1.7-4 package -->
<!-- Thu Aug 06 22:04:48 2015 -->
<table>
<tr>
<td>
count_string
</td>
<td>
tally_both_string
</td>
<td>
tally_mono_string
</td>
<td>
tally_short_string
</td>
</tr>
<tr>
<td>
count_vector
</td>
<td>
tally_both_vector
</td>
<td>
tally_mono_vector
</td>
<td>
tally_short_vector
</td>
</tr>
<tr>
<td>
count_vector_by
</td>
<td>
tally_both_vector_by
</td>
<td>
tally_mono_vector_by
</td>
<td>
tally_short_vector_by
</td>
</tr>
<tr>
<td>
sum_string
</td>
<td>
tally_di_string
</td>
<td>
tally_poly_string
</td>
<td>
</td>
</tr>
<tr>
<td>
sum_vector
</td>
<td>
tally_di_vector
</td>
<td>
tally_poly_vector
</td>
<td>
</td>
</tr>
<tr>
<td>
sum_vector_by
</td>
<td>
tally_di_vector_by
</td>
<td>
tally_poly_vector_by
</td>
<td>
</td>
</tr>
</table>
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


Examples
========
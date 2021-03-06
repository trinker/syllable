NEWS
====

Versioning
----------

Releases will be numbered with the following semantic versioning format:

&lt;major&gt;.&lt;minor&gt;.&lt;patch&gt;

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor
  and patch)
* New additions without breaking backward compatibility bumps the minor
  (and resets the patch)
* Bug fixes and misc changes bumps the patch



syllable 0.2.0 -
----------------------------------------------------------------

**BUG FIXES**

**NEW FEATURES**

**MINOR FEATURES**

**IMPROVEMENTS**

**CHANGES**



syllable 0.1.3
----------------------------------------------------------------

**CHANGES**

* `as.tibble` removed from all function arguments.  This was a nice interactive
  feature that made programming very difficult to reason about.  Having an
  environment dependant output would result in no adoption of the **syllable**
  package as a dependency.  The problem was so egregious and the package infant
  enough, that removal without deprecation was warranted.



syllable 0.1.0 - 0.1.2
----------------------------------------------------------------

**NEW FEATURES**

* Users can now globally select a **tibble** output rather than a **data.table**
  output for all functions that outputted a **data.table**.  This can be set
  globally via `set_output`.  If the user does not set the output type
  **syllable** tries to infer based on whether or not the user has **dplyr**
  loaded.  If **dplyr** is loaded then **tibble** is the default output.

* `set_output` and `tibble_output` imported from **textshape** to globally set the
  output type (**tibble** or **data.table**) and to check/infer the desired output
  type.

**IMPROVEMENTS**

* `readability_word_stats` and `readability_word_stats_by` used **stringi**'s
  sentence detection.  This was not accurate as seen:
  http://stackoverflow.com/q/31865511/1000343.  The package now utilizes
  **NLP**/**openNLP** to detect number of sentences.  This comes at the cost of
  speed.

* `readability_word_stats` now removes -es & -ed suffixes for calculating
  `n.complexes`.

**CHANGES**

* **NLP** and **openNLP** dependencies replaced with **textshape** and
  **textclean** to improve sentence detection speed.

* **textcleanLite** dependency replaced with **textclean** because the
  **hunspell** dependency in **textclean** is no longer explicitly imported.
  This allows the package to be used within trickier environments such as
  Microsoft Azure.



syllable 0.0.1
----------------------------------------------------------------

This package is a small collection of tools for counting <a href="https://github.com/trinker/syllable" target="_blank">syllable</a>s and
polysyllables.  The tools rely primarily on a 'data.table' hash table lookup,
resulting in fast <a href="https://github.com/trinker/syllable" target="_blank">syllable</a> counting.
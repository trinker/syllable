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


syllable 0.1.0
----------------------------------------------------------------

**BUG FIXES**

**NEW FEATURES**

**MINOR FEATURES**

IMPROVEMENTS

* `readability_word_stats` and `readability_word_stats_by` used **stringi**'s
  sentence detection.  This was not accurate as seen:
  http://stackoverflow.com/q/31865511/1000343.  The package now utilizes
  **NLP**/**openNLP** to detect number of sentences.  This comes at the cost of
  speed.

**CHANGES**

syllable 0.0.1
----------------------------------------------------------------

This package is a small collection of tools for counting <a href="https://github.com/trinker/syllable" target="_blank">syllable</a>s and
polysyllables.  The tools rely primarily on a 'data.table' hash table lookup,
resulting in fast <a href="https://github.com/trinker/syllable" target="_blank">syllable</a> counting.
bad_touch
=========

A Python application to categorize file touches within a repository. Output is generated as a CSV of the form:
<pre><code>(story touch count),(defect touch count),file/path/filename.extension</code></pre>
The produced data will give an idea of the change density of files and the change cause. This points out files that are hotspots and should be considered for refactoring as well as files that are delicate and should be changed carefully.

For large repositories this can take a significant amount of time (>30 minutes) and currently gives no progress indication.

tests
=====
<pre><code>bundle install
cucumber</code></pre>

usage
=====
<pre><code>easy_install gitpython
python src/bad_touch.py path/to/repository/root</code></pre>

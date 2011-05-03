truncateHTML
==============
`truncateHTML` truncates text like the Rails `truncate` helper but doesn't break HTML tags, entities, and optionally words.

Installation
------------

The `truncateHTML` gem can be installed by running:

    gem install truncateHTML

Usage
-----

    require 'rubygems'
    require 'truncateHTML'

A string `html_string` can be truncated by running:

    truncateHTML.truncate(`html_string`) 

The following options can be passed to the `trucate` method:

- `:max_length` The maximum length of the out put. Defaults to 40
- `:ellipsis` The last few characters , in case the string is truncated. Defaults to `...`
- `:words` Splicing words will be avoided if set to ttrue. Defaults to false.
- `:link` A link will be appended to the truncated string if explicitely passed. Its by default nil.

Author
------

B V Satyaram <[bvsatyaram.com](http://bvsatyaram.com)>

- Initially authored By Henrik Nyh <[henrik.nyh.se](http://henrik.nyh.se)> 2008-01-30. Free to modify and redistribute with credit.
- Modified by Dave Nolan <[textgoeshere.org.uk](http://textgoeshere.org.uk)> 2008-02-06. Ellipsis appended to text of last HTML node. Ellipsis inserted after final word break
- Modified by Mark Dickson <mark@sitesteaders.com> 2008-12-18. Option to truncate to last full word. Option to include a 'more' link. Check for nil last child
- Modified by Ken-ichi Ueda <[kueda.net](http://kueda.net)> 2009-09-02. Rails 2.3 compatability (chars -> mb_chars), via Henrik. Hpricot 0.8 compatability (avoid dup on Hpricot::Elem)
- Modified by B V Satyaram <[bvsatyaram.com](http://bvsatyaram.com)> 2011-03-24. Rails version independent. Making this a gem. Removed mb_chars

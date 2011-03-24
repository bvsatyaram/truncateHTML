# By Henrik Nyh <http://henrik.nyh.se> 2008-01-30.
# Free to modify and redistribute with credit.

# modified by Dave Nolan <http://textgoeshere.org.uk> 2008-02-06
# Ellipsis appended to text of last HTML node
# Ellipsis inserted after final word break

# modified by Mark Dickson <mark@sitesteaders.com> 2008-12-18
# Option to truncate to last full word
# Option to include a 'more' link
# Check for nil last child

# modified by Ken-ichi Ueda <http://kueda.net> 2009-09-02
# Rails 2.3 compatability (chars -> mb_chars), via Henrik
# Hpricot 0.8 compatability (avoid dup on Hpricot::Elem)

# modified by Satyaram B V <http://bvsatyaram.com> 2011-03-24
# Rails 3 compatibility
# Making this a gem
# Removed mb_chars

require "hpricot"
require "truncateHTML/hpricot_truncator"

module TruncateHTML
  # Like the Rails _truncate_ helper but doesn't break HTML tags, entities, and optionally. words.
  def self.truncate(text, options={})
    return if text.nil?

    max_length = options[:max_length] || 40
    ellipsis = options[:ellipsis] || "..."
    words = options[:words] || false
    status = options[:status] || false
    # use :link => link_to('more', post_path), or something to that effect

    doc = Hpricot(text.to_s)
    ellipsis_length = Hpricot(ellipsis).inner_text.length
    content_length = doc.inner_text.length
    actual_length = max_length - ellipsis_length

    if content_length > max_length
      truncated_doc = doc.truncate(actual_length)

      if words
        word_length = actual_length - (truncated_doc.inner_html.length - truncated_doc.inner_html.rindex(' '))
        truncated_doc = doc.truncate(word_length)
      end

      #XXX The check here has to be blank as the inner_html for text node is blank
      return_string = truncated_doc.inner_html + ellipsis
      return_string += options[:link] if options[:link]
      return_status = true
    else
      return_string = text.to_s
      return_status = false
    end

    return status ? [return_string, return_status] : return_string
  end
end
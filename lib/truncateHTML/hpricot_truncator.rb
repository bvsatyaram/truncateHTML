module HpricotTruncator
  module NodeWithChildren
    def truncate(max_length)
      return self if inner_text.length <= max_length
      truncated_node = if self.is_a?(Hpricot::Doc)
        self.dup
      else
        self.class.send(:new, self.name, self.attributes)
      end
      truncated_node.children = []
      each_child do |node|
        if node.is_a?(Hpricot::Elem) && node.name == "html"
          node.children.each do |c|
            # Find the body node and use it. Let us reset earlier truncations
            # and start afresh with this body tag
            return c.truncate(max_length) if (c.is_a?(Hpricot::Elem) && c.name == "body")
          end
        end

        remaining_length = max_length - truncated_node.inner_text.length
        break if remaining_length <= 0
        truncated_node.children << node.truncate(remaining_length)
      end
      truncated_node
    end
  end

  module TextNode
    def truncate(max_length)
      # We're using String#scan because Hpricot doesn't distinguish entities.
      Hpricot::Text.new(content.scan(/&#?[^\W_]+;|./).first(max_length).join)
    end
  end

  module IgnoredTag
    def truncate(max_length)
      self
    end
  end
end

Hpricot::Doc.send(:include,       HpricotTruncator::NodeWithChildren)
Hpricot::Elem.send(:include,      HpricotTruncator::NodeWithChildren)
Hpricot::Text.send(:include,      HpricotTruncator::TextNode)
Hpricot::BogusETag.send(:include, HpricotTruncator::IgnoredTag)
Hpricot::Comment.send(:include,   HpricotTruncator::IgnoredTag)
Hpricot::DocType.send(:include,   HpricotTruncator::IgnoredTag)
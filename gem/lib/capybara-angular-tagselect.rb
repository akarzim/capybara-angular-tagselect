require 'capybara-angular-tagselect/version'
require 'rspec/core'

module Capybara
  module Angular
    module Tagselect
      def tag_select(value, from: nil, from_tag: nil, xpath: nil)
        fail "Must pass a hash containing 'from' or 'from_tag' or 'xpath'" unless [from, from_tag, xpath].any? &:present?

        container = first :xpath, xpath if xpath.present?
        container ||= first "div[tag-select='#{from_tag}']" if from_tag.present?
        container ||= first('label', text: from).find(:xpath, '..').find 'div[tag-select]' if from.present?

        tag_container = TagContainer.new container
        tag_container.search = value

        tag_container.first_pane.add_or_browse_tag

        fail unless tag_container.has_tag?
      end

      class TagContainer
        attr_reader :container
        attr_accessor :search

        def initialize(selector)
          @container = selector
          @search_input = @container.first 'input[ng-model="search"]'
        end

        def search=(value)
          @search_input.set value
          @search = value
        end

        def has_tag?
          container.has_css? 'span.ng-binding', text: search
        end

        def first_pane
          TagPane.new self, nil
        end

        def next_pane(tag_pane)
          TagPane.new self, tag_pane.pane.find(:xpath, './/following-sibling::ul')
        end
      end

      class TagPane
        attr_reader :tag_container, :pane, :element

        def initialize(tag_container, pane)
          @tag_container = tag_container
          @pane = pane || @tag_container.container.find('ul', match: :prefer_exact)
          @element = @pane.first('li')
        end

        def add_or_browse_tag
          if element.has_css?('i[ng-show]') && element.text != tag_container.search
            browse_tag
          else
            add_tag
          end
        end

        def add_tag
          element.hover
          element.find('div>i[ng-click^="addTag"]').click
        end

        def next_sibling
          tag_container.next_pane self
        end

        def browse_tag
          element.click
          next_sibling.add_or_browse_tag
        end
      end
    end
  end
end

RSpec.configure do |c|
  c.include Capybara::Angular::Tagselect
end

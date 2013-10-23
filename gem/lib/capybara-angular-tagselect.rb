require 'capybara-angular-tagselect/version'
require 'rspec/core'

module Capybara
  module AngularTagselect
    def tag_select(value, from: nil, from_tag: nil, xpath: nil)
      fail "Must pass a hash containing 'from' or 'from_tag' or 'xpath'" unless [from, from_tag, xpath].any? &:present?

      tag_container = first :xpath, xpath if xpath.present?
      tag_container ||= first "div[tag-select='#{from_tag}']" if from_tag.present?
      tag_container ||= first('label', text: from).find(:xpath, '..').find 'div[tag-select]' if from.present?

      tag_search = tag_container.first 'input[ng-model="search"]'

      tag_search.set value

      tag_last_pane = tag_container.find 'ul:last'
      tag_element = tag_last_pane.first 'li'

      tag_element.hover

      tag_add_link = tag_element.find 'div>i[ng-click^="addTag"]'

      tag_add_link.click

      fail unless page.has_css? tag_container.find('span.ng-binding', text: value)
    end
  end
end

RSpec.configure do |c|
  c.include Capybara::AngularTagselect
end

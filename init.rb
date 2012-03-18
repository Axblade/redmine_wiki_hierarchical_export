require 'redmine'
require 'dispatcher'
require "#{File.dirname(__FILE__)}/lib/pdf"

Redmine::Plugin.register :redmine_wiki_hierarchical_export do
  name 'Redmine Wiki Hierarchical Export plugin'
  author 'Eugene Sypachev'
  description 'You can export wiki child pages by one click with this plugin'
  version '0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'https://github.com/Axblade'

  Dispatcher.to_prepare :redmine_wiki_hierarchical_export do
    # nothing here
  end
end

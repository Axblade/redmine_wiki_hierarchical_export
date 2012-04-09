require 'redmine'
require 'dispatcher'
require "#{File.dirname(__FILE__)}/lib/pdf"

Redmine::Plugin.register :redmine_wiki_hierarchical_export do
  name 'Redmine Wiki Hierarchical Export plugin'
  author 'Eugene Sypachev'
  description 'You can export wiki child pages by one click with this plugin'
  version '0.1'
  url 'https://github.com/Axblade/redmine_wiki_hierarchical_export'
  author_url 'https://github.com/Axblade'

  requires_redmine :version_or_higher => '1.3.0'

  Dispatcher.to_prepare :redmine_wiki_hierarchical_export do
    # nothing here
  end
end

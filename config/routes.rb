if Rails::VERSION::MAJOR >= 3
  RedmineApp::Application.routes.draw do
    match 'pdf_hierarchical_export', :to => 'export#export', :as => 'hierarchical_export'
  end
end

###
# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

activate :livereload

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end

after_configuration do 
  Bower.setup(root, sprockets)
end

require 'sprockets/directive_processor'

module Bower

  def self.setup(root, sprockets_environment)
      sprockets_environment.append_path "#{root}/#{bower_install_path}"
      sprockets_environment.register_preprocessor 'application/javascript', Bower::DirectiveProcessor
  end

  def self.bower_install_path
    bowerrc = JSON.parse(IO.read('.bowerrc'))
    bowerrc["directory"]
  end

  class Bower::DirectiveProcessor < Sprockets::DirectiveProcessor
    
    def process_require_bower_dependencies_directive
      bower_dependencies.each do |filename|
        context.require_asset(filename)
      end
    end

    private
    def bower_dependencies
      cmd = 'bower ls --paths'
      data = IO.popen(cmd)
      bower_paths = JSON.parse(data.read).keys
      data.close 

      bower_paths
    end
end

end
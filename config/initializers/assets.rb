# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( bootstrap.css )
Rails.application.config.assets.precompile += %w( animate.css )
Rails.application.config.assets.precompile += %w( style.css )
Rails.application.config.assets.precompile += %w( jQuery.js.js )
Rails.application.config.assets.precompile += %w( script.js )
Rails.application.config.assets.precompile += %w( homepage_script.js )
Rails.application.config.assets.precompile += %w( logged_in.css )
Rails.application.config.assets.precompile += %w( student_users.js )
Rails.application.config.assets.precompile += %w( education_form.js )
Rails.application.config.assets.precompile += %w( experience_form.js )
Rails.application.config.assets.precompile += %w( project_form.js )
Rails.application.config.assets.precompile += %w( jobs.js )
Rails.application.config.assets.precompile += %w( populate_branches.js )
Rails.application.config.assets.precompile += %w( ckeditor/* )
Rails.application.config.assets.precompile += %w( ckeditor/config.js )





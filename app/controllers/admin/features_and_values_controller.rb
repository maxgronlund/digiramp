class Admin::FeaturesAndValuesController < ApplicationController
  before_filter :admin_only, except: [:destroy]
  def index
    @features_and_values_blog = Blog.cached_find('features and values')
    @intro          = BlogPost.cached_find( 'intro', @features_and_values_blog)
    @social         = BlogPost.cached_find( 'social', @features_and_values_blog)
    @creatives      = BlogPost.cached_find( 'creatives', @features_and_values_blog)
    @pros           = BlogPost.cached_find( 'pros', @features_and_values_blog)
    @brands         = BlogPost.cached_find( 'brands', @features_and_values_blog)
    @digiramp       = BlogPost.cached_find( 'digiramp', @features_and_values_blog)
    
  end
end

# Functions to return post data if running mm server or
# handlebars stuff for building the Ghost template
def root_url
  if build?
    "{{@blog.url}}"
  else  
    "/"
  end
end

def blog_title
  if build?
    "{{@blog.title}}"
  else  
    @settings['title']
  end
end

def blog_description
  if build?
    "{{@blog.description}}"
  else  
    @settings['description']
  end
end

def blog_cover
  if build?
    "{{@blog.cover}}"
  else  
    "/assets/images/header_placeholder.jpg"
  end
end

def post_title (post)
  if build?
    "{{title}}"
  else  
    post['title']
  end
end

def post_slug (post)
  if build?
    "{{url}}"
  else  
    "#{post['slug']}.html"
  end
end

def post_published_at (post)
  if build?
    "{{date format='YYYY-MM-DD'}}"
  else  
    Time.at( post['published_at'] / 1000 ).strftime("%Y-%m-%d")
  end
end

def display_post_published_at (post)
  if build?
    "{{date format='MMMM DD'}}"
  else  
    Time.at( post['published_at'] / 1000 ).strftime("%B %d")
  end
end

def post_content (post)
  if build?
    "{{content}}"
  else  
    post['html']
  end
end
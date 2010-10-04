SimpleNavigation::Configuration.run do |navigation|
  navigation.id_generator = Proc.new {|key| "menu-#{key}"}
  navigation.items do |primary|
    primary.item :home, 'Home', admin_path, :if => Proc.new { in_admin? }
    primary.item :articles, 'Articles', admin_articles_path, :if => Proc.new { in_admin? }
    primary.item :albums, 'Albums', admin_albums_path, :if => Proc.new { in_admin? }
    primary.item :films, 'Films', admin_films_path, :if => Proc.new { in_admin? }
    primary.item :pages, 'Pages', admin_pages_path, :if => Proc.new { in_admin? }
    
    primary.item :articles, "<span class='hidden'>News</span>".html_safe, articles_path, :if => Proc.new { !in_admin? }
    primary.item :films, "<span class='hidden'>Films</span>".html_safe, films_path, :highlights_on => /\/films/, :if => Proc.new { !in_admin? }
    primary.item :albums, "<span class='hidden'>Photography</span>".html_safe, albums_path, :highlights_on => /\/albums/, :if => Proc.new { !in_admin? }
    primary.item :bio, "<span class='hidden'>Bio</span>".html_safe, page_path('bio'), :if => Proc.new { !in_admin? }
    primary.item :cv, "<span class='hidden'>C.V.</span>".html_safe, page_path('cv'), :if => Proc.new { !in_admin? }
    primary.item :contact, "<span class='hidden'>Contact</span>".html_safe, contact_path, :if => Proc.new { !in_admin? }
  end
end
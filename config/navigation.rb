SimpleNavigation::Configuration.run do |navigation|
  navigation.id_generator = Proc.new {|key| "menu-#{key}"}
  navigation.items do |primary|
    primary.item :home, 'Home', admin_path, :if => Proc.new { in_admin? }
    primary.item :articles, 'Articles', admin_articles_path, :if => Proc.new { in_admin? }
    primary.item :albums, 'Albums', admin_albums_path, :if => Proc.new { in_admin? }
    primary.item :films, 'Films', admin_films_path, :if => Proc.new { in_admin? }
    primary.item :pages, 'Pages', admin_pages_path, :if => Proc.new { in_admin? }
  end
end
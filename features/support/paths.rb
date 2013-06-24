# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^the RottenPotatoes home\s?page$/
      '/movies'

    when /^the Create New Movie\s?page$/
      '/movies/new'

    when /^the Search Results\s?page$/
      '/movies/search_tmdb'

    when /^the Similar Movies page for/
      '/movies/similar_movie'

    when /^the edit page for "(.+)"$/
      movie = Movie.find_by_title($1)
      "/movies/#{movie.id}/edit"

    when /^the details page for "(.+)"$/
      movie = Movie.find_by_title($1)
      "/movies/#{movie.id}"

    when /Similar Movies page for "(.+)"$/
      movie = Movie.find_by_title($1)
      "/movies/similar_movie?:director => #{movie.director}"

    when /^the Show Movie\s?page for "(.+)"$/
      movie = Movie.find_by_title($1)
      "/movies/#{movie.id}"
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)

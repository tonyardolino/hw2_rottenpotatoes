class Movie < ActiveRecord::Base

  class Movie::InvalidKeyError < StandardError ; end

  def self.api_key
    '4d6fddcdf0f5f1771310dacb647f34ef' # replace with YOUR Tmdb key
  end

  def self.find_in_tmdb(string)
    Tmdb.api_key = self.api_key
    begin
      TmdbMovie.find(:title => string)
    rescue ArgumentError => tmdb_error
      raise Movie::InvalidKeyError, tmdb_error.message
    rescue RuntimeError => tmdb_error
      if tmdb_error.message =~ /status code '404'/
        raise Movie::InvalidKeyError, tmdb_error.message
      else
        raise RuntimeError, tmdb_error.message
      end
    end
  end

  scope :with_good_reviews, lambda { |threshold|
    Movie.joins(:reviews).group(:movie_id).
    having(['AVG(reviews.potatoes) > ?', threshold])
  }
  scope :for_kids, lambda {
    Movie.where('rating in ?', %w(G PG))
  }
  has_many :reviews
  before_save :capitalize_title
  def capitalize_title
    self.title = self.title.split(/\s+/).map(&:downcase).
      map(&:capitalize).join(' ')
  end
  def self.all_ratings ; %w[G PG PG-13 R NC-17] ; end #  shortcut: array of strings
  validates :title, :presence => true
  validates :release_date, :presence => true
  validate :released_1930_or_later # uses custom validator below
  validates :rating, :inclusion => {:in => Movie.all_ratings},
    :unless => :grandfathered?
  def released_1930_or_later
    errors.add(:release_date, 'must be 1930 or later') if
      self.release_date < Date.parse('1 Jan 1930')
  end
  @@grandfathered_date = Date.parse('1 Nov 1968')
  def grandfathered? ; self.release_date >= @@grandfathered_date ; end
end

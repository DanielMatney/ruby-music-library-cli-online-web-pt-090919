class MusicLibraryController
  attr_accessor :path
  
  def initialize(path = './db/mp3s')
    @path = path
    library = MusicImporter.new(path)
    library.import
  end
  
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = ""
    until input == "exit"
      input = gets.chomp
      case input
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
      end 
    end
  end
  
  def list_songs
    sorted = Song.all.sort {|a, b| a.name <=> b.name}
    index = 1
    sorted.each do |song| 
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      index += 1
    end 
  end
  
  def list_artists
    sorted = Artist.all.sort {|a, b| a.name <=> b.name}
    index = 1
    sorted.each do |artist| 
      puts "#{index}. #{artist.name}"
      index += 1
    end 
  end
  
  def list_genres
    sorted = Genre.all.sort {|a, b| a.name <=> b.name}
    index = 1
    sorted.each do |genre| 
      puts "#{index}. #{genre.name}"
      index += 1
    end 
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    name = gets.chomp
    artist = Artist.find_by_name(name)
    if artist != nil
      sorted = artist.songs.sort {|a, b| a.name <=> b.name}
      index = 1
      sorted.each do |song|
        puts "#{index}. #{song.name} - #{song.genre.name}"
        index += 1
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    name = gets.chomp
    genre = Genre.find_by_name(name)
    if genre != nil
      sorted = genre.songs.sort {|a, b| a.name <=> b.name}
      index = 1
      sorted.each do |song|
        puts "#{index}. #{song.artist.name} - #{song.name}"
        index += 1
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    number = gets.chomp.to_i
    list = Song.all.sort {|a, b| a.name <=> b.name}
    i = 1
    list.each do |song|
      if i == number
        puts "Playing #{song.name} by #{song.artist.name}"
      end
      i += 1
    end
  end
  
end
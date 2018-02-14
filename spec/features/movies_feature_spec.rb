require "rails_helper"

describe "/movies" do
  it "displays each movie's title and year", points: 5 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    visit "/movies"

    movies = Movie.all
    movies.each do |movie|
      expect(page).to have_content(movie.title)
      expect(page).to have_content(movie.year)
    end
  end
end

describe "/movies" do
  it "displays each movie's director", points: 10 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    visit "/movies"

    movies = Movie.all
    movies.each do |movie|
      director = Director.find_by(id: movie.director_id)
      expect(page).to have_content(director.name)
    end
  end
end

describe "/movies/[MOVIE ID]" do
  it "displays a functional delete link for each movie", points: 5, hint: h("copy_must_match") do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    movies = Movie.all

    movies.each do |movie|
      visit "/movies/#{movie.id}"
      expect(page).to have_content(movie.title)
      expect(page).to have_content(movie.year)
      count_of_movies = Movie.count
      click_link 'Delete', match: :first
      expect(Movie.count).to eq(count_of_movies - 1)
    end
  end
end

describe "/movies/[MOVIE ID]" do
  it "displays the movie's title and year", points: 5 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    movies = Movie.all
    movies.each do |movie|
      visit "/movies/#{movie.id}"
      expect(page).to have_content(movie.title)
      expect(page).to have_content(movie.year)
    end
  end
end

describe "/movies/[MOVIE ID]" do
  it "displays the movie's director", points: 10 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    movies = Movie.all
    movies.each do |movie|
      visit "/movies/#{movie.id}"
      director = Director.find_by(id: movie.director_id)
      expect(page).to have_content(director.name)
    end
  end
end

describe "/movies/[MOVIE ID]" do
  it "displays a count of the movie's characters", points: 5 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    leo = create(:actor, name: "Leonardo DiCaprio", dob: "November 11, 1974")
    create(:character, name: 'Cobb', movie_id: inception.id, actor_id: leo.id)
    create(:character, name: 'Billy Costigan', movie_id: departed.id, actor_id: leo.id)

    jack = create(:actor, name: "Jack Nicholson", dob: "April 22, 1937")
    create(:character, name: 'Frank Costello', movie_id: departed.id, actor_id: jack.id)

    bob = create(:actor, name: "Robert De Niro", dob: "August 17, 1943")
    create(:character, name: 'James Conway', movie_id: goodfellas.id, actor_id: bob.id)

    movies = Movie.all
    movies.each do |movie|
      visit "/movies/#{movie.id}"
      count_of_characters = Character.where(movie_id: movie.id).count
      expect(page).to have_content(count_of_characters)
    end
  end
end

describe "/movies/[MOVIE ID]" do
  it "displays a list of the movie's actors (cast)", points: 5 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    leo = create(:actor, name: "Leonardo DiCaprio", dob: "November 11, 1974")
    create(:character, name: 'Cobb', movie_id: inception.id, actor_id: leo.id)
    create(:character, name: 'Billy Costigan', movie_id: departed.id, actor_id: leo.id)

    jack = create(:actor, name: "Jack Nicholson", dob: "April 22, 1937")
    create(:character, name: 'Frank Costello', movie_id: departed.id, actor_id: jack.id)

    bob = create(:actor, name: "Robert De Niro", dob: "August 17, 1943")
    create(:character, name: 'James Conway', movie_id: goodfellas.id, actor_id: bob.id)

    movies = Movie.all
    movies.each do |movie|
      visit "/movies/#{movie.id}"
      characters = Character.where(movie_id: movie.id)
      characters.each do |character|
        actor = Actor.find_by(id: character.actor_id)
        expect(page).to have_content(actor.name)
      end
    end
  end
end

describe "/movies/[MOVIE ID]" do
  it "displays a form to add a new character", points: 2 do
    movies = Movie.all
    movies.each do |movie|
      visit "/movies/#{movie.id}"
      expect(page).to have_selector("form", count: 1)
    end
  end
end

describe "/movies/[MOVIE ID]" do
  it "creates a new character for the movie after submitting the form", points: 10, hint: h("copy_must_match") do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    wolf = create(:movie, title: "The Wolf of Wall Street", year: 2013, duration: 180, director_id: scorsese.id)
    leo = create(:actor, name: "Leonardo DiCaprio", dob: "November 11, 1974")

    visit "/movies/#{wolf.id}"
    expect(page).to have_selector("form")

    count_of_characters = Character.where(movie_id: wolf.id).count

    fill_in 'Name', with: 'Jordan Belfort'
    select 'Leonardo DiCaprio'
    click_button 'Create character'

    expect(Character.where(movie_id: wolf.id).count).to eq(count_of_characters + 1)
  end
end

describe "/movies/[MOVIE ID]" do
  it "displays a hidden input field to associate a new character to the movie", points: 10 do
    movies = Movie.all
    movies.each do |movie|
      visit "/movies/#{movie.id}"
      expect(page).to have_selector("input[value='#{movie.id}']", visible: false),
        "expected to find a hidden input field with the movie's id as the value"
    end
  end
end

describe "/movies/new" do
  it "includes a dropdown with directors", points: 10 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)


    visit "/movies/new"

    expect(page).to have_selector("select[name='director_id']"), 'expected to find a select field for director_id in the form'

    directors = Director.all
    directors.each do |director|
      expect(page).to have_selector("select[name='director_id'] option[value='#{director.id}']"),
        "expected to find options in the select field with value attributes for each director's id"
      dropdown_option = find("select[name='director_id'] option[value='#{director.id}']").text
      expect(dropdown_option).to eq(director.name),
        "expected to find options in the select field displaying each director's name"
    end
  end
end

describe "/movies/new" do
  it "displays a link to add a new director", points: 2 do
    visit "/movies/new"

    expect(page).to have_link(nil, href: /directors\/new/)
  end
end

describe "/movies/new" do
  it 'creates a new movie after submitting the form', points: 5, hint: h("copy_must_match") do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    
    visit "/movies/new"

    expect(page).to have_selector("form")

    count_of_movies = Movie.count

    fill_in 'Title', with: 'Hugo'
    fill_in 'Year', with: 2011
    fill_in 'Duration', with: 126
    fill_in 'Description', with: 'In Paris in 1931, an orphan named Hugo Cabret who lives in the walls of a train station is wrapped up in a mystery involving his late father and an automaton.'
    select 'Martin Scorsese'
    click_button 'Create movie'

    new_count_of_movies = count_of_movies + 1
    expect(Movie.count).to eq(new_count_of_movies)
  end
end

describe "/movies/[MOVIE ID]/edit" do
  it "includes a dropdown with directors", points: 10 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    movie = Movie.last
    visit "/movies/#{movie.id}/edit"

    within("select[name='director_id']") do
      directors = Director.all
      directors.each do |director|
        expect(find("option[value='#{director.id}']").text).to eq(director.name),
          "expected to find options in the select field displaying each director's name"
      end
    end
  end
end

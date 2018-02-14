require "rails_helper"


describe "/directors" do
  it "displays each director's name and dob", points: 5 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")

    visit "/directors"

    directors = Director.all
    directors.each do |director|
      expect(page).to have_content(director.name)
      expect(page).to have_content(director.dob)
    end
  end
end

describe "/directors/[DIRECTOR ID]" do
  it "displays a functional delete link for each director", points: 5, hint: h("copy_must_match")  do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")

    directors = Director.all

    directors.each do |director|
      visit "/directors/#{director.id}"
      count_of_directors = Director.count
      click_link 'Delete', match: :first
      expect(Director.count).to eq(count_of_directors - 1)
    end
  end
end

describe "/directors/[DIRECTOR ID]" do
  it "displays a count of the director's movies", points: 5 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    directors = Director.all

    directors.each do |director|
      visit "/directors/#{director.id}"
      count_of_movies = Movie.where(director_id: director.id).count
      expect(page).to have_content(count_of_movies)
    end
  end
end

describe "/directors/[DIRECTOR ID]" do
  it "displays a list of the director's movies", points: 5 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    departed = create(:movie, title: "The Departed", year: 2006, duration: 151, director_id: scorsese.id)
    goodfellas = create(:movie, title: "Goodfellas", year: 1990, duration: 146, director_id: scorsese.id)

    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")
    dark_knight = create(:movie, title: "The Dark Knight", year: 2008, duration: 152, director_id: nolan.id)
    inception = create(:movie, title: "Inception", year: 2010, duration: 148, director_id: nolan.id)

    directors = Director.all

    directors.each do |director|
      visit "/directors/#{director.id}"
      movies = Movie.where(director_id: director.id)
      movies.each do |movie|
        expect(page).to have_content(movie.title)
      end
    end
  end
end

describe "/directors/[DIRECTOR ID]" do
  it "displays a form to add a new movie", points: 2 do
    scorsese = create(:director, name: "Martin Scorsese", dob: "November 17, 1942")
    nolan = create(:director, name: "Christopher Nolan", dob: "July 30, 1970")

    directors = Director.all
    directors.each do |director|
      visit "/directors/#{director.id}"
      expect(page).to have_selector("form", count: 1)
    end
  end
end

describe "/directors/[DIRECTOR ID]" do
  it "creates a new movie for the director after submitting the form", points: 10, hint: h("copy_must_match") do
    george_miller = create(:director, name: "George Miller", dob: "March 3, 1945")

    visit "/directors/#{george_miller.id}"

    expect(page).to have_selector("form")

    count_of_movies = Movie.where(director_id: george_miller.id).count

    fill_in 'Title', with: 'Mad Max: Fury Road'
    fill_in 'Year', with: 2015
    click_button 'Create movie'

    expect(Movie.where(director_id: george_miller.id).count).to eq(count_of_movies + 1)
  end
end

describe "/directors/[DIRECTOR ID]" do
  it "displays a hidden input field to associate a new movie to the director", points: 10 do
    directors = Director.all
    directors.each do |director|
      visit "/directors/#{director.id}"
      expect(page).to have_selector("input[value='#{director.id}']", visible: false),
        "expected to find a hidden input field with the director's id as the value"
    end
  end
end

describe "/directors/new" do
  it 'creates a new director after submitting the form', points: 5, hint: h("copy_must_match") do
    visit "/directors/new"

    expect(page).to have_selector("form")

    count_of_directors = Director.count

    fill_in 'Name', with: 'George Miller'
    fill_in 'Dob', with: 'March 3, 1945'
    click_button 'Create director'

    new_count_of_directors = count_of_directors + 1
    expect(Director.count).to eq(new_count_of_directors)
  end
end

describe "/directors/[DIRECTOR ID]/edit" do
  it "updates a director's data after submitting the form", points: 5 do
    hitchcock = create(:director, name: "Alfred Hitchcock", dob: "August 13, 1899")
    expect(hitchcock.bio).to be_nil

    visit "/directors/#{hitchcock.id}/edit"

    bio = 'Sir Alfred Joseph Hitchcock was an English film director and producer, at times referred to as "The Master of Suspense".'
    fill_in 'Name', with: 'Sir Alfred Joseph Hitchcock'
    fill_in 'Bio', with: bio
    click_button 'Update director'

    hitchcock.reload
    expect(hitchcock.name).to eq('Sir Alfred Joseph Hitchcock')
    expect(hitchcock.bio).to eq(bio)
  end
end

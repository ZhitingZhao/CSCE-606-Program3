
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end


When /I go to the edit page for "(.*)"/ do |movie|
  movie = Movie.find_by title: movie
  visit edit_movie_path(movie)
end
When /I fill in "(.*)" with "(.*)"/ do |str1, str2|
  fill_in(str1, with: str2)
end

When /I press "(.*)"/ do |str|
  click_button(str)
end

Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
  expect(page).to have_content("Details about #{movie}")
  expect(page).to have_content("Director: #{director}")
end

Given /I am on the details page for "(.*)"/ do |movie|
  movie = Movie.find_by title: movie
  visit movie_path(movie)
end

Then /I should be on the Similar Movies page for "(.*)"/ do |movie_title|
  movie = Movie.find_by title: movie_title
  expect(page).to have_current_path(same_director_path(movie))
end

Then /I should be see "(.*)"/ do |str|
  expect(page).to have_content(str)
end

Then /I should not see "(.*)"/ do |str|
  expect(page).not_to have_content(str)
end

Then /I should be on the home page/ do
  expect(page).to have_current_path(movies_path)
end


When /I follow "(.*)"/ do |str|
  click_link(str)
end

When /I go to the new page/ do
  visit new_movie_path
end


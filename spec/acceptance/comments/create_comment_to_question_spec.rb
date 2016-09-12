require_relative '../acceptance_helper'

feature 'Create comment to question', %q{
  In order to supplement question
  As an authenticated user
  I want to be able to create comment to question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Authenticated user create comment with valid attributes', js: true do
    sign_in(user)
    visit question_path(question)
    
    click_on('Add comment')
    fill_in 'comment_body', with: 'test comment'
    click_on('Save comment')
    
    expect(page).to have_content 'test comment'
    expect(current_path).to eq question_path(question)
  end

  scenario 'Authenticated user create commnent with empty body', js: true do
    sign_in(user)
    visit question_path(question)
    
    click_on('Add comment')
    fill_in 'comment_body', with: ''
    click_on('Save comment')
    
    expect(page).to have_content "Body can't be blank"
    expect(current_path).to eq question_path(question)
  end

  scenario 'Non-authenticated user ties to create answer to question' do
    visit question_path(question)
    
    expect(page).to have_no_link('Add comment')
  end
end

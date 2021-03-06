require_relative '../acceptance_helper'

feature 'Editing comment to question', %q{
  In order to fix mistake
  As an author of answer
  I would like to be able to edit my comment
} do

  given(:user) { create(:user) }
  given(:alien) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:comment) { create(:comment, commentable: question, user: user) }

  scenario 'Author edit own comment', js: true do
    sign_in(user)
    visit question_path(question)
    
    within "#comment-#{ comment.id }" do
      click_on('Edit')
      fill_in 'comment_body', with: 'new test comment'
      click_on('Save')
    end
    
    expect(page).to have_content 'new test comment'
    expect(current_path).to eq question_path(question)
  end

  scenario 'Author edit commnent with empty body', js: true do
    sign_in(user)
    visit question_path(question)
    
    within "#comment-#{ comment.id }" do
      click_on('Edit')
      fill_in 'comment_body', with: ''
      click_on('Save')
    end
    
    expect(page).to have_content "Body can't be blank"
    expect(current_path).to eq question_path(question)
  end

  scenario 'Alien tries to edit comment' do
    sign_in(alien)
    visit question_path(question)
    
    within "#comment-#{ comment.id }" do
      expect(page).to have_no_link('Edit')
    end
  end

  scenario 'Non-authenticated user tries to edit comment' do
    visit question_path(question)
    
    within "#comment-#{ comment.id }" do
      expect(page).to have_no_link('Edit')
    end
  end
end

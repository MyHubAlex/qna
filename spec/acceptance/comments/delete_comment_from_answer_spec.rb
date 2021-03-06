require_relative '../acceptance_helper'

feature 'Delete comment from answer', %q{
  In order considered unnecessary comment
  As an author of comment
  I would like to be able to delete my comment
} do

  given(:user) { create(:user) }
  given(:alien) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:comment) { create(:comment, commentable: question, user: user) }

  scenario 'Author tries delete own comment', js: true do
    sign_in(user)
    visit question_path(question)
    
    within "#comment-#{ comment.id }" do
      click_on('Delete')
    end
    
    expect(page).to have_no_content comment.body
    expect(current_path).to eq question_path(question)
  end

  scenario 'Alien tries to delete comment from answer' do
    sign_in(alien)
    visit question_path(question)
    
    within "#comment-#{ comment.id }" do
      expect(page).to have_no_link('Delete')
    end
  end

  scenario 'Non-authenticated user tries to delete comment from answer' do
    visit question_path(question)
    
    within "#comment-#{ comment.id }" do
      expect(page).to have_no_link('Delete')
    end
  end
end

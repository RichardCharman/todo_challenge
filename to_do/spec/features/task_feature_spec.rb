require 'rails_helper'

feature 'tasks' do
  context 'no tasks have been added' do
    scenario 'should display a prompt to add a task' do
      visit '/tasks'
      expect(page).to have_content 'No tasks to do'
      expect(page).to have_link 'Add a task'
    end
  end
  context 'task has been added' do
    before do
      Task.create(name: 'Buy milk')
    end

    scenario 'display tasks' do
      visit '/tasks'
      expect(page).to have_content('Buy milk')
      expect(page).not_to have_content('No tasks to do')
    end
  end
  context 'adding a task' do
    scenario 'prompts user to fill out a form, then displays the task' do
      visit '/tasks'
      click_link 'Add a task'
      fill_in 'Name', with: 'Buy milk'
      click_button 'Create Task'
      expect(page).to have_content 'Buy milk'
      expect(current_path).to eq '/tasks'
    end
  end
  context 'editing tasks' do

    before {Task.create name: 'Buy milk'}

    scenario 'lets a user edit a task' do
     visit '/tasks'
     click_link 'Edit'
      fill_in 'Name', with: 'Buy 2 pints of milk'
     click_button 'Update Task'
     expect(page).to have_content 'Buy 2 pints of milk'
     expect(current_path).to eq '/tasks'
    end
  end
  context 'deleting tasks' do

  before {Task.create name: 'Buy milk'}

  scenario 'removes a task when a user clicks a delete link' do
    visit '/tasks'
    click_link 'Delete'
    expect(page).not_to have_content 'Buy milk'
    expect(page).to have_content 'Task deleted successfully'
  end

end
end
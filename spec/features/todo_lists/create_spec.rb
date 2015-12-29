require 'spec_helper'

describe "Creating todo lists" do 
	it "redirects to todo list page on success" do
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")
		
		fill_in "Title", with: "My todo list"
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create Todo list"

		expect(page).to have_content("My todo list")
	end

	it "displays an error when the todo list as no title" do
		expect(TodoList.count).to eq(0)
		
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: ''
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

	it "displays an error when the tite has less than 3 characters" do
		expect(TodoList.count).to eq(0)
		
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: 'Hi'
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end
	
	it "displays an error when the todo list as no description" do
		expect(TodoList.count).to eq(0)
		
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: 'Grocery List'
		fill_in "Description", with: ""
		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content('Grocery List')
	end

	it "displays an error when the todo list has less than 5 char description" do
		expect(TodoList.count).to eq(0)
		
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: 'Grocery List'
		fill_in "Description", with: "Food"
		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content('Grocery List')
	end

end

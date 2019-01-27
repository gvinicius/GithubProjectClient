# frozen_string_literal: true

require 'test_helper'

class ProjectEntriesControllerTest < ActionController::TestCase
  setup do
    @project_entry = project_entries(:one)
  end

  test 'should get index' do
    get :default_search'
    assert_redirected_to project_entries_path
  end

  test 'perform the default ' do
    get :index
    assert_response :success
  end

  test 'should do a search in github' do
    get :search, term: 'ruby', :format => 'js'
    assert_not_nil assigns(:project_entries)
  end
end
